DECLARE
l_doc       VARCHAR2(2000);
l_domdoc    dbms_xmldom.DOMDocument;
l_nodelist  dbms_xmldom.DOMNodeList;
l_node      dbms_xmldom.DOMNode;
l_value     VARCHAR2(30);
l_xmltype   XMLTYPE;
l_empx      XMLTYPE;
l_index     PLS_INTEGER;
l_col_ind   PLS_INTEGER;
BEGIN
  l_doc := '<employees>
             <emp>
              <name>Scott</name>
              <favorites>
               <color>red</color>
               <color>orange</color>
              </favorites>
             </emp>
             <emp>
              <name>John</name>
              <favorites>
               <color>blue</color>
               <color>green</color>
              </favorites>
             </emp>
            </employees>';
  l_domdoc := dbms_xmldom.newDomDocument(l_doc);
  -- Method 1
  dbms_output.put_line('Method 1');
  l_nodelist := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(l_domdoc),'/employees/emp/name');
  FOR cur_emp IN 0 .. dbms_xmldom.getLength(l_nodelist) - 1
  LOOP
    l_node := dbms_xmldom.item(l_nodelist, cur_emp);
    l_value := dbms_xmldom.getnodevalue(dbms_xmldom.getfirstchild(l_node));
    dbms_output.put_line('Emp Name: '||l_value);
  END LOOP;
END;