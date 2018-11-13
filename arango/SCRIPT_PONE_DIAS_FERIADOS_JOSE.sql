DECLARE
  ld_dia               DATE := '04-01-2018';
  ld_fecha_desde       DATE := '04-01-2018';
  ld_fecha_hasta       DATE := '20-01-2018';
  pn_codigo_empresa    NUMBER:=1;
  pn_es_habil          NUMBER:=1;
  pv_trabaja_domingo   VARCHAR2 (19);
  pv_trabaja_sabado    VARCHAR2 (19);
  pv_mensaje_error     VARCHAR2 (2000);
BEGIN
  WHILE (ld_dia >= ld_fecha_desde AND ld_dia <= ld_fecha_hasta) LOOP
    Mg_P_Dia_Habil (Pd_Fecha           => Ld_Dia,
                    Pn_Codigo_Empresa  => Pn_Codigo_Empresa,
                    Pn_Es_Habil        => Pn_Es_Habil,
                    Pv_Trabaja_Domingo => Pv_Trabaja_Domingo,
                    Pv_Trabaja_Sabado  => Pv_Trabaja_Sabado,
                    Pv_Mensaje_Error   => Pv_Mensaje_Error);

    IF Pn_Es_Habil = 1 THEN
      BEGIN
        INSERT INTO Mg_Dias_Feriado (Fecha_Dia_Feriado, Descripcion, Adicionado_Por, Fecha_Adicion) VALUES (Ld_Dia, 'TEST', USER, SYSDATE);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
    END IF; -- IF Pn_Es_Habil = 1 THEN

    Ld_Dia := Ld_Dia + 1;
  END LOOP; -- WHILE (ld_dia >= ld_fecha_desde AND ld_dia <= ld_fecha_hasta) LOOP

  COMMIT;
END;
/