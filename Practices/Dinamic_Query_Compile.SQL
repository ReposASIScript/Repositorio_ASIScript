DECLARE
  Ln_OK          NUMBER:=0;
  Ln_ERROR       NUMBER:=0;
  Ln_Compilados  NUMBER:=0;
  --Li_Cursor_Din  INTEGER;
  Lv_Dinamico    VARCHAR2(4000);
  --Lv_exec        VARCHAR2(4000);
  CURSOR C_Obj_Exist IS
    SELECT object_type, object_name
      FROM USER_OBJECTS
     WHERE OBJECT_TYPE IN ('FUNCTION','PROCEDURE','PACKAGE','TRIGGER')
  ORDER BY created;
BEGIN
 /*Este Script Pl/ SQL Permite compilar todos los objetos del esquema presente
 (Incluyendo Objetos Validos)*/

 -- Creador: Gilberto A. Guerrero C.
 -- Fecha: 21-05-2010
 -- IDVERSION0003

  FOR COMP IN C_OBJ_EXIST LOOP
   Ln_Compilados := Ln_Compilados + 1;
   BEGIN 
    Lv_Dinamico := 'ALTER ' ||COMP.object_type||' '||COMP.object_name||' COMPILE';
    EXECUTE IMMEDIATE Lv_Dinamico;
    /*Li_Cursor_Din := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(Li_Cursor_Din, Lv_Dinamico,DBMS_SQL.NATIVE);
    Lv_exec := DBMS_SQL.EXECUTE(Li_Cursor_Din);
    DBMS_SQL.CLOSE_CURSOR(LI_CURSOR_DIN);*/
    Ln_OK := Ln_OK + 1;
   EXCEPTION
     WHEN OTHERS THEN
       LN_ERROR := LN_ERROR + 1;
   END;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Total de Objetos Registrados          : '||LN_COMPILADOS);
  DBMS_OUTPUT.PUT_LINE('Total de Objetos Compilados           : '||LN_OK);
  DBMS_OUTPUT.PUT_LINE('Total de Objetos Compilados con Error : '||LN_ERROR);
END;