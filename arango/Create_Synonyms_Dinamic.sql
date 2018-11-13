DECLARE
  CURSOR C_Usuarios IS
    SELECT Usu.Codigo_Usuario
      FROM Mg_Usuarios_Del_Sistema Usu
     WHERE Usu.Codigo_Usuario LIKE 'DCOJFK_U%'
  ORDER BY 1;

  Lv_SQL  VARCHAR2(1000);
BEGIN
  FOR U IN C_Usuarios LOOP
   Lv_SQL := 'CREATE OR REPLACE SYNONYM '||U.Codigo_Usuario||'.BC_TRX_X_CUENTA_CORR FOR DCOJFK.BC_TRX_X_CUENTA_CORR';
   dbms_output.put_line(Lv_SQL);
   EXECUTE IMMEDIATE Lv_SQL;
  END LOOP;
END;
/