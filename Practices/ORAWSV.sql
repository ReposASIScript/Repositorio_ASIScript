SELECT dbms_xdb.gethttpport FROM dual;

CONN / AS SYSDBA

DECLARE
  l_servlet_name VARCHAR2(32) := 'orawsv';
BEGIN
  /*
     Conneccion al ORAWSV

     Formato:
     http://host:port/orawsv/DBSCHEMA/FN_OR_PROC?wsdl
     http://host:port/orawsv/DBSCHEMA/PACKAGE/FN_OR_PROC?wsdl

     Ejemplo:
     http://ol5-112.localdomain:8080/orawsv/TEST/GET_DESCRIPTION?wsdl
  */

  DBMS_XDB.deleteServletMapping(l_servlet_name);

  DBMS_XDB.deleteServlet(l_servlet_name);

  DBMS_XDB.addServlet(
    name     => l_servlet_name,
    language => 'C',
    dispname => 'Oracle Query Web Service',
    descript => 'Servlet for issuing queries as a Web Service',
    schema   => 'XDB');

  DBMS_XDB.addServletSecRole(
    servname => l_servlet_name,
    rolename => 'XDB_WEBSERVICES',
    rolelink => 'XDB_WEBSERVICES');

  DBMS_XDB.addServletMapping(
    pattern => '/orawsv/*',
    name    => l_servlet_name);
END;
/

SET LONG 10000

XQUERY declare default element namespace "http://xmlns.oracle.com/xdb/xdbconfig.xsd"; (: :)
       (: This path is split over two lines for documentation purposes only.
          The path should actually be a single long line. :)
       for $doc in fn:doc("/xdbconfig.xml")/xdbconfig/sysconfig/protocolconfig/httpconfig/
        webappconfig/servletconfig/servlet-list/servlet[servlet-name='orawsv']
       return $doc
/

GRANT XDB_WEBSERVICES TO test;
GRANT XDB_WEBSERVICES_OVER_HTTP TO test;