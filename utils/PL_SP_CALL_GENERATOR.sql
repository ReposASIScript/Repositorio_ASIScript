DECLARE
  CURSOR C_Argumentos_Programas (Cv_PacNam   IN All_Arguments.Package_Name%TYPE,
                                 Cv_ObjNam   IN All_Arguments.Object_Name%TYPE,
                                 Cv_Owner    IN All_Arguments.Owner%TYPE) IS
    SELECT arg.position orden, arg.argument_name parametro, arg.in_out entrada_salida, arg.data_type tipo_de_dato
      FROM all_arguments arg
     WHERE arg.package_name = NVL(C_Argumentos_Programas.Cv_PacNam, arg.package_name)
       AND arg.object_name  = C_Argumentos_Programas.Cv_ObjNam
       AND arg.owner        = NVL(UPPER(C_Argumentos_Programas.Cv_Owner), USER)
  ORDER BY arg.position ASC;
BEGIN
  FOR arg IN C_Argumentos_Programas (Cv_PacNam => :P_NomPaquete, Cv_ObjNam => :P_NomObjeto, Cv_Owner => :P_Usuario)
  LOOP

  END LOOP;
END;
/