DECLARE
  queryCtx dbms_xmlquery.ctxType;
  result CLOB;
BEGIN
  -- set up the query context
  queryCtx := dbms_xmlquery.newContext(
    'SELECT codigo_cliente "EMP_NO"
          , nombres "NAME"
          , primer_apellido "DEPT_NO"
       FROM mg_clientes
      WHERE codigo_cliente = 390'
  );

  dbms_xmlquery.setRowTag(
      queryCtx
    , 'EMP'
  );

  dbms_xmlquery.setRowSetTag(
      queryCtx
    , 'EMPSET'
  ); 

  dbms_xmlquery.setBindValue(
      queryCtx
     , 'DEPT_NO'
     , 10
  ); 

  result := dbms_xmlquery.getXml(queryCtx);
  insert into xml_prueba values (result);

  --printClobOut(result);
  dbms_xmlquery.closeContext(queryCtx);
END;