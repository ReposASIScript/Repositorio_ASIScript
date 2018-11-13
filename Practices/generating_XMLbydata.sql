DECLARE
  l_ctx   DBMS_XMLQUERY.CTXHANDLE;
  l_clob  CLOB;
BEGIN
  l_ctx := DBMS_XMLQUERY.NEWCONTEXT('select * from mg_clientes');
  DBMS_LOB.CREATETEMPORARY(l_clob,TRUE,DBMS_LOB.SESSION);
  l_clob := DBMS_XMLQUERY.GETXML(l_ctx);
  MENERROR(l_clob);
END;
/