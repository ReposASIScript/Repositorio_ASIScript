DECLARE
 Tipo    BE_OR_DOCUMENTO;
BEGIN
  Tipo := new BE_OR_DOCUMENTO (1,null,1,'hola',1,1);
  --dbms_output.put_line(BE_OR_DOCUMENTO(4,6));
END;