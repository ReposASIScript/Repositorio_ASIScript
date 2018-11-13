DECLARE
Gn_TIPO_TASA   number;
Gv_OPERA_MATH  varchar2(1);
Gn_VRSPREAD    number;
Gv_MENSAJE     varchar2(200);

PROCEDURE DP_P_PLAZO_RANGO_AGENCIA (Gn_EMPRESA             IN number,-- ESTE ES EL PROCEDIMIENTO QUE SE VA A MODIFICAR
                            Gv_CODIGO_APLICACION IN    varchar2,
                            Gn_CODIGO_AGENCIA    IN    number,
                            Gn_SUB_APLICACION  IN    number,
                            Gd_FECHA_VALIDA    IN    date,
                            Gn_VRCUENTA            IN number,
                            Gn_PLAZO               IN number,
                            Gn_TIPO_TASA       IN OUT number,
                            Gv_OPERA_MATH         OUT varchar2,
                            Gn_VRSPREAD           OUT number,
                            Gv_MENSAJE            OUT varchar2) IS

 Ln_Plazo  NUMBER(4) := NULL;
 Lv_Valor  MG_PARAMETROS_DINAMICOS.VALOR%TYPE;
 Ld_fecha_valida date;
BEGIN


  BEGIN-- AKI COMIENSA
      Lv_Valor := 'I';
      --MG_K_PARAMETROS_DINAMICOS.MG_P_DEVUELVE_VALOR ('BDP','LIMITE_TASA_PARA_RANGOS',Lv_Valor,Gv_MENSAJE);
    if Gv_MENSAJE is not null then
      return;
    end if;
    --Si el parametro esta en I entonces trae el plazo mas peque?o dentro de su rango
    IF NVL(Lv_Valor,'S') ='I' THEN
      SELECT MAX(PLAZO)
        INTO Ln_Plazo
        FROM MG_RANGOS_PLAZOS_AGENCIA
       WHERE CODIGO_EMPRESA        = Gn_EMPRESA
         AND PLAZO                <= Gn_PLAZO
         AND CODIGO_AGENCIA        = Gn_CODIGO_AGENCIA
         AND CODIGO_APLICACION     = Gv_CODIGO_APLICACION
         AND CODIGO_SUB_APLICACION = Gn_SUB_APLICACION;


    ELSE
      --trae el plazo mas peque?o dentro de su rango
      SELECT MIN(PLAZO)
        INTO Ln_Plazo
        FROM MG_RANGOS_PLAZOS_AGENCIA
       WHERE CODIGO_EMPRESA        = Gn_EMPRESA
         AND PLAZO                >= Gn_PLAZO
         AND CODIGO_AGENCIA        = Gn_CODIGO_AGENCIA
         AND CODIGO_APLICACION     = Gv_CODIGO_APLICACION
         AND CODIGO_SUB_APLICACION = Gn_SUB_APLICACION;
    END IF;

    IF Ln_Plazo IS NULL THEN
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_ARMAR_CODIGO_ERROR (0, 'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE',
                   'No se encontro Plazo con P='||TO_CHAR(Gn_PLAZO)||' S='||TO_CHAR(Gn_SUB_APLICACION)||' E='||TO_CHAR(Gn_EMPRESA)||' A='||TO_CHAR(Gn_CODIGO_AGENCIA));*/
      RETURN;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      -- Si Ocurre Cualquier Otra Excepcion
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_MENSAJESEXCEPTIONS(SqlCode,
                    'DP_K_ASI_TAS.DP_P_PLA_RA_AGEN', SqlErrm, NULL);*/
      RETURN;
  END;

  -- Se seledciona la fecha valida a partir de la cual se debe buscar la parametrizacion
BEGIN
    SELECT MAX(FECHA_VALIDA)
      INTO Ld_FECHA_VALIDA
      FROM MG_RANGOS_PLAZOS_AGENCIA
     WHERE CODIGO_EMPRESA        = Gn_EMPRESA
       AND PLAZO                 = Ln_PLAZO
       AND CODIGO_AGENCIA        = Gn_CODIGO_AGENCIA
       AND CODIGO_APLICACION     = Gv_CODIGO_APLICACION
       AND CODIGO_SUB_APLICACION = Gn_SUB_APLICACION
       AND FECHA_VALIDA <= Gd_FECHA_VALIDA;

    IF Ld_FECHA_VALIDA is null THEN
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_ARMAR_CODIGO_ERROR (0, 'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE',
                    'No se encontro Fecha Valida con P='||TO_CHAR(Ln_PLAZO)||' S='||TO_CHAR(Gn_SUB_APLICACION)||' E='||TO_CHAR(Gn_EMPRESA)||' A='||TO_CHAR(Gn_CODIGO_AGENCIA));*/
      RETURN;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      -- Si Ocurre Cualquier Otra Excepcion
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_MENSAJESEXCEPTIONS(SqlCode,
                    'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE', SqlErrm, NULL);*/
      RETURN;
  END;

  BEGIN
    SELECT MIN(CODIGO_TIPO_TASA)
      INTO Gn_TIPO_TASA
      FROM MG_RANGOS_PLAZOS_AGENCIA
     WHERE CODIGO_EMPRESA        = Gn_EMPRESA
       AND PLAZO                 = Ln_PLAZO
       AND CODIGO_AGENCIA        = Gn_CODIGO_AGENCIA
       AND CODIGO_APLICACION     = Gv_CODIGO_APLICACION
       AND CODIGO_SUB_APLICACION = Gn_SUB_APLICACION
       AND FECHA_VALIDA          = LD_FECHA_VALIDA;

    IF Gn_TIPO_TASA IS NULL THEN
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_ARMAR_CODIGO_ERROR (0, 'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE',
                    'No se encontro tipo de tasa con P='||TO_CHAR(Ln_PLAZO)||' S='||TO_CHAR(Gn_SUB_APLICACION)||' E='||TO_CHAR(Gn_EMPRESA)||' A='||TO_CHAR(Gn_CODIGO_AGENCIA));*/
      RETURN;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      -- Si Ocurre Cualquier Otra Excepcion
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_MENSAJESEXCEPTIONS(SqlCode,
                    'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE', SqlErrm, NULL);*/
      RETURN;
  END;

  BEGIN
    SELECT SPREAD, OPERADOR
    INTO   Gn_Vrspread, Gv_Opera_Math
    FROM   MG_RANGOS_PLAZOS_AGENCIA_DET
    WHERE  CODIGO_EMPRESA           = Gn_EMPRESA
    AND    PLAZO                    = Ln_Plazo
    AND    CODIGO_TIPO_TASA         = Gn_TIPO_TASA
    AND    CODIGO_AGENCIA        = Gn_CODIGO_AGENCIA
    AND    CODIGO_APLICACION     = Gv_CODIGO_APLICACION
    AND    CODIGO_SUB_APLICACION    = Gn_SUB_APLICACION
    AND    FECHA_VALIDA          = LD_FECHA_VALIDA
    AND    VALOR                    = (SELECT MIN(VALOR)
                                       FROM MG_RANGOS_PLAZOS_AGENCIA_DET
                                       WHERE CODIGO_EMPRESA      = Gn_Empresa
                                       AND PLAZO                 = Ln_Plazo
                                       AND CODIGO_TIPO_TASA      = Gn_Tipo_Tasa
                                       AND CODIGO_AGENCIA        = Gn_CODIGO_AGENCIA
                                       AND CODIGO_APLICACION     = Gv_CODIGO_APLICACION
                                       AND CODIGO_SUB_APLICACION = Gn_Sub_Aplicacion
                                       AND FECHA_VALIDA          = LD_FECHA_VALIDA
                                       AND VALOR                >= Gn_VrCuenta);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- No se han Registrado las Tasas Requeridas
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_ARMAR_CODIGO_ERROR(1320,
                                'P='||TO_CHAR(Ln_Plazo)||'-T='||TO_CHAR(Gn_Tipo_Tasa)||'-V='||TO_CHAR(Gn_VrCuenta)||'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE',NULL);*/
      RETURN;
    WHEN OTHERS THEN
        -- Si Ocurre Cualquier Otra Excepcion
      /*Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_MENSAJESEXCEPTIONS(SqlCode,
                   'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE', SqlErrm, NULL);*/
      RETURN;
  END;

EXCEPTION
  WHEN OTHERS THEN
      -- Si Ocurre Cualquier Otra Excepcion
    --Gv_Mensaje := MG_K_CTRL_ERROR.MG_F_ARMAR_CODIGO_ERROR(0,'DP_K_ASI_TAS.DP_P_PLA_RAN_AGE',SQLERRM);
    RETURN;
END;
BEGIN

DP_P_PLAZO_RANGO_AGENCIA (1,
                            'BDP',
                            113,
                            30,
                            TO_DATE('04-06-2014','DD-MM-YYYY'),
                            9400.55,
                            391,
                            Gn_TIPO_TASA,
                            Gv_OPERA_MATH,
                            Gn_VRSPREAD,
                            Gv_MENSAJE);

dbms_output.put_line('Gn_TIPO_TASA := '||Gn_TIPO_TASA);
dbms_output.put_line('Gv_OPERA_MATH := '||Gv_OPERA_MATH);
dbms_output.put_line('Gn_VRSPREAD := '||Gn_VRSPREAD);
dbms_output.put_line('Gv_MENSAJE := '||Gv_MENSAJE);
END;
/