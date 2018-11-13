DECLARE
  CURSOR C_Campos_Llave (vDuenio       VARCHAR2,
                         vTabla        VARCHAR2) IS
    SELECT Col.Column_Name Columna
      FROM All_Cons_Columns Col, All_Constraints Con
     WHERE Col.Owner           = Con.Owner
       AND Col.Constraint_Name = Con.Constraint_Name
       AND Col.Table_Name      = Con.Table_Name
       AND Col.Owner           = NVL(UPPER(C_Campos_Llave.vDuenio),USER)
       AND Col.Table_Name      = UPPER(C_Campos_Llave.vTabla)
       AND Con.Constraint_Type = 'P' -- Primary Key
  ORDER BY Col.Position;

  TYPE REFCURSOR IS REF CURSOR;
  Lr_Cursor      REFCURSOR;
  Lv_SQL_Nodo    VARCHAR2(10000);
  Lc_SQL_Agen    CLOB;
  Lv_Cols        VARCHAR2(5000);
  Ln_Count       NUMBER:=0;
  Lr_Temp        MG_TEMP_DATOS_REPORTE%ROWTYPE;
  --Lr_Cursor      curtype;
  curid        NUMBER;
  namevar  VARCHAR2(50);
  numvar   NUMBER;
  datevar  DATE;
  desctab  DBMS_SQL.DESC_TAB;
  colcnt   NUMBER;
BEGIN
  FOR i IN C_Campos_Llave (:P_Usuario, :P_Tabla) LOOP
    Ln_Count := Ln_Count + 1;

    IF Ln_Count != 1 THEN
      Lv_Cols := Lv_Cols || ', ' || i.columna;
    ELSE
      Lv_Cols := Lv_Cols || i.columna;
    END IF; -- IF Ln_Count != 1 THEN
  END LOOP;

  Lv_SQL_Nodo := 'SELECT ' || Lv_Cols || ' FROM ' || :P_Tabla || ' ORDER BY '|| Lv_Cols;
  OPEN Lr_Cursor FOR Lv_SQL_Nodo;
  dbms_output.put_line(Lv_SQL_Nodo);

  -- Switch from native dynamic SQL to DBMS_SQL package.
  curid := DBMS_SQL.TO_CURSOR_NUMBER(Lr_Cursor);
  DBMS_SQL.DESCRIBE_COLUMNS(curid, colcnt, desctab);

  -- Define columns.
  FOR i IN 1 .. colcnt LOOP
    IF desctab(i).col_type = 1 THEN
      DBMS_SQL.DEFINE_COLUMN(curid, i, Lr_Temp.Numero_1);
    ELSIF desctab(i).col_type = 2 THEN
      DBMS_SQL.DEFINE_COLUMN(curid, i, Lr_Temp.Numero_2);
    ELSE
      DBMS_SQL.DEFINE_COLUMN(curid, i, Lr_Temp.Numero_3);
    END IF;
  END LOOP;

  -- Fetch rows with DBMS_SQL package.
  WHILE DBMS_SQL.FETCH_ROWS(curid) > 0 LOOP
    FOR i IN 1 .. colcnt LOOP
      IF (desctab(i).col_type = 1) THEN
        DBMS_SQL.COLUMN_VALUE(curid, i, Lr_Temp.Numero_1);
        dbms_output.put_line(Lr_Temp.Numero_1);
      ELSIF (desctab(i).col_type = 2) THEN
        DBMS_SQL.COLUMN_VALUE(curid, i, Lr_Temp.Numero_2);
        dbms_output.put_line(Lr_Temp.Numero_2);
      ELSIF (desctab(i).col_type = 3) THEN
        DBMS_SQL.COLUMN_VALUE(curid, i, Lr_Temp.Numero_3);
        dbms_output.put_line(Lr_Temp.Numero_3);
      ELSIF (desctab(i).col_type = 4) THEN
        DBMS_SQL.COLUMN_VALUE(curid, i, Lr_Temp.Numero_4);
        dbms_output.put_line(Lr_Temp.Numero_4);
      END IF;
    END LOOP;
  END LOOP;

  DBMS_SQL.CLOSE_CURSOR(curid);

  /*
     Desde este punto vendria la consulta de los datos en Agencia, para esto analizar lo siguiente:

     -- Abrir cursor de consulta de NODO.
     -- Realizar un SQL Dinamico de la tabla de AGENCIA asi como se hizo en el NODO.
     -- Utilizar variables de enlace a nivel del SQL dinamico, para posteriormente enlazar los datos
        del nodo, con el filtro WHERE de AGENCIA.
     -- Ejecutar la consulta con el fin de hallar las diferencias entre ambos esquemas.
     -- Imprimir los registros de NODO que no estan en AGENCIA.
  */

  Lc_SQL_Agen := NULL;
END;
/