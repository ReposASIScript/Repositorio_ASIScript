DECLARE
  Lv_Formula          PR_FORMULAS.FORMULA_VALOR%TYPE;
  Ln_Valor            NUMBER:=6.2589;
  Ln_Valor1           NUMBER;
BEGIN
   BEGIN
     SELECT FORMULA_VALOR
       INTO Lv_Formula
       FROM PR_FORMULAS
      WHERE CODIGO_OPERACION      = 1
        And CODIGO_AGENCIA        = 100
        And CODIGO_SUB_APLICACION = 1
        And CODIGO_TIPO_SALDO     = 50;
   EXCEPTION
     WHEN OTHERS THEN
       NULL;
   END;

   If Lv_Formula IS NOT NULL Then
     EXECUTE IMMEDIATE 'SELECT '||Lv_Formula||' FROM dual' INTO Ln_Valor using Ln_Valor;
     DBMS_OUTPUT.PUT_LINE(Ln_Valor);
   End If;
END;