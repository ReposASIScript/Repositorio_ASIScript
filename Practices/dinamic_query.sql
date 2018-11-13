DECLARE       
STR_SQL   VARCHAR2(255);       
L_CNT     VARCHAR2(20);
CAMPO     VARCHAR2(50)  :='&Introduzca_campo_buscar';
TABLA     VARCHAR2(50)  :='&Introduzca_tabla_buscar';
CAMBUSC   VARCHAR2(50)  :='&Introduzca_campo_busque';
CODCLI    VARCHAR2(100) :=&INTRODUZCA_NUM_CLIENTE;
l_cursor  INTEGER;
BEGIN     
str_sql := 'SELECT '||campo||' FROM '||tabla||' WHERE '|| cambusc ||
           ' = '||codcli;     

L_CURSOR := DBMS_SQL.OPEN_CURSOR;
DBMS_SQL.PARSE(L_CURSOR, STR_SQL,DBMS_SQL.NATIVE);
L_CNT := DBMS_SQL.EXECUTE(L_CURSOR);
END;
/