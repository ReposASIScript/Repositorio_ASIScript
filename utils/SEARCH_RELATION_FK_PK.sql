SET LINESIZE 2000
SET ECHO OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\search_relation_fk_pk.html
SHOW USER

  SELECT con.table_name "Tabla Hija",
         con.constraint_name "Llave Foranea",
         qry.table_name "Tabla Padre",
         qry.constraint_name "Llave Primaria"
    FROM all_constraints con, all_constraints qry
   WHERE con.owner           = qry.owner
     AND qry.constraint_name = con.r_constraint_name
     AND con.owner           = NVL(UPPER('&Usuario_Duenio'),USER)
     AND con.table_name      = UPPER('&Tabla_Hija')
ORDER BY 1, 2;
/

SPOOL OFF
SET MARKUP HTML OFF
SET ECHO ON
HOST c:\search_relation_fk_pk.html