CREATE OR REPLACE TYPE phone_t AS OBJECT
  (a_code     CHAR(3),
   p_number   CHAR(8),
   v_country  CHAR(50));
/

CREATE OR REPLACE FUNCTION retphone
RETURN phone_t IS
  tPhone  phone_t;
BEGIN
  tPhone           := NEW phone_t('','','');
  tPhone.a_code    := '002';
  tPhone.p_number  := '29824232';
  tPhone.v_country := 'Panamá';

  RETURN tPhone;
END retphone;
/