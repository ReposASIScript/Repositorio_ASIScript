DECLARE
  GN_CODIGO_EMPRESA          NUMBER;
  GN_CODIGO_AGENCIA          NUMBER;
  GN_CODIGO_SUBAPLICACION    NUMBER;
  GN_NUMERO_CUENTA           NUMBER;
  GV_COD_ERROR               VARCHAR2(200);
  LV_MENSAJE                 VARCHAR2(200);
  Lv_TIPOMENS                VARCHAR2(10);
  LV_POSICIONMENS            VARCHAR2(10);
BEGIN
  GN_CODIGO_EMPRESA       := &Introduzca_Empresa;
  GN_CODIGO_AGENCIA       := &Introduzca_Agencia;
  GN_CODIGO_SUBAPLICACION := &Introduzca_Subaplicacion;
  GN_NUMERO_CUENTA        := &Introduzca_Cuenta;

  CA_K_CALCULO_CTS.CA_P_CALCULA_SALDO_DISP
   (GN_CODIGO_EMPRESA       => GN_CODIGO_EMPRESA,
    GN_CODIGO_AGENCIA       => GN_CODIGO_AGENCIA,
    GN_CODIGO_SUBAPLICACION => GN_CODIGO_SUBAPLICACION,
    GN_NUMERO_CUENTA        => GN_NUMERO_CUENTA,
    GV_COD_ERROR            => GV_COD_ERROR);

  MG_K_INTERCAMBIO_DATOS.SET_NUMBER('CA_K_CALCULO_CTS',NULL,'Gn_Capital_Disponible',NULL);
  MG_K_INTERCAMBIO_DATOS.SET_NUMBER('CA_K_CALCULO_CTS',NULL,'Gn_Capital_Intangible',NULL);
  MG_K_INTERCAMBIO_DATOS.SET_NUMBER('CA_K_CALCULO_CTS',NULL,'Gn_Interes_Disponible',NULL);
  MG_K_INTERCAMBIO_DATOS.SET_NUMBER('CA_K_CALCULO_CTS',NULL,'Gn_Interes_Intangible',NULL);

  IF GV_COD_ERROR IS NOT NULL THEN
    MG_K_CTRL_ERROR.MG_P_MENSAJE_ERROR(GV_COD_ERROR,1,LV_MENSAJE,Lv_TIPOMENS,LV_POSICIONMENS);
    NT_P_ROLLBACK;
    RAISE_APPLICATION_ERROR(-20000,LV_MENSAJE);
  ELSE
    COMMIT;
  END IF;
END;
/