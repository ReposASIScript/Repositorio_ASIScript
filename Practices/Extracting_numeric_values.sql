DECLARE
  lv_dato     VARCHAR2(200);
  Gv_Dato     VARCHAR2(200):='$33.33';
  ln_largo_numero   NUMBER;
  lv_caracter   VARCHAR2(1);
BEGIN
  ln_largo_numero := length(Gv_Dato);
  FOR i in 1..ln_largo_numero LOOP
    lv_caracter := SUBSTR(Gv_Dato, i, 1);
    dbms_output.put_line(lv_caracter);
    If lv_caracter IN ('0','1','2','3','4','5','6','7','8','9','.') Then
      lv_Dato := lv_Dato  || lv_caracter;
    End If;
  END LOOP;
  dbms_output.put_line(lv_Dato);
END;