DROP PROCEDURE MENERROR
/
DROP TABLE MENSAJE_ERROR
/
DROP SEQUENCE MENSAJE_ERROR_S
/
CREATE TABLE MENSAJE_ERROR(SECUENCIA         NUMBER(38,2),
                           FECHA             DATE,
                           HOST_EJECUTOR     VARCHAR2(100),
                           API_EJECUTADO     VARCHAR2(100),
                           MENSAJE           CLOB)
/
CREATE SEQUENCE MENSAJE_ERROR_S MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE ORDER CYCLE
/
CREATE OR REPLACE PROCEDURE MENERROR (Gc_Mensaje     IN CLOB) AS
  lv_hostname   MENSAJE_ERROR.HOST_EJECUTOR%TYPE;
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  SELECT SYS_CONTEXT ('USERENV', 'HOST') INTO lv_hostname FROM DUAL;

  INSERT INTO MENSAJE_ERROR (secuencia,
                             mensaje,
                             fecha,
                             host_ejecutor)
                     VALUES (MENSAJE_ERROR_S.NEXTVAL,
                             Gc_Mensaje,
                             SYSDATE,
                             lv_hostname);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    NULL; --RAISE_APPLICATION_ERROR(-20000,'Error generico del programa '||SQLERRM);
END MENERROR;
/