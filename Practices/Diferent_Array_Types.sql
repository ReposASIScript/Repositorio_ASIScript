/*Example about how to use the associative array, 
  for the management of a Data Type Date*/
DECLARE
 TYPE T_PRUEBA IS TABLE OF DATE INDEX BY PLS_INTEGER;
 LD_FECHA            T_PRUEBA;
 LN_CANT             DATE;
 LN_IND              NUMBER:=&INTRODUZCA_INDICE;
 INDEX_ERROR         EXCEPTION;
 LN_CONTEO           NUMBER;
BEGIN
 LD_FECHA(0)  := TO_DATE(SYSDATE,'dd-mm-yyyy');
 LD_FECHA(1)  := TO_DATE('05-02-1982','dd-mm-yyyy');
 LD_FECHA(2)  := TO_DATE('28-02-1984','dd-mm-yyyy');
 LN_CONTEO    := LD_FECHA.COUNT;

FOR I IN 0..LN_IND LOOP
 LN_CANT      := LD_FECHA(I);
 IF LD_FECHA.EXISTS(I) THEN
   DBMS_OUTPUT.PUT_LINE('Date Printed: '||LN_CANT);
 ELSE
   RAISE INDEX_ERROR;
 END IF;  --IF LD_FECHA.EXISTS(I) THEN
END LOOP; --FOR I IN 0..2 LOOP

DBMS_OUTPUT.PUT_LINE('Total Elements in Array: '||LN_CONTEO);

EXCEPTION
  WHEN INDEX_ERROR THEN
    RAISE_APPLICATION_ERROR(-20000,'Error: '||sqlerrm);
END;
/

/*Example about how to use the VARRAY, 
  for the management of a Data Type Character*/
DECLARE
  TYPE PRUEBA IS VARRAY(6) OF MG_CLIENTES.NOMBRES%TYPE;
  V_CLIENTES     PRUEBA:= PRUEBA ('Rigoberto Guerrero', 'Eyda Caballero', 
                                  'Rigoberto E. Guerrero', 'Gilberto Guerrero',
                                  'Orlando Jimenez');                               
BEGIN
  FOR I IN V_CLIENTES.FIRST .. V_CLIENTES.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Nombre Cliente '||I||': '||V_CLIENTES(I));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Total Data in VARRAY  = '||V_CLIENTES.COUNT());
  DBMS_OUTPUT.PUT_LINE('Limit of VARRAY = '||V_CLIENTES.LIMIT);
END;
/

/*Example of a Record Type, that charge data of a query
*/
DECLARE
  TYPE T_CLIENTESBANK IS RECORD
  (NOMBRE             MG_CLIENTES.NOMBRES%TYPE,
   PRIMER_APELLIDO    MG_CLIENTES.PRIMER_APELLIDO%TYPE,
   SEGUNDO_APELLIDO   MG_CLIENTES.SEGUNDO_APELLIDO%TYPE
  );

  TYPE T_CLI IS TABLE OF T_CLIENTESBANK;

  LV_CLIENTES    T_CLI;
  LN_CONTEO      NUMBER:=0;

  CURSOR C_BANKCUST IS SELECT NOMBRES, PRIMER_APELLIDO, SEGUNDO_APELLIDO
                         FROM MG_CLIENTES;
BEGIN
  OPEN C_BANKCUST;
  FETCH C_BANKCUST BULK COLLECT INTO LV_CLIENTES;
  CLOSE C_BANKCUST;
  
  LN_CONTEO := LV_CLIENTES.LAST;
  
  FOR I IN 1..LN_CONTEO LOOP
    DBMS_OUTPUT.PUT_LINE(LV_CLIENTES(I).NOMBRE
                         ||' '||LV_CLIENTES(I).PRIMER_APELLIDO
                         ||' '||LV_CLIENTES(I).SEGUNDO_APELLIDO);
  END LOOP;
  
    DBMS_OUTPUT.PUT_LINE('Total de Clientes: '||LV_CLIENTES.COUNT());
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000,'Error durante asignación '||sqlerrm);
END;
/