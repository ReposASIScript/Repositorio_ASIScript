CREATE OR REPLACE PACKAGE QB_ENCRIPCION AS
--**********************************************************************************************************
--** OBJETIVO             : CONTIENE LAS UTILIDADES DE ENCRIPCION Y DESENCRIPCION 
--** ESQUEMA              : UTIL
--** NOMBRE               : QB_ENCRIPCION / HEADER
--** AUTOR                : JAIRO ANDRES RIVERA RODRIGUEZ
--** FECHA MODIFICACION   : 24/AGOSTO/2011
--**********************************************************************************************************
   
   --------------------------------------------------------------------------
   -------------------- FUNCION QUE CODIFICA UN TEXTO------------------------
   --------------------------------------------------------------------------
   FUNCTION FB_ENCRIPTAR( TXT_ENCRIP VARCHAR2 ) RETURN RAW;
    
   --------------------------------------------------------------------------
   ------------------- FUNCION QUE DECODIFICA UN TEXTO-----------------------
   --------------------------------------------------------------------------
    
   FUNCTION FB_DESCENCRIPTAR( TXT_DESENCRIP VARCHAR2 ) RETURN VARCHAR2;
       
END QB_ENCRIPCION;
/

CREATE OR REPLACE PACKAGE BODY QB_ENCRIPCION AS
    
--**********************************************************************************************************
--** OBJETIVO             : CONTIENE LAS UTILIDADES DE ENCRIPCION Y DESENCRIPCION 
--** ESQUEMA              : UTIL
--** NOMBRE               : QB_ENCRIPCION / BODY
--** AUTOR                : JAIRO ANDRES RIVERA RODRIGUEZ
--** FECHA MODIFICACION   : 24/AGOSTO/2011
--**********************************************************************************************************
      
   CRYPT_RAW   RAW(2000);
   CRYPT_STR   VARCHAR(2000);
   -- LLAVE DE ENCRIPCION
   KEY_ENCRIP  VARCHAR(255):='ASXRFGTR';
 
   --------------------------------------------------------------------------
   -------------------- FUNCION QUE CODIFICA UN TEXTO------------------------
   --------------------------------------------------------------------------
    
   FUNCTION FB_ENCRIPTAR( TXT_ENCRIP VARCHAR2 ) RETURN RAW AS
      L        INTEGER := LENGTH(TXT_ENCRIP);
      I        INTEGER;
      PADBLOCK RAW(2000);
      CLE      RAW(8)  := UTL_RAW.CAST_TO_RAW(KEY_ENCRIP);
     BEGIN
      I := 8-MOD(L,8);
      PADBLOCK := UTL_RAW.CAST_TO_RAW(TXT_ENCRIP||RPAD(CHR(I),I,CHR(I)));
      DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT(
               INPUT          => PADBLOCK,
               KEY            => CLE,
               ENCRYPTED_DATA => CRYPT_RAW );
      RETURN CRYPT_RAW ;
   END;
    
   --------------------------------------------------------------------------
   ------------------- FUNCION QUE DECODIFICA UN TEXTO-----------------------
   --------------------------------------------------------------------------
    
   FUNCTION FB_DESCENCRIPTAR( TXT_DESENCRIP VARCHAR2 ) RETURN VARCHAR2 AS
   L          NUMBER;
   CLE        RAW(8)    := UTL_RAW.CAST_TO_RAW(KEY_ENCRIP);
   CRYPT_RAW  RAW(2000) := UTL_RAW.CAST_TO_RAW(UTL_RAW.CAST_TO_VARCHAR2( TXT_DESENCRIP)) ;
   BEGIN
      DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT(
               INPUT          =>  TXT_DESENCRIP,
               KEY            =>  CLE,
               DECRYPTED_DATA =>  CRYPT_RAW );
      CRYPT_STR := UTL_RAW.CAST_TO_VARCHAR2(CRYPT_RAW);
      L := LENGTH(CRYPT_STR);
      CRYPT_STR := RPAD(CRYPT_STR,L-ASCII(SUBSTR(CRYPT_STR,L)));
      RETURN CRYPT_STR;
   END;
END QB_ENCRIPCION;
/