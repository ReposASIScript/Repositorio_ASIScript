DECLARE
  i      VARCHAR2(1):='';
  j      VARCHAR2(1):=NULL;
BEGIN
  If i is null and j is null then
    dbms_output.put_line('NULO');
  end if;
END;