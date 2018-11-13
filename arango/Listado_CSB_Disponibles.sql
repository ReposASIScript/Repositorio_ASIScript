SET SERVEROUTPUT ON
SPOOL C:\temp\listado.txt

DECLARE
  Lv_ExisteCSB  VARCHAR2(1);
  Lv_CodError   VARCHAR2(200);
BEGIN
  dbms_output.enable(NULL);
  dbms_output.put_line('Listado de Códigos Segun Banco Disponibles:');

  FOR cont IN 1 .. 9999 LOOP
    BEGIN
      SELECT 'S' AS Existe
        INTO Lv_ExisteCSB
        FROM Mg_Tipos_De_Transacciones trx
       WHERE Trx.Codigo_Segun_Banco = cont
    ORDER BY Trx.Codigo_Segun_Banco ASC;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        dbms_output.put_line(cont);
      WHEN OTHERS THEN
        Lv_CodError := 'Error Generico del Query a Mg_Tipos_De_Transacciones: '||SQLERRM;
        EXIT;
    END;
  END LOOP; -- FOR cont IN 1 .. 9999 LOOP

  IF Lv_CodError IS NOT NULL THEN
    dbms_output.put_line(Lv_CodError);
  END IF; -- IF Lv_CodError IS NOT NULL THEN
EXCEPTION
  WHEN OTHERS THEN
    Lv_CodError := 'Error Generico del Script: '||SQLERRM;
    dbms_output.put_line(Lv_CodError);
END;
/

SPOOL OFF