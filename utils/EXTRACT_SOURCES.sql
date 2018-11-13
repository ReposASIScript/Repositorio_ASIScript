SET LINESIZE 2000
SET ECHO OFF
SET HEADING OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\extract_sources.html
SHOW USER

SELECT src.text
  FROM all_source src
 WHERE src.owner = UPPER(NVL('&usuario_duenio',USER))
   AND src.name  = UPPER(NVL('&nombre_api',src.name))
/

SPOOL OFF
SET MARKUP HTML OFF
SET HEADING ON
SET ECHO ON
HOST c:\extract_sources.html