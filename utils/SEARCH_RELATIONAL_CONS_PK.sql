SET LINESIZE 2000
SET ECHO OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\search_relational_cons_pk.html
SHOW USER

  SELECT cons.owner              "Dueño del Esquema",
         cons.constraint_name    "Nombre de Llave Foranea",
         cons.table_name         "Nombre de Tabla Hija",
         cols.position           "N° Campo en Llave Foranea",
         cols.column_name        "Nombre de Columna Hija"
    FROM all_constraints  cons,
         all_cons_columns cols
   WHERE cons.owner             = cols.owner
     AND cons.constraint_name   = cols.constraint_name
     AND cons.owner             = NVL(UPPER('&duenio_esquema'),USER)
     AND cons.constraint_type   = 'R'
     AND cons.r_constraint_name = UPPER('&Nombre_PK')
ORDER BY 1, 2, 3, 4
/

SPOOL OFF
SET MARKUP HTML OFF
SET ECHO ON
HOST c:\search_relational_cons_pk.html