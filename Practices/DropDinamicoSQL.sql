DECLARE
  CURSOR C_WORK IS
    SELECT a.table_name
      FROM user_tables a
     WHERE a.table_name like 'W%';
BEGIN
  FOR i IN C_WORK LOOP
    EXECUTE IMMEDIATE 'DROP TABLE '||i.table_name;
  END LOOP;
END;