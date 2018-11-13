DECLARE
  c                INTEGER;
  v                INTEGER;
  lv_comando       VARCHAR2(200);
  lv_campo_valor   VARCHAR2(200);
  Gn_VALOR         NUMBER;
BEGIN
  c := dbms_sql.open_cursor;
  Lv_Campo_Valor := MG_K_PARAMETROS_DINAMICOS.MG_F_DEVUELVE_VALOR('BPR','P_CAMPO_VALOR_PLANILLA');
  lv_comando     := 'Begin PR_K_MANEJO_ARCHIVOS_PLANILLA.PLANILLA.'||Lv_Campo_Valor||':=30; END;';
  dbms_output.put_line('Comando= '||lv_comando);
  dbms_sql.parse(c,Lv_Comando,dbms_sql.native);
  dbms_sql.bind_variable(c,':PR_K_MANEJO_ARCHIVOS_PLANILLA.PLANILLA.'||Lv_Campo_Valor,Gn_VALOR);
  v:=dbms_sql.execute(c);
  dbms_sql.close_cursor(c);
  dbms_output.put_line('Valor= '||Gn_VALOR);
EXCEPTION
  WHEN OTHERS THEN
   dbms_output.put_line(sqlerrm);
END;