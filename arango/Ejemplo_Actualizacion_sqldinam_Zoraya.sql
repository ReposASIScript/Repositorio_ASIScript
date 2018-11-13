declare
  cursor c_tab_col is
    select a.table_name, a.column_name
    from user_tab_columns a, user_tables b
    where a.table_name = b.table_name
    and a.column_name like '%NIVEL%4%'
    and a.table_name not in ('GM_CATALOGOS','GM_BALANCE_CUENTAS','GM_BALANCE_EXTRANJEROS','GM_PARAMETRO_ESTRUCTURA_CTAS',
	                         'CJ_COBROS_JUDICIALES_C','LP_COMISION_X_SUBAPLIC','LP_COMPROBANTE_CONTABLES',
							 'LP_GASTO_COMISION_X_SUBAPLIC','LP_HIST_CONT_DETALLE','LP_PARAMETRO_CONTABLES','LP_PARAMETROS',
							 'LP_TRAN_ESPECIALES_X_AGENCIA','LP_TRAN_ESPECIALES_X_AGEN_TMP','PO_PRESUPUESTOS_CUENTAS')
    order by a.table_name;

  lv_cadena varchar2(10000);
begin
  dbms_output.enable();
  for i in c_tab_col loop
    lv_cadena := 'UPDATE '||i.table_name||' a SET (a.'||i.column_name||') = '||
                 '(SELECT b.'||i.column_name||' FROM '||i.table_name||' b WHERE a.ROWID = b.ROWID)||''00'' WHERE a.'||i.column_name||' IS NOT NULL';
    --dbms_output.put_line(lv_cadena);
    EXECUTE IMMEDIATE lv_cadena;
    dbms_output.put_line('Tabla: '||i.table_name||' Columna: '||i.column_name||' actualizada...');
  end loop;
  commit;
  dbms_output.put_line('Actualización de tablas concluida satisfactoriamente.');
  dbms_output.enable(20000);
exception
  when others then
    rollback;
    dbms_output.put_line('Error: '||SQLERRM);
end;