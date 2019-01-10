execute nt_p_genera_codigo(&CODIGO_EMPRESA)
set heading off
set linesize 132
set feedback off
host del paquete_generado.sql
spool c:\temp\fuente99.sql
set term off
select linea from nt_codigo_fuente_generado order by numero_linea
/
--set term on
--spool off
--host rm forma_generada.sql
--spool forma_generada.sql
--set term off
--select linea from nt_codigo_forma_generado order by numero_linea
--/
set term on
spool off
set linesize 80
set heading on
set feedback on
--start paquete_generado