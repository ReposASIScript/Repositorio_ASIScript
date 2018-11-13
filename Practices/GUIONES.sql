DECLARE
  ln_cant_guiones    NUMBER;
  ln_conteo_guiones  NUMBER:=0;
  lv_dato            VARCHAR2(100);
  Gv_dato            VARCHAR2(100);
  lv_caracter        VARCHAR2(100);
  lv_cedula          VARCHAR2(100):='8077300661';
  lv_caracter1       VARCHAR2(100);
BEGIN
  SELECT LENGTH(formato), formato
    INTO ln_cant_guiones, lv_dato
    FROM MG_TIPOS_DE_IDENTIFICACION
   WHERE codigo_tipo_identificacion = 1;

  FOR i IN 1 .. ln_cant_guiones LOOP
    lv_caracter  := SUBSTR(lv_Dato, i, 1);
    dbms_output.put_line(lv_caracter);
      If lv_caracter NOT BETWEEN CHR(0) AND CHR(64) Then
        gv_Dato := gv_Dato  || lv_caracter;
        ln_conteo_guiones := ln_conteo_guiones + 1;
      End If;
  END LOOP;
  dbms_output.put_line('Conteo Formato: '||ln_conteo_guiones||' Dato: '||gv_dato);
END;