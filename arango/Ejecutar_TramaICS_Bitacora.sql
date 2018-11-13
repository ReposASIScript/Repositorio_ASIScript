set serveroutput on size 80000
set trimspool on
set verify off
set heading off 
set feedback off 
set linesize 255 
set pagesize 10000
set lines    300
DECLARE
  CURSOR C_BitacoraMsgAut(Cn_Secuencia NUMBER) IS
  SELECT mensaje_req
  FROM   is_bitacora_mensajes_aut
  WHERE  secuencia_mensaje = Cn_Secuencia
  ORDER BY secuencia_mensaje DESC;

  Lc_BitacoraMsgAut   C_BitacoraMsgAut%ROWTYPE;
  Lv_CodError          VARCHAR2(200);
  Li_CodProceso       INTEGER(3) := '&proc';
  Li_Secuencia        NUMBER     := '&sec';
  Lb_NotFound         BOOLEAN;
BEGIN
  IF Li_CodProceso IS NOT NULL AND Li_Secuencia IS NOT NULL THEN
    OPEN C_BitacoraMsgAut(Li_Secuencia);
    LOOP
      FETCH C_BitacoraMsgAut INTO Lc_BitacoraMsgAut;
      Lb_NotFound := C_BitacoraMsgAut%NOTFOUND;
      EXIT WHEN Lb_NotFound;
      IS_K_PROTOCOLOS.IS_P_AUTORIZAR_MSG(Li_CodProceso, 
                                         Lc_BitacoraMsgAut.mensaje_req, 
                                         Lv_CodError);
      IF Lv_CodError IS NOT NULL THEN
        EXIT;
      END IF;
    END LOOP;
    CLOSE C_BitacoraMsgAut;
    IF Lv_CodError IS NOT NULL THEN
      dbms_output.put_line('Lv_CodError: '||Lv_CodError);
      RETURN;
    END IF;
    commit;
  END IF;
END;
/
set term off
spool ics_protocolos.sql
select rtrim(texto)
from is_protocolo_generado
where codigo_protocolo in (0,&prot)
order by codigo_protocolo,nombre_programa,linea;
spool off
set heading on
set term on
set echo on
set echo off