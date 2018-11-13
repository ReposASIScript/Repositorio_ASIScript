DECLARE
  CURSOR c_copropietarios  IS
    SELECT codigo_cliente
      FROM mg_cuentas_x_cliente cuexcli
     WHERE cuexcli.codigo_cliente       != 40760
       AND cuexcli.codigo_cuenta         = 5540513
       AND cuexcli.codigo_sub_aplicacion = 121
       AND cuexcli.codigo_agencia        = 1
       AND cuexcli.codigo_aplicacion     = 'BDP'
       AND cuexcli.codigo_empresa        = 1
       AND cuexcli.clase_de_cliente      IN ('P','S');

lv_nombre_copropietario       VARCHAR2(500);
lv_armado_copropietarios      VARCHAR2(4000);
ln_count                      NUMBER:=0;
begin
  FOR i IN c_copropietarios LOOP
    BEGIN
      SELECT cli.nombre_completo
        INTO lv_nombre_copropietario
        FROM mg_clientes cli
       WHERE cli.codigo_cliente = i.codigo_cliente;
    EXCEPTION
    	WHEN OTHERS THEN
    	  lv_nombre_copropietario := NULL;
    END;

    If ln_count >= 1 Then
      lv_armado_copropietarios := lv_armado_copropietarios||lv_nombre_copropietario||chr(10);
    Else
    	lv_armado_copropietarios := lv_nombre_copropietario||chr(10);
    End If;
    ln_count := ln_count + 1;
  END LOOP;

  dbms_output.put_line(lv_armado_copropietarios);
end;