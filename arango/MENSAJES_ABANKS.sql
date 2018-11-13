SET LINESIZE 2000

  SELECT idi.codigo_mensaje codigo, idi.descripcion mensaje, men.parametro
    FROM mg_mensajes_x_idiomas idi, mg_mensajes men
   WHERE idi.codigo_mensaje = men.codigo
     AND UPPER(idi.descripcion) LIKE '%'||UPPER('&fragmento_de_mensaje')||'%'
ORDER BY 1 DESC
/