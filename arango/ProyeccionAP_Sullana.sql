DECLARE
  TYPE T_PROYECCION IS RECORD (NUMERO_CUOTA       MG_TEMP_DATOS_REPORTE.NUMERO_1%TYPE := NULL,
                               FECHA_CUOTA        MG_TEMP_DATOS_REPORTE.FECHA_1%TYPE  := NULL,
                               VALOR_CUOTA        MG_TEMP_DATOS_REPORTE.NUMERO_2%TYPE := NULL,
                               VALOR_INTERES      MG_TEMP_DATOS_REPORTE.NUMERO_3%TYPE := NULL,
                               DIAS_PERIODO       MG_TEMP_DATOS_REPORTE.NUMERO_4%TYPE := NULL);

  TYPE T_PROYECCION_CUOTA IS TABLE OF T_PROYECCION;
  lr_proyeccion_cuota      T_PROYECCION_CUOTA := T_PROYECCION_CUOTA();
  Ln_Empresa               ca_cuentas_de_ahorro.codigo_empresa%TYPE:=1;--&empresa;
  Ln_Agencia               ca_cuentas_de_ahorro.codigo_agencia%TYPE:=187;--&agencia;
  Ln_Subaplicacion         ca_cuentas_de_ahorro.codigo_subaplicacion%TYPE:=10;--&subaplicacion;
  Ln_Cuenta                ca_cuentas_de_ahorro.numero_cuenta%TYPE:=264786;--&cuenta;
  Ln_Tipo_Asignacion_Tasa  NUMBER:=9; --&tipoasignacion;
  Ld_Fecha_Inicio          DATE:=TO_DATE('29-05-2014','DD-MM-YYYY');  -- TO_DATE('&fechainicio','DD-MM-YYYY');
  Ld_Fecha_Final           DATE:=TO_DATE('29-06-2014','DD-MM-YYYY'); -- TO_DATE('&fechafinal','DD-MM-YYYY');
  Ln_Tasa_TEI              NUMBER;
  Ln_Secuencia             NUMBER;
  Lv_CodError              VARCHAR2(200);

  PROCEDURE PU_P_PROYECCION (Gn_Codigo_Empresa      IN NUMBER,
                             Gv_Codigo_Aplicacion   IN VARCHAR2,
                             Gn_Codigo_Subaplic     IN NUMBER,
                             Gn_Codigo_Tipo_Tran    IN NUMBER,
                             Gn_Dia_De_Pago         IN NUMBER,
                             Gn_TipoCalculoInteres  IN NUMBER,
                             Gn_Plazo               IN NUMBER,
                             Gv_Frecuencia_Cuota    IN VARCHAR2,
                             Gd_Fecha_Inicial       IN DATE,
                             Gd_Fecha_Final         IN DATE,
                             Gd_Fecha_Prm_Cuota     IN DATE,
                             Gn_Valor_Cuota         IN NUMBER,
                             Gn_Valor_Tasa          IN NUMBER,
                             Gn_Secuencia          OUT NUMBER,
                             Gv_CodError           OUT VARCHAR2) IS

    Ln_Anio                    mg_transacciones_especiales.anio%TYPE;
    Ln_Mes                     mg_transacciones_especiales.mes%TYPE;
    Ln_Base_Calculo            NUMBER:=0;
    Ln_Dias_Periodo            NUMBER;
    Ln_Valor_Interes           NUMBER(19,2):=0;
    Ln_Interes                 NUMBER(19,2):=0;
    Ln_Capital                 NUMBER(19,2):=0;
    Lv_Descripcion_Frecuencia  VARCHAR2(50);
    Ld_Fecha_Cuota             DATE;
    Ld_Fecha_Cuota_Ant         DATE;
    Ln_Dias_Frecuencia         NUMBER:=0;
    Ln_Contador                NUMBER:=0;
    Ln_Secuencia_Insercion     NUMBER:=0;
    Ln_Monto_Pactado           NUMBER(19,2):=0;
    Ln_Cantidad_Cuotas         NUMBER:=0;
    Ld_Fecha_Ultima_Cuota      DATE;
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    BEGIN
 	    SELECT esp.anio, esp.mes
 	      INTO ln_anio, ln_mes
 	      FROM mg_transacciones_especiales esp
 	     WHERE esp.codigo_aplicacion       = Gv_Codigo_Aplicacion
 	       AND esp.codigo_sub_aplicacion   = Gn_Codigo_Subaplic
 	       AND esp.codigo_tipo_transaccion = Gn_Codigo_Tipo_Tran;
    EXCEPTION
 	    WHEN NO_DATA_FOUND THEN
 	      -- 4028: Tipo de transaccion inexistente en las transacciones especiales
 	      Gv_CodError := mg_k_ctrl_error.mg_f_armar_codigo_error(4028,'MG_K_IMP_CAR.PU_P_PRO1','BCA/85');
 	      RETURN;
 	    WHEN OTHERS THEN
 	      Gv_CodError := mg_k_ctrl_error.mg_f_armar_codigo_error(0,'MG_K_IMP_CAR.PU_P_PRO1',SQLERRM);
 	      RETURN;
    END;

    DP_P_DIAS_ENTRE_FECHAS_INT(Gn_Dia_De_Pago, Gd_Fecha_Inicial, Gd_Fecha_Final, Ln_Mes, Ln_Dias_Periodo, Gv_CodError);
    IF Gv_CodError IS NOT NULL THEN
      RETURN;
    END IF;

    -- Obtener los días de la frecuencia de cuota de deposito
    CA_K_AHORRO_PROG.CA_P_FRECUENCIA (Gv_Frecuencia_Cuota, Ln_Dias_Frecuencia, Lv_Descripcion_Frecuencia, Gv_CodError);
	  IF Gv_CodError IS NOT NULL THEN
      RETURN;
	  END IF;

    dbms_output.put_line('1. Gn_Dias_Periodo: '||Ln_Dias_Periodo||
                         ' Gv_Codigo_Aplicacion: '||Gv_Codigo_Aplicacion||
                         ' Ln_Base_Calculo: '||Ln_Base_Calculo||
                         ' Gn_Valor_Tasa: '||Gn_Valor_Tasa||
                         ' Gd_Fecha_Inicial: '||Gd_Fecha_Inicial||
                         ' Gd_Fecha_Final: '||Gd_Fecha_Final||
                         ' Ln_Anio := '||Ln_Anio||
                         ' Ln_Mes := '||Ln_Mes||
                         ' Ln_Valor_Interes := '||Ln_Valor_Interes||
                         ' Gn_Dia_De_Pago := '||Gn_Dia_De_Pago||
                         ' Gn_TipoCalculoInteres := '||Gn_TipoCalculoInteres);

    MG_K_INTERCAMBIO_DATOS.SET_NUMBER('MG_K_CALCULOS_GENERALES',NULL,'Gn_Dias_Periodo',Ln_Dias_Periodo);
    MG_K_CALCULOS_GENERALES.MG_P_CALCULA_INTERESES(Gv_Codigo_Aplicacion, Gn_Valor_Cuota, Gn_Valor_Tasa, Gd_Fecha_Inicial,
                                                   Gd_Fecha_Final, Ln_Anio, Ln_Mes, Ln_Valor_Interes,
				                                           Gn_Dia_De_Pago, Gn_TipoCalculoInteres, 2, Gv_CodError);
    MG_K_INTERCAMBIO_DATOS.SET_NUMBER('MG_K_CALCULOS_GENERALES',NULL,'Gn_Dias_Periodo',NULL);
    IF Gv_CodError IS NOT NULL THEN
      RETURN;
    END IF;

    Ln_Secuencia_Insercion := Ln_Secuencia_Insercion + 1;
    lr_proyeccion_cuota.EXTEND;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).numero_cuota  := Ln_Secuencia_Insercion;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).fecha_cuota   := Gd_Fecha_Inicial;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).valor_cuota   := Gn_Valor_Cuota;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).valor_interes := Ln_Valor_Interes;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).dias_periodo  := Ln_Dias_Periodo;

    -- creación de registro del segundo deposito
    Ln_Valor_Interes := 0;
    Ln_Capital       := Gn_Valor_Cuota;
    IF Gn_TipoCalculoInteres = 1 THEN
  	  Ln_Base_Calculo := Ln_Capital;
    ELSE
      Ln_Base_Calculo := NVL(Ln_Capital,0) + nvl(Ln_Interes,0);
    END IF;

    DP_P_DIAS_ENTRE_FECHAS_INT(Gn_Dia_De_Pago, Gd_Fecha_Prm_Cuota, Gd_Fecha_Final, Ln_Mes, Ln_Dias_Periodo, Gv_CodError);
    IF Gv_CodError IS NOT NULL THEN
      RETURN;
    END IF;

    dbms_output.put_line('2. Gn_Dias_Periodo: '||Ln_Dias_Periodo||
                         ' Gv_Codigo_Aplicacion: '||Gv_Codigo_Aplicacion||
                         ' Ln_Base_Calculo: '||Ln_Base_Calculo||
                         ' Gn_Valor_Tasa: '||Gn_Valor_Tasa||
                         ' Gd_Fecha_Prm_Cuota: '||Gd_Fecha_Prm_Cuota||
                         ' Gd_Fecha_Final: '||Gd_Fecha_Final||
                         ' Ln_Anio := '||Ln_Anio||
                         ' Ln_Mes := '||Ln_Mes||
                         ' Ln_Valor_Interes := '||Ln_Valor_Interes||
                         ' Gn_Dia_De_Pago := '||Gn_Dia_De_Pago||
                         ' Gn_TipoCalculoInteres := '||Gn_TipoCalculoInteres);

    MG_K_INTERCAMBIO_DATOS.SET_NUMBER('MG_K_CALCULOS_GENERALES',NULL,'Gn_Dias_Periodo',Ln_Dias_Periodo);
    MG_K_CALCULOS_GENERALES.MG_P_CALCULA_INTERESES(Gv_Codigo_Aplicacion, Ln_Base_Calculo, Gn_Valor_Tasa, Gd_Fecha_Prm_Cuota,
                                                   Gd_Fecha_Final, Ln_Anio, Ln_Mes, Ln_Valor_Interes,
				                                           Gn_Dia_De_Pago, Gn_TipoCalculoInteres, 2, Gv_CodError);
    MG_K_INTERCAMBIO_DATOS.SET_NUMBER('MG_K_CALCULOS_GENERALES',NULL,'Gn_Dias_Periodo',NULL);
    IF Gv_CodError IS NOT NULL THEN
      RETURN;
    END IF;

    Ln_Interes             := NVL(Ln_Interes,0) + NVL(Ln_Valor_Interes,0);
    Ln_Secuencia_Insercion := Ln_Secuencia_Insercion + 1;

    lr_proyeccion_cuota.EXTEND;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).numero_cuota  := Ln_Secuencia_Insercion;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).fecha_cuota   := Gd_Fecha_Prm_Cuota;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).valor_cuota   := Gn_Valor_Cuota;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).valor_interes := Ln_Valor_Interes;
    lr_proyeccion_cuota(Ln_Secuencia_Insercion).dias_periodo  := Ln_Dias_Periodo;

    IF Gd_Fecha_Final > Gd_Fecha_Inicial THEN
  	  Ld_Fecha_Cuota     := Gd_Fecha_Prm_Cuota;
  	  Ld_Fecha_Cuota_Ant := Gd_Fecha_Prm_Cuota;
      Ln_Capital         := nvl(Ln_Capital,0) + nvl(Gn_Valor_Cuota,0);

      CA_K_AHORRO_PROG.CA_P_DATOS_PACTADOS
           (Gn_Codigo_Empresa, Gn_Valor_Cuota,
            Gv_Frecuencia_Cuota, Gn_Plazo,
            Gd_Fecha_Inicial, Gd_Fecha_Final,
            NULL, Gn_Dia_De_Pago,
            Ln_Monto_Pactado, Ln_Cantidad_Cuotas,
            Ld_Fecha_Ultima_Cuota, Gv_CodError);

      IF Gv_CodError IS NOT NULL THEN
        RETURN;
      END IF;

      WHILE Ld_Fecha_Cuota < Ld_Fecha_Ultima_Cuota LOOP
        Ln_Contador := NVL(Ln_Contador,0) + 1;

        dbms_output.put_line('Gn_Codigo_Empresa: '||Gn_Codigo_Empresa||
                             ' Ln_Dias_Frecuencia: '||Ln_Dias_Frecuencia||
                             ' Ld_Fecha_Cuota: '||Ld_Fecha_Cuota||
                             ' Ld_Fecha_Cuota_Ant: '||Ld_Fecha_Cuota_Ant||
                             ' Ld_Fecha_Cuota: '||Ld_Fecha_Cuota||
                             ' Gn_Dia_De_Pago := '||Gn_Dia_De_Pago);

        CA_K_ESTADOS_CUENTA.CA_P_PROXIMA_FECHA_CORTE
             (Gn_Codigo_Empresa,
              Ln_Dias_Frecuencia,
              Ld_Fecha_Cuota,
              Ld_Fecha_Cuota_Ant,
              Gn_Dia_De_Pago,
              Gv_CodError);

        IF Gv_CodError IS NOT NULL THEN
          EXIT;
        END IF;

        Ln_Valor_Interes := 0;
        IF Ld_Fecha_Cuota > Gd_Fecha_Final THEN
      	  Ld_Fecha_Cuota := Gd_Fecha_Final;
        END IF;

        IF Gn_TipoCalculoInteres = 1 THEN
  	      Ln_Base_Calculo := Gn_Valor_Cuota;
        ELSE
          Ln_Base_Calculo := Gn_Valor_Cuota + NVL(Ln_Interes,0);
        END IF;

        DP_P_DIAS_ENTRE_FECHAS_INT (Gn_Dia_De_Pago, Ld_Fecha_Cuota, Gd_Fecha_Final, ln_mes, Ln_Dias_Periodo, Gv_CodError);
        IF Gv_CodError IS NOT NULL THEN
          EXIT;
        END IF;

        IF NVL(Ln_Dias_Periodo,0) > 0 THEN
          dbms_output.put_line('3. Gn_Dias_Periodo: '||Ln_Dias_Periodo||
                               ' Gv_Codigo_Aplicacion: '||Gv_Codigo_Aplicacion||
                               ' Ln_Base_Calculo: '||Ln_Base_Calculo||
                               ' Gn_Valor_Tasa: '||Gn_Valor_Tasa||
                               ' Ld_Fecha_Cuota: '||Ld_Fecha_Cuota||
                               ' Gd_Fecha_Final: '||Gd_Fecha_Final||
                               ' Ln_Anio := '||Ln_Anio||
                               ' Ln_Mes := '||Ln_Mes||
                               ' Ln_Valor_Interes := '||Ln_Valor_Interes||
                               ' Gn_Dia_De_Pago := '||Gn_Dia_De_Pago||
                               ' Gn_TipoCalculoInteres := '||Gn_TipoCalculoInteres);

          MG_K_INTERCAMBIO_DATOS.SET_NUMBER('MG_K_CALCULOS_GENERALES',NULL,'Gn_Dias_Periodo',Ln_Dias_Periodo);
          MG_K_CALCULOS_GENERALES.MG_P_CALCULA_INTERESES (Gv_Codigo_Aplicacion, Ln_Base_Calculo, Gn_Valor_Tasa, Ld_Fecha_Cuota,
                                                          Gd_Fecha_Final, ln_anio, ln_mes, Ln_Valor_Interes,
						                                              Gn_Dia_De_Pago, Gn_TipoCalculoInteres, 2, Gv_CodError);
          MG_K_INTERCAMBIO_DATOS.SET_NUMBER('MG_K_CALCULOS_GENERALES',NULL,'Gn_Dias_Periodo',NULL);
          IF Gv_CodError IS NOT NULL THEN
            EXIT;
          END IF;

          Ln_Interes := NVL(Ln_Interes,0) + NVL(Ln_Valor_Interes,0);

          -- Si la fecha de proximo pago no es la de vencimiento
          IF Ld_Fecha_Cuota < Gd_Fecha_Final THEN
            Ln_Capital             := NVL(Ln_Capital,0) + NVL(Gn_Valor_Cuota,0);
            Ln_Secuencia_Insercion := NVL(Ln_Secuencia_Insercion,0) + 1;
          END IF;

          Ld_Fecha_Cuota_Ant := Ld_Fecha_Cuota;
          lr_proyeccion_cuota.EXTEND;
          lr_proyeccion_cuota(Ln_Secuencia_Insercion).numero_cuota  := Ln_Secuencia_Insercion;
          lr_proyeccion_cuota(Ln_Secuencia_Insercion).fecha_cuota   := Ld_Fecha_Cuota;
          lr_proyeccion_cuota(Ln_Secuencia_Insercion).valor_cuota   := Gn_Valor_Cuota;
          lr_proyeccion_cuota(Ln_Secuencia_Insercion).valor_interes := Ln_Valor_Interes;
          lr_proyeccion_cuota(Ln_Secuencia_Insercion).dias_periodo  := Ln_Dias_Periodo;
        END IF; -- IF NVL(Ln_Dias_Periodo,0) > 0 THEN

        IF Ln_Contador > Gn_Plazo THEN
      	  EXIT;
        END IF;
      END LOOP;

      IF Gv_CodError IS NOT NULL THEN
        RETURN;
      END IF;

      IF lr_proyeccion_cuota.COUNT > 0 THEN
        FOR aplan IN lr_proyeccion_cuota.FIRST .. lr_proyeccion_cuota.LAST
        LOOP
          IF NVL(lr_proyeccion_cuota(aplan).numero_cuota,0) != 0 THEN
            dbms_output.put_line('Numero de Cuota: '||lr_proyeccion_cuota(aplan).numero_cuota||
                                 ' Valor de Cuota: '||lr_proyeccion_cuota(aplan).valor_cuota||
                                 ' Valor de Interés: '||lr_proyeccion_cuota(aplan).valor_interes||
                                 ' Días de Período: '||lr_proyeccion_cuota(aplan).dias_periodo||
                                 ' Fecha de Cuota: '||lr_proyeccion_cuota(aplan).fecha_cuota);
          END IF; -- IF NVL(lr_proyeccion_cuota(aplan).numero_cuota,0) != 0 THEN
        END LOOP;

        lr_proyeccion_cuota.DELETE; -- Se inicializa arreglo de la proyección.
      END IF; -- IF lr_proyeccion_cuota.COUNT > 0 THEN
    END IF; -- IF Gd_Fecha_Final > Gd_Fecha_Inicial THEN
  EXCEPTION
    WHEN OTHERS THEN
      Gv_CodError := mg_k_ctrl_error.mg_f_armar_codigo_error(0,'CA_K_CAR.PU_P_PRO',dbms_utility.format_error_backtrace||' '||SQLERRM);
      RETURN;
  END PU_P_PROYECCION;
BEGIN
  Ln_Tasa_TEI := CA_K_SERVICIOS.CA_F_ASIGNAR_TASA (Ln_Empresa,
                                                   Ln_Agencia,
                                                   Ln_Subaplicacion,
                                                   Ln_Cuenta,
                                                   NULL,
                                                   Ln_Tipo_Asignacion_Tasa,
                                                   Ld_Fecha_Inicio,
                                                   NULL);

  PU_P_PROYECCION (Ln_Empresa,                         -- Gn_Codigo_Empresa      IN NUMBER
                   'BCA',                              -- Gv_Codigo_Aplicacion   IN VARCHAR2
                   Ln_Subaplicacion,                   -- Gn_Codigo_Subaplic     IN NUMBER
                   85,                                 -- Gn_Codigo_Tipo_Tran    IN NUMBER
                   29,                                 -- Gn_Dia_De_Pago         IN NUMBER
                   '1',                                -- Gn_TipoCalculoInteres  IN NUMBER
                   31,                                 -- Gn_Plazo               IN NUMBER
                   'M',                                -- Gv_Frecuencia_Cuota    IN VARCHAR2
                   Ld_Fecha_Inicio,                    -- Gd_Fecha_Inicial       IN DATE
                   Ld_Fecha_Final,                     -- Gd_Fecha_Final         IN DATE
                   TO_DATE('29-06-2014','DD-MM-YYYY'), -- Gd_Fecha_Prm_Cuota     IN DATE
                   200,                                -- Gn_Valor_Cuota         IN NUMBER
                   Ln_Tasa_TEI,                        -- Gn_Valor_Tasa          IN NUMBER
                   Ln_Secuencia,                       -- Gn_Secuencia          OUT NUMBER
                   Lv_CodError);                       -- Gv_CodError           OUT VARCHAR2

  IF Lv_CodError IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20000,Lv_CodError);
  END IF;
END;
/