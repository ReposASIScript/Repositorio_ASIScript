DECLARE
  
BEGIN
  Lc_Sentencia_SQL := 'INSERT INTO '||:table_name||' ('||Lv_Columnas||') VALUES ('||lv_valores||');';
END;
/