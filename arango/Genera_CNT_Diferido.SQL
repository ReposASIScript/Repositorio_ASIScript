execute nt_p_genera_diferido(&CODIGO_EMPRESA)
set heading off
set linesize 132
set feedback off
--host rm diferido_generado.sql
spool c:\temp\dif98.sql
set term off
select linea from nt_codigo_diferido_generado order by numero_linea
/

--set term on
spool off
set linesize 80
set heading on
set feedback on
--start diferido_generado7