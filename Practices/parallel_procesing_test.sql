  SELECT /*+ parallel(c,4) */ *
    FROM mg_clientes c
ORDER BY c.primer_apellido, c.segundo_apellido, c.nombres
/
  SELECT *
    FROM mg_clientes c
ORDER BY c.primer_apellido, c.segundo_apellido, c.nombres
/