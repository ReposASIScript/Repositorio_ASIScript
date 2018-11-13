DECLARE
  CURSOR c_cuentas_cts IS
    SELECT cts.codigo_empresa, cts.codigo_agencia, cts.codigo_subaplicacion, cts.numero_cuenta
      FROM ca_cuentas_ahorro_cts cts, ca_cuentas_de_ahorro aho
     WHERE cts.codigo_empresa       = aho.codigo_empresa
       AND cts.codigo_agencia       = aho.codigo_agencia
       AND cts.codigo_subaplicacion = aho.codigo_subaplicacion
       AND cts.numero_cuenta        = aho.numero_cuenta
       AND aho.situacion_en_linea  != '1';

  Gv_CodError      VARCHAR2(200);
  Lv_Mensaje       VARCHAR2(200);
  Lv_TipoMens      VARCHAR2(10);
  Lv_PosicionMens  VARCHAR2(10);
  Ln_Contador      NUMBER:=0;
BEGIN
  FOR i IN c_cuentas_cts LOOP
    CA_K_CALCULO_CTS.CA_P_CALCULA_SALDO_DISP (i.codigo_empresa,
                                              i.codigo_agencia,
                                              i.codigo_subaplicacion,
                                              i.numero_cuenta,
                                              Gv_CodError);

    IF Gv_CodError IS NOT NULL THEN
      MG_K_CTRL_ERROR.MG_P_MENSAJE_ERROR (Gv_CodError, 1, Lv_Mensaje, Lv_TipoMens, Lv_PosicionMens);
      EXIT;
    END IF;

    Ln_Contador := Ln_Contador + 1;
  END LOOP; -- FOR i IN c_cuentas_cts LOOP

  IF Lv_Mensaje IS NOT NULL THEN
    NT_P_ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,Lv_Mensaje);
  ELSE
    dbms_output.put_line('Cantidad de Registros Afectados: '||Ln_Contador);
    COMMIT;
  END IF; -- IF Lv_Mensaje IS NOT NULL THEN
EXCEPTION
  WHEN OTHERS THEN
    Lv_Mensaje := SQLERRM;
    NT_P_ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,Lv_Mensaje);
END;
/