SET LINESIZE 2000
SET ECHO OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\search_db.html
SHOW USER
DEFINE _CONNECT_IDENTIFIER

  SELECT src.name nombre_api, src.line linea_de_codigo, src.text seccion_codigo
    FROM all_source src
   WHERE src.owner = UPPER(NVL('&usuario_duenio',USER))
     AND UPPER(src.text) LIKE '%'||UPPER('&texto_a_buscar')||'%'
ORDER BY src.name, src.line
/

SPOOL OFF
SET MARKUP HTML OFF
SET ECHO ON
HOST c:\search_db.html