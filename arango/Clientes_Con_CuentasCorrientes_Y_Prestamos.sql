  SELECT pre.codigo_cliente, pre.codigo_agencia, pre.codigo_sub_aplicacion, pre.numero_prestamo
    FROM pr_prestamos pre
   WHERE EXISTS (SELECT *
                   FROM cc_depositos_monetarios dep
                  WHERE dep.codigo_cliente = pre.codigo_cliente)
ORDER BY pre.codigo_cliente ASC
/