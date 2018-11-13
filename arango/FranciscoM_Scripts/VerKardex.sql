SELECT a.fecha_valida fecha, /*a.fecha_hora,*/ a.secuencia, a.codigo_usuario usuario, a.codigo_operacion ope,
a.codigo_tipo_transaccion trx, a.movimientos_relacionados mov_rel, a.monto_anterior base_calculo, a.numero_cuotas_ant cuota,
b.codigo_tipo_saldo saldo, b.codigo_tipo_saldo_final s_final, b.valor, a.estado_movimiento est,
decode(nvl(a.estado_cartera_ant,a.estado_cartera_act),a.estado_cartera_act,a.estado_cartera_act,
a.estado_cartera_ant||'-'||a.estado_cartera_act) cartera
FROM pr_movimientos a, pr_saldos_movimiento b
WHERE b.fecha_valida (+) = a.fecha_valida
AND b.secuencia (+) = a.secuencia
AND b.codigo_usuario (+) = a.codigo_usuario
AND a.numero_prestamo = nvl(&prestamo,a.numero_prestamo)
AND a.codigo_operacion = nvl(&operacion,a.codigo_operacion)
AND a.codigo_tipo_transaccion = nvl(&transaccion,a.codigo_tipo_transaccion)
--AND a.estado_movimiento in ('1','2')
--AND a.fecha_valida <= to_date('&fechahasta','dd-mm-yyyy')
--AND (b.codigo_tipo_saldo in (2,38) or b.codigo_tipo_saldo_final in (2,38))
--AND (b.codigo_tipo_saldo_final = 33 or b.codigo_tipo_saldo = 5)
--AND a.numero_cuotas_ant >= 16
--AND a.codigo_usuario != 'GLOBOKAS'
ORDER BY 1,2;