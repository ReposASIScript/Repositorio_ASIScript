SET LINESIZE 2000
SET ECHO OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\search_column.html
SHOW USER

  SELECT col.table_name nombre_de_tabla,
         col.column_name nombre_de_columna,
         DECODE(col.data_type, 'VARCHAR2', col.data_type||'('||TO_CHAR(col.data_length)||')',
                               'NUMBER'  , col.data_type||'('||TO_CHAR(col.data_precision)||','||TO_CHAR(col.data_scale)||')',
                               'DATE'    , col.data_type, col.data_type) tipo_de_dato
    FROM all_tab_columns col
   WHERE col.owner = UPPER(NVL('&usuario_duenio',USER))
     AND UPPER(col.column_name) LIKE '%'||UPPER('&nombre_de_columna')||'%'
ORDER BY col.table_name
/

SPOOL OFF
SET MARKUP HTML OFF
SET ECHO ON
HOST c:\search_column.html