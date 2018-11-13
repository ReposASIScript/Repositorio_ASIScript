-- Validador de integridad de saldos de prestamos con plan pago
-- Created by FranciscoM. on January, 2013
/* Caso 1: Existe en saldos prestamo y plan pago (descuadre de saldos) */
select p.numero_prestamo prestamo, p.codigo_tipo_amortizacion amortizacion,
a.codigo_tipo_saldo tipo_saldo, t.descripcion, a.valor valor_prestamo,
sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) valor_plan,
'CASO 1: DESCUADRE DE SALDOS' observacion
from pr_prestamos p, pr_saldos_prestamo a, pr_saldos_plan_pago b, pr_plan_pago d, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and b.codigo_empresa = a.codigo_empresa
and b.codigo_agencia = a.codigo_agencia
and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
and b.numero_prestamo = a.numero_prestamo
and b.codigo_tipo_saldo = a.codigo_tipo_saldo
and d.codigo_empresa = b.codigo_empresa
and d.codigo_agencia = b.codigo_agencia
and d.codigo_sub_aplicacion = b.codigo_sub_aplicacion
and d.numero_prestamo = b.numero_prestamo
and d.numero_cuota = b.numero_cuota
and nvl(d.pagado,'N') = 'N'
and p.estado = '1'
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and a.codigo_tipo_saldo not in (1,73,81)
and a.codigo_tipo_saldo not in (select codigo_tipo_saldo from pr_tipo_saldo_subaplicacion
                                where codigo_empresa = a.codigo_empresa
                                and codigo_sub_aplicacion = a.codigo_sub_aplicacion
                                and nvl(ubicacion_contable,'A') = 'P')
and a.codigo_tipo_saldo not in (select codigo_tipo_saldo from pr_saldos_operacion
                                where codigo_operacion = 15 and codigo_tipo_transaccion in (8,18,28)
                                and prioridad = 1)
--and nvl(&caso,1) = 1
group by p.numero_prestamo, p.codigo_tipo_amortizacion, a.codigo_tipo_saldo, t.descripcion, a.valor
having a.valor != sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) and
    not(nvl(a.valor,0) = 0 and sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) = 0)
union
/* Caso 2: Existe en saldos prestamo y no en plan pago (descuadre de saldos) */
select p.numero_prestamo, p.codigo_tipo_amortizacion,
a.codigo_tipo_saldo, t.descripcion, a.valor, null,
'CASO 2: DESCUADRE DE SALDO - NO EXISTE EN PLAN PAGOS' observacion
from pr_prestamos p, pr_saldos_prestamo a, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and a.codigo_tipo_saldo not in (1,73,81)
and nvl(p.cuotas_creadas,0) != 0
and a.codigo_tipo_saldo not in (select codigo_tipo_saldo from pr_tipo_saldo_subaplicacion
                                where codigo_empresa = a.codigo_empresa
                                and codigo_sub_aplicacion = a.codigo_sub_aplicacion
                                and nvl(ubicacion_contable,'A') = 'P')
and a.codigo_tipo_saldo not in (select codigo_tipo_saldo from pr_saldos_operacion
                                where codigo_operacion = 15 and codigo_tipo_transaccion in (8,18,28)
                                and prioridad = 1)
and nvl(a.valor,0) != 0
and p.estado = '1'
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and not exists (select 1 from pr_saldos_plan_pago b, pr_plan_pago d
                where d.codigo_empresa = b.codigo_empresa
                  and d.codigo_agencia = b.codigo_agencia
                  and d.codigo_sub_aplicacion = b.codigo_sub_aplicacion
                  and d.numero_prestamo = b.numero_prestamo
                  and d.numero_cuota = b.numero_cuota
                  and nvl(d.pagado,'N') = 'N'
                  and b.codigo_empresa = a.codigo_empresa
                  and b.codigo_agencia = a.codigo_agencia
                  and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
                  and b.numero_prestamo = a.numero_prestamo
                  and b.codigo_tipo_saldo = a.codigo_tipo_saldo)
--and nvl(&caso,2) = 2
union
/* Caso 3: Existe en saldos plan pago y no en saldos prestamo (descuadre de saldos) */
select p.numero_prestamo, p.codigo_tipo_amortizacion,
a.codigo_tipo_saldo, t.descripcion, null,
sum(a.valor-nvl(a.valor_pagado,0)),
'CASO 3: DESCUADRE DE SALDO - NO EXISTE EN PRESTAMO' observacion
from pr_prestamos p, pr_saldos_plan_pago a, pr_plan_pago b, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and b.codigo_empresa = a.codigo_empresa
and b.codigo_agencia = a.codigo_agencia
and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
and b.numero_prestamo = a.numero_prestamo
and b.numero_cuota = a.numero_cuota
and nvl(b.pagado,'N') = 'N'
and p.estado = '1'
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and a.codigo_tipo_saldo != 1
and a.codigo_tipo_saldo not in (select codigo_tipo_saldo from pr_tipo_saldo_subaplicacion
                                where codigo_empresa = a.codigo_empresa
                                and codigo_sub_aplicacion = a.codigo_sub_aplicacion
                                and nvl(ubicacion_contable,'A') = 'P')
and a.codigo_tipo_saldo not in (select codigo_tipo_saldo from pr_saldos_operacion
                                where codigo_operacion = 15 and codigo_tipo_transaccion in (8,18,28)
                                and prioridad = 1)
and not exists (select 1 from pr_saldos_prestamo
                where codigo_empresa = a.codigo_empresa
                  and codigo_agencia = a.codigo_agencia
                  and codigo_sub_aplicacion = a.codigo_sub_aplicacion
                  and numero_prestamo = a.numero_prestamo
                  and codigo_tipo_saldo = a.codigo_tipo_saldo)
--and nvl(&caso,3) = 3
group by p.numero_prestamo, p.codigo_tipo_amortizacion, a.codigo_tipo_saldo, t.descripcion
having not(sum(a.valor-nvl(a.valor_pagado,0)) = 0)
union
/* Caso 4: Existe en saldos plan pago (saldo plan pago errado) */
select p.numero_prestamo, p.codigo_tipo_amortizacion,
a.codigo_tipo_saldo, t.descripcion, null,
sum(a.valor-nvl(a.valor_pagado,0)),
'CASO 4: SALDO NO PERMITIDO EN PLAN PAGOS - ' observacion
from pr_prestamos p, pr_saldos_plan_pago a, pr_plan_pago b, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and b.codigo_empresa = a.codigo_empresa
and b.codigo_agencia = a.codigo_agencia
and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
and b.numero_prestamo = a.numero_prestamo
and b.numero_cuota = a.numero_cuota
and nvl(b.pagado,'N') = 'N'
and p.estado = '1'
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and (a.codigo_tipo_saldo in (select codigo_tipo_saldo from pr_tipo_saldo_subaplicacion
                             where codigo_empresa = a.codigo_empresa
                             and codigo_sub_aplicacion = a.codigo_sub_aplicacion
                             and nvl(ubicacion_contable,'A') = 'P') or
     a.codigo_tipo_saldo in (select codigo_tipo_saldo from pr_saldos_operacion
                             where codigo_operacion = 15 and codigo_tipo_transaccion in (8,18,28)
                             and prioridad = 1))
--and nvl(&caso,4) = 4
group by p.numero_prestamo, p.codigo_tipo_amortizacion, a.codigo_tipo_saldo, t.descripcion
having not(sum(a.valor-nvl(a.valor_pagado,0)) = 0)
union
/* Caso 5: Existe en saldos prestamo y plan pago (excedente en plan pago de saldo capital / interes prorrateado) */
select p.numero_prestamo prestamo, p.codigo_tipo_amortizacion amortizacion,
a.codigo_tipo_saldo tipo_saldo, t.descripcion, a.valor valor_prestamo,
sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) valor_plan,
'CASO 5: SALDO PLAN PAGO EXCEDE SALDO DEL PRESTAMO' observacion
from pr_prestamos p, pr_saldos_prestamo a, pr_saldos_plan_pago b, pr_plan_pago d, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and b.codigo_empresa = a.codigo_empresa
and b.codigo_agencia = a.codigo_agencia
and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
and b.numero_prestamo = a.numero_prestamo
and b.codigo_tipo_saldo = a.codigo_tipo_saldo
and d.codigo_empresa = b.codigo_empresa
and d.codigo_agencia = b.codigo_agencia
and d.codigo_sub_aplicacion = b.codigo_sub_aplicacion
and d.numero_prestamo = b.numero_prestamo
and d.numero_cuota = b.numero_cuota
and nvl(d.pagado,'N') = 'N'
and p.estado = '1'
and p.codigo_tipo_amortizacion not in ('1','5')
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and a.codigo_tipo_saldo in (1,73,81)
and a.valor != 0
--and nvl(&caso,5) = 5
group by p.numero_prestamo, p.codigo_tipo_amortizacion, a.codigo_tipo_saldo, t.descripcion, a.valor
having a.valor < sum(nvl(b.valor,0)-nvl(b.valor_pagado,0))
union
/* Caso 6: Amortizacion 1 y 5, Existe en saldos prestamo y plan pago (descuadre de saldo capital / interes prorrateado) */
select p.numero_prestamo prestamo, p.codigo_tipo_amortizacion amortizacion,
a.codigo_tipo_saldo tipo_saldo, t.descripcion, a.valor valor_prestamo,
sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) valor_plan,
'CASO 6: DESCUADRE DE SALDO' observacion
from pr_prestamos p, pr_saldos_prestamo a, pr_saldos_plan_pago b, pr_plan_pago d, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and b.codigo_empresa = a.codigo_empresa
and b.codigo_agencia = a.codigo_agencia
and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
and b.numero_prestamo = a.numero_prestamo
and b.codigo_tipo_saldo = a.codigo_tipo_saldo
and d.codigo_empresa = b.codigo_empresa
and d.codigo_agencia = b.codigo_agencia
and d.codigo_sub_aplicacion = b.codigo_sub_aplicacion
and d.numero_prestamo = b.numero_prestamo
and d.numero_cuota = b.numero_cuota
and nvl(d.pagado,'N') = 'N'
and p.estado = '1'
and p.codigo_tipo_amortizacion in ('1','5')
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and a.codigo_tipo_saldo in (1,73,81)
--and nvl(&caso,6) = 6
group by p.numero_prestamo, p.codigo_tipo_amortizacion, a.codigo_tipo_saldo, t.descripcion, a.valor
having a.valor != sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) and
    not(nvl(a.valor,0) = 0 and sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) = 0)
union
/* Caso 7: Amortizacion 1 y 5, Existe en saldos prestamo y no en plan pago (descuadre de saldo capital) */
select p.numero_prestamo, p.codigo_tipo_amortizacion,
a.codigo_tipo_saldo, t.descripcion, a.valor, null,
'CASO 7: DESCUADRE DE SALDO CAPITAL - NO EXISTE EN PLAN PAGOS' observacion
from pr_prestamos p, pr_saldos_prestamo a, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and a.codigo_tipo_saldo = 1
and nvl(a.valor,0) != 0
and p.estado = '1'
and p.codigo_tipo_amortizacion in ('1','5')
and nvl(p.cuotas_creadas,0) != 0
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and not exists (select 1 from pr_saldos_plan_pago b, pr_plan_pago d
                where d.codigo_empresa = b.codigo_empresa
                  and d.codigo_agencia = b.codigo_agencia
                  and d.codigo_sub_aplicacion = b.codigo_sub_aplicacion
                  and d.numero_prestamo = b.numero_prestamo
                  and d.numero_cuota = b.numero_cuota
                  and nvl(d.pagado,'N') = 'N'
                  and b.codigo_empresa = a.codigo_empresa
                  and b.codigo_agencia = a.codigo_agencia
                  and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
                  and b.numero_prestamo = a.numero_prestamo
                  and b.codigo_tipo_saldo = a.codigo_tipo_saldo)
--and nvl(&caso,7) = 7
union
/* Caso 8: Amortizacion 1 y 5, Existe en saldos plan pago y no en saldos prestamo (descuadre de saldo capital) */
select p.numero_prestamo, p.codigo_tipo_amortizacion,
a.codigo_tipo_saldo, t.descripcion, null,
sum(a.valor-nvl(a.valor_pagado,0)),
'CASO 8: DESCUADRE DE SALDO CAPITAL - NO EXISTE EN PRESTAMO' observacion
from pr_prestamos p, pr_saldos_plan_pago a, pr_plan_pago b, pr_tipos_saldo t
where t.codigo_tipo_saldo = a.codigo_tipo_saldo
and a.codigo_empresa = p.codigo_empresa
and a.codigo_agencia = p.codigo_agencia
and a.codigo_sub_aplicacion = p.codigo_sub_aplicacion
and a.numero_prestamo = p.numero_prestamo
and b.codigo_empresa = a.codigo_empresa
and b.codigo_agencia = a.codigo_agencia
and b.codigo_sub_aplicacion = a.codigo_sub_aplicacion
and b.numero_prestamo = a.numero_prestamo
and b.numero_cuota = a.numero_cuota
and nvl(b.pagado,'N') = 'N'
and p.estado = '1'
and p.codigo_tipo_amortizacion in ('1','5')
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
and a.codigo_tipo_saldo = 1
and not exists (select 1 from pr_saldos_prestamo
                where codigo_empresa = a.codigo_empresa
                  and codigo_agencia = a.codigo_agencia
                  and codigo_sub_aplicacion = a.codigo_sub_aplicacion
                  and numero_prestamo = a.numero_prestamo
                  and codigo_tipo_saldo = a.codigo_tipo_saldo)
--and nvl(&caso,8) = 8
group by p.numero_prestamo, p.codigo_tipo_amortizacion, a.codigo_tipo_saldo, t.descripcion
having not(sum(a.valor-nvl(a.valor_pagado,0)) = 0)
union
/* Caso 9: Existe en saldos prestamo y plan pago (prestamos cancelado) */
select p.numero_prestamo prestamo, p.codigo_tipo_amortizacion amortizacion,
a.codigo_tipo_saldo tipo_saldo,
(select descripcion from pr_tipos_saldo where codigo_tipo_saldo = a.codigo_tipo_saldo) descripcion, 
a.valor valor_prestamo,
sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) valor_plan,
(case when nvl(a.valor,0) != 0 and sum(nvl(b.valor,0)-nvl(b.valor_pagado,0))  = 0 then 'CASO 8: CANCELADO CON SALDO PENDIENTE EN PRESTAMO'
      when nvl(a.valor,0)  = 0 and sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) != 0 then 'CASO 8: CANCELADO CON SALDO PENDIENTE EN PLAN PAGOS'
      else 'CASO 8: CANCELADO CON SALDOS PENDIENTES' end) observacion
from pr_prestamos p, pr_saldos_prestamo a, pr_saldos_plan_pago b, pr_plan_pago d
where a.codigo_empresa (+) = p.codigo_empresa
and a.codigo_agencia (+) = p.codigo_agencia
and a.codigo_sub_aplicacion (+) = p.codigo_sub_aplicacion
and a.numero_prestamo (+) = p.numero_prestamo
and b.codigo_empresa (+) = a.codigo_empresa
and b.codigo_agencia (+) = a.codigo_agencia
and b.codigo_sub_aplicacion (+) = a.codigo_sub_aplicacion
and b.numero_prestamo (+) = a.numero_prestamo
and b.codigo_tipo_saldo (+) = a.codigo_tipo_saldo
and d.codigo_empresa (+) = b.codigo_empresa
and d.codigo_agencia (+) = b.codigo_agencia
and d.codigo_sub_aplicacion (+) = b.codigo_sub_aplicacion
and d.numero_prestamo (+) = b.numero_prestamo
and d.numero_cuota (+) = b.numero_cuota
and nvl(d.pagado (+) ,'N') = 'N'
and p.estado = '2'
and p.numero_prestamo = nvl(&prestamo,p.numero_prestamo)
--and nvl(&caso,9) = 9
group by p.numero_prestamo, p.codigo_tipo_amortizacion, a.codigo_tipo_saldo, /*t.descripcion,*/ a.valor
having not(nvl(a.valor,0) =0 and sum(nvl(b.valor,0)-nvl(b.valor_pagado,0)) = 0)
order by 1;
