select max(secuencia) from nr_novedades@nodo.v716.com
/

select ULTIMA_SECUENCIA, INTERVALO, ULTIMA_SECUENCIA_PROC, ESTATUS_PROCEDS,
substr(SQL_ERRM, 1, 75), substr(SQL_ERRM2, 1, 75)
from nr_parametros
/
