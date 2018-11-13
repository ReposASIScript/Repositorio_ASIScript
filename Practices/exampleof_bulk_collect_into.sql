DECLARE
  TYPE t_descripcion IS TABLE OF MG_PAISES%ROWTYPE;
  v_descripcion t_descripcion;
BEGIN
  SELECT *
    BULK COLLECT INTO v_descripcion
    FROM MG_PAISES; 

  FOR i IN v_descripcion.FIRST .. v_descripcion.LAST LOOP
    dbms_output.put_line(v_descripcion(i).nombre);
  END LOOP;
END;
/