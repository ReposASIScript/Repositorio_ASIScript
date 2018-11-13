DECLARE
  v_semilla NUMBER(12);
  mi_numero_random BINARY_INTEGER;
BEGIN
-- Genera una semilla a partir de la fecha actual
  v_semilla := to_number(to_char(to_char(SYSDATE, 'SSHH24SSDD')));
-- Inicializa con la semilla
  DBMS_RANDOM.INITIALIZE(v_semilla);
-- Obtiene un numero random
  mi_numero_random := DBMS_RANDOM.RANDOM;
  dbms_output.put_line('Resultado:' || mi_numero_random);
-- Finaliza
  DBMS_RANDOM.TERMINATE;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
END;
/