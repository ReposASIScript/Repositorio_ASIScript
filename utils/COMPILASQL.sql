/* Script para generar alter compile de todos los stored procedures que posee un dueño de esquema determinado. */

SET HEADING OFF
SPOOL '&ruta_script'

  SELECT 'PROMPT Compilando '||DECODE(obj.object_type,'PACKAGE','Paquete',
                                                      'PACKAGE BODY','Cuerpo del Paquete',
                                                      'PROCEDURE','Procedimiento',
                                                      'FUNCTION','Funcion',
                                                      'TRIGGER','Disparador',
                                                      'VIEW','Vista',
                                                      'MATERIALIZED VIEW','Vista Materializada')||' '||obj.object_name||CHR(10)||
         'ALTER '||DECODE(obj.object_type,'PACKAGE BODY','PACKAGE',obj.object_type)||' '||
                          obj.owner||'.'||obj.object_name||' COMPILE '||DECODE(obj.object_type,'PACKAGE BODY','BODY;',';')||CHR(10)||
         'SHOW ERRORS'
    FROM all_objects obj
   WHERE obj.owner        = NVL(UPPER('&owner_objects'),USER)
     AND obj.status       = NVL(UPPER('&status_object'),status)
     AND obj.object_type IN ('PACKAGE','PACKAGE BODY','PROCEDURE','FUNCTION','TRIGGER','VIEW','MATERIALIZED VIEW')
ORDER BY obj.created ASC
/

SPOOL OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\temp\resultado.html
SHOW USER
@'&ruta_script'

  SELECT 'Existen '||TO_CHAR(count(*))||' Objetos Invalidos'
    FROM all_objects obj
   WHERE obj.status       = 'INVALID'
     AND obj.owner        = NVL(UPPER('&owner_objects'),USER)
     AND obj.object_type IN ('PACKAGE','PACKAGE BODY','PROCEDURE','FUNCTION','TRIGGER','VIEW','MATERIALIZED VIEW')
ORDER BY obj.created
/

SET MARKUP HTML OFF
SPOOL OFF
SET HEADING ON
HOST c:\temp\resultado.html