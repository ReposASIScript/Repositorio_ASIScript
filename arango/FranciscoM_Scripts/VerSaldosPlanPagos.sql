select a.numero_prestamo prestamo, a.numero_cuota cuota, a.fecha_vence vence, a.pagado, a.fecha_pagada, a.tipo_cuota,
a.codigo_tipo_amortizacion tipo_amort, a.codigo_estado_cartera_cuota cartera, b.codigo_tipo_saldo tipo_saldo,
b.valor, b.valor_pagado pagado, (b.valor - nvl(b.valor_pagado,0)) saldo
from pr_plan_pago a, pr_saldos_plan_pago b
where b.codigo_empresa (+) = a.codigo_empresa
and b.codigo_agencia (+) = a.codigo_agencia
and b.codigo_sub_aplicacion (+) = a.codigo_sub_aplicacion
and b.numero_prestamo (+) = a.numero_prestamo
and b.numero_cuota (+) = a.numero_cuota
and a.numero_prestamo = &prestamo
order by 1,2;

select numero_prestamo, codigo_tipo_saldo, valor, valor_provisionado, adicionado_por, fecha_adicion from pr_saldos_prestamo where numero_prestamo = &prestamo;

select * from pr_prestamos where numero_prestamo = &prestamo;

select * from pr_prestamos where estado = '1' and fecha_proximo_pago_interes < to_date('18-09-2014','dd-mm-yyyy') and fecha_vencimiento > to_date('18-09-2014','dd-mm-yyyy');
