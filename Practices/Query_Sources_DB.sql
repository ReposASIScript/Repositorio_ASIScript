DECLARE
  LV_NOMBRE_FUENTE         VARCHAR2(200):='&Indique_nombre_fuente';
  LN_COUNT                 NUMBER:=0;
  LE_ERROR_VACIO           EXCEPTION;
  CURSOR C_FUENTE (sourcename     VARCHAR2)IS 
   SELECT text codigo_fuente
     FROM user_source
    WHERE UPPER(name) = UPPER(sourcename);
BEGIN

IF LV_NOMBRE_FUENTE BETWEEN 'A' AND 'Z' OR LV_NOMBRE_FUENTE BETWEEN 'a' AND 'z' THEN

  FOR SC IN C_FUENTE (LV_NOMBRE_FUENTE) LOOP
    Ln_count := Ln_count + 1;
    dbms_output.put_line(SC.codigo_fuente);
  END LOOP;

END IF; --IF LV_NOMBRE_FUENTE BETWEEN 'A' AND 'Z' OR LV_NOMBRE_FUENTE BETWEEN 'a' AND 'z' THEN

  IF LN_COUNT = 0 THEN
    RAISE LE_ERROR_VACIO;
  END IF;

EXCEPTION
  WHEN LE_ERROR_VACIO THEN
     raise_application_error(-20000,'No se encontro el fuente buscado. Fuente: '||Lv_Nombre_Fuente);
END;
/