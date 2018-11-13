DECLARE
  Lv_ruta_completa    VARCHAR2(200):='C:\pruebaxls\gilberto.guerrero\prueba.xls';
  lv_ruta             VARCHAR2(200);
BEGIN
  lv_ruta := substr(lv_ruta_completa,1,length(lv_ruta_completa) - 3);
  dbms_output.put_line('Ruta = '||lv_ruta);
END;