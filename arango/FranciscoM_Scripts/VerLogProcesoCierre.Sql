select l.fecha, l.linea, l.numero_proceso proceso, l.texto
from mg_log_proceso l, mg_calendario c
where c.codigo_aplicacion = 'BPR'
and l.codigo_aplicacion = c.codigo_aplicacion
and l.numero_proceso < 70
and trunc(l.fecha) = c.fecha_cierre
order by 1,2;
