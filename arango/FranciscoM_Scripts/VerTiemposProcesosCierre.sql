select a.fecha, a.linea, a.texto
from mg_log_proceso a, mg_calendario c
where a.codigo_aplicacion = 'BPR'
and c.codigo_aplicacion = a.codigo_aplicacion
--and trunc(a.fecha) = c.fecha_cierre
and (a.texto like '[T]* Finaliza proceso de Preparacion tabla de Log2%' or
     a.texto like '[T]*Tiempo de Ejecucion%')
union
select a.fecha, a.linea, substr(a.texto,1,33)||' '||b.descripcion||' '||substr(texto,34) detalle
from mg_log_proceso a, mg_control_procesos b, mg_calendario c
where b.codigo_aplicacion = 'BPR'
and c.codigo_aplicacion = a.codigo_aplicacion
and b.codigo_aplicacion = a.codigo_aplicacion
and b.numero_proceso = to_number(substr(a.texto,32,2))
--and trunc(a.fecha) = c.fecha_cierre
and a.texto like '[T]..TIEMPO EJECUCION PROCESO%'
order by 2;
