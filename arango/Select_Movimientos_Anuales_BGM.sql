  SELECT usuario, numero_movimiento, fecha_movimiento,
         SUM(DECODE(debito_credito,'D',DECODE(codigo_moneda,1,monto_movimiento,monto_movimiento_local),
                                   'C',DECODE(codigo_moneda,1,ABS(monto_movimiento)*-1,ABS(monto_movimiento_local)*-1)))
    FROM gm_movimientos_anual_detalle 
GROUP BY usuario, numero_movimiento, fecha_movimiento;