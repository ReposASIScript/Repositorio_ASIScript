SET SERVEROUTPUT ON SIZE 32000
SET LINESIZE 5000;
SPOOL Aplica_Homologacion_Nodo.sql;
DECLARE
  CURSOR C_Scripts IS         
    SELECT script
      FROM gm_homologacion_enc
     WHERE incluir      = 'S'
       AND generado     = 'S'
       AND nodo_agencia = 'N'
  ORDER BY orden;
BEGIN
  DBMS_OUTPUT.ENABLE(900000);

  FOR i IN C_Scripts LOOP
    GM_K_HOMOLOGACION_CTAS.Gm_f_Presentar(i.script);
  END LOOP;
END;
/   
SPOOL OFF;