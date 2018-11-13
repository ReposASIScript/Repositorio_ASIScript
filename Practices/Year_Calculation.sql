DECLARE
  ld_fecha_nac  DATE:='&Fecha_Nacimiento';
  ln_edad       NUMBER;
BEGIN
  SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, ld_fecha_nac) /12) 
  INTO ln_edad
  FROM dual;
  dbms_output.put_line('La edad es de: '||ln_edad||' Años');
END;
/