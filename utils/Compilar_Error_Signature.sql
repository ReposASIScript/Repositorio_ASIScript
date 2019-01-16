/*
Para errores:
- Unable to adjust form for output
- Signature of package has changed
Que se recompilaba forzado toda la Base de Datos.

Se debe correr el siguiente query con el sys de la base de datos y genera los que hay que recompilar.(Funciono con Unable adjust falta validar con el otro error)
*/

Select 'alter '||do.object_type||' ' || owner || '.'||do.object_name||' compile;'
from dba_objects do,diana_version$ dv
where dv.obj#=do.object_id
and do.timestamp <> to_char(dv.stime,'YYYY-MM-DD:HH24:MI:SS')
/