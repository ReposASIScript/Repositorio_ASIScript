DECLARE
  TEXTO_PRUEBA    VARCHAR2(1000):='&Escriba_Texto_Aqui';
  LARGO           NUMBER;
  VARIABLE_NULA   EXCEPTION;
BEGIN
  IF TEXTO_PRUEBA IS NULL THEN
    RAISE VARIABLE_NULA;
  ELSE
    LARGO := LENGTH(TEXTO_PRUEBA);
    DBMS_OUTPUT.PUT_LINE('El largo del campo es: '||LARGO);
  end if;  
EXCEPTION
  WHEN VARIABLE_NULA THEN
    dbms_output.put_line('No puede dejar el campo nulo');
END;