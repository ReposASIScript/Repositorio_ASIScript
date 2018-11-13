SET SERVEROUTPUT ON

DECLARE
  CURSOR c_session (vSchemaName  VARCHAR2, vOSUser  VARCHAR2) IS
    SELECT sid, serial# serial
      FROM v$session
     WHERE schemaname = NVL(UPPER(vSchemaName),schemaname)
       AND osuser     = NVL(LOWER(vOSUser),osuser);

  lv_sentencia_SQL   VARCHAR2(500);
  ln_error_others    NUMBER:=-20000;
BEGIN
  FOR vse IN c_session ('&schema', '&osuser') LOOP
    BEGIN
      lv_sentencia_SQL := 'ALTER SYSTEM KILL SESSION '''||vse.sid||','||vse.serial||'''IMMEDIATE';
      DBMS_OUTPUT.PUT_LINE(lv_sentencia_SQL);
      EXECUTE IMMEDIATE lv_sentencia_SQL;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(ln_error_others,'error generico: '||SQLERRM);
END;
/

SET SERVEROUTPUT OFF