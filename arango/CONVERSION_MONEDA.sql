SET SERVEROUTPUT ON

DECLARE
  GN_CODIGOEMPRESA               NUMBER:=1;
  GN_CODIGOMONEDAORIGEN          NUMBER:=&moneda_origen;
  GN_CODIGOMONEDADESTINO         NUMBER:=&moneda_destino;
  GN_TIPOCAMBIO                  NUMBER:=2;
  GD_FECHACAMBIOORIGEN           DATE;
  GD_FECHAHOY                    DATE:=TO_DATE('&fecha_calendario','DD-MM-YYYY');
  GN_TASACAMBIOORIGEN            NUMBER:=&Tasa_Cambio_Origen;
  GN_TASACAMBIODESTINO           NUMBER:=&Tasa_Cambio_Destino;
  GN_FACTORTASA                  NUMBER;
  GN_MONTOORIGEN                 NUMBER:=&monto_origen;
  GN_MONTODESTINO                NUMBER;
  GN_DIFERENCIACAMBIO            NUMBER;
  GN_GANANCIAPERDIDA             NUMBER;
  GV_MENSAJEERROR                VARCHAR2(200);
BEGIN
  MG_P_CAMBIOMONEDA (GN_CODIGOEMPRESA,
                     GN_CODIGOMONEDAORIGEN,
                     GN_CODIGOMONEDADESTINO,
                     GN_TIPOCAMBIO,
                     GD_FECHACAMBIOORIGEN,
                     GD_FECHAHOY,
                     GN_TASACAMBIOORIGEN,
                     GN_TASACAMBIODESTINO,
                     GN_FACTORTASA,
                     GN_MONTOORIGEN,
                     GN_MONTODESTINO,
                     GN_DIFERENCIACAMBIO,
                     GN_GANANCIAPERDIDA,
                     GV_MENSAJEERROR);
  If GV_MENSAJEERROR IS NOT NULL Then
    RAISE_APPLICATION_ERROR(-20000,GV_MENSAJEERROR);
  Else
    DBMS_OUTPUT.PUT_LINE('Monto Origen: '||GN_MONTOORIGEN||' '||'Monto Destino: '||GN_MONTODESTINO);
  End If;
END;
/