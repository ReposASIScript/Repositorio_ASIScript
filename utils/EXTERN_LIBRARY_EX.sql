CREATE OR REPLACE LIBRARY shell_lib IS '/u01/app/oracle/dba_scripts/extproc/shell.so';
/
CREATE OR REPLACE FUNCTION sysrun (syscomm IN VARCHAR2) RETURN BINARY_INTEGER
AS LANGUAGE C NAME "sysrun" LIBRARY shell_lib PARAMETERS (syscomm string);
/
SELECT sysrun('echo hola') FROM DUAL
/