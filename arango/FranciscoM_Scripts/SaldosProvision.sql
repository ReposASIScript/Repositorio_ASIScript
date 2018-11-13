select b.numero_cuotas_ant cuota, a.codigo_tipo_saldo, a.codigo_tipo_saldo_final, sum(a.valor) valor
from pr_saldos_movimiento a, pr_movimientos b
where b.fecha_valida = a.fecha_valida
and b.secuencia = a.secuencia
and b.codigo_usuario = a.codigo_usuario
and b.codigo_empresa = 1
and b.codigo_agencia = 100
and b.codigo_sub_aplicacion = 33
and b.numero_prestamo = 1376949
and b.numero_cuotas_ant >= 16
and b.codigo_operacion = 15 and b.codigo_tipo_transaccion = 20
group by b.numero_cuotas_ant, a.codigo_tipo_saldo, a.codigo_tipo_saldo_final
order by 1,2,3;