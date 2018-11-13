SET LINESIZE 2000
SET ECHO OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\search_relations.html
SHOW USER

  SELECT con.table_name pertenece_a_tabla, con.constraint_name restriccion_secundaria, con.r_constraint_name restriccion_principal
    FROM all_constraints con
   WHERE con.owner             = UPPER(NVL('&usuario_duenio',USER))
     AND con.constraint_name   = UPPER(NVL('&restriccion_secundaria',con.constraint_name))
     AND con.r_constraint_name = UPPER(NVL('&restriccion_principal',con.r_constraint_name))
ORDER BY con.table_name, con.constraint_name
/

SPOOL OFF
SET MARKUP HTML OFF
SET ECHO ON
HOST c:\search_relations.html