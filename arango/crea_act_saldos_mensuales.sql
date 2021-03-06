DECLARE
    CURSOR Cur_saldos_mensuales
    IS
    SELECT b.Nivel_1, b.Nivel_2,  b.Nivel_3,  b.Nivel_4,
           b.Nivel_5, b.Nivel_6,  b.Nivel_7,  b.Nivel_8, a.codigo_empresa,
            sum(nvl(SALDO_ACUMULADO_ANUAL,0)) SALDO_ACUMULADO_ANUAL,
            sum(nvl(SALDO_MES_ANTERIOR_CALENDARIO,0))  SALDO_MES_ANTERIOR_CALENDARIO,
            sum(nvl(CANTIDAD_DB_MES_1,0)) CANTIDAD_DB_MES_1,
            sum(nvl(CANTIDAD_DB_MES_2,0)) CANTIDAD_DB_MES_2,
            sum(nvl(CANTIDAD_DB_MES_3,0)) CANTIDAD_DB_MES_3,
            sum(nvl(CANTIDAD_DB_MES_4,0)) CANTIDAD_DB_MES_4,
            sum(nvl(CANTIDAD_DB_MES_5,0)) CANTIDAD_DB_MES_5,
            sum(nvl(CANTIDAD_DB_MES_6,0)) CANTIDAD_DB_MES_6,
            sum(nvl(CANTIDAD_DB_MES_7,0)) CANTIDAD_DB_MES_7,
            sum(nvl(CANTIDAD_DB_MES_8,0)) CANTIDAD_DB_MES_8,
            sum(nvl(CANTIDAD_DB_MES_9,0)) CANTIDAD_DB_MES_9,
            sum(nvl(CANTIDAD_DB_MES_10,0)) CANTIDAD_DB_MES_10,
            sum(nvl(CANTIDAD_DB_MES_11,0)) CANTIDAD_DB_MES_11,
            sum(nvl(CANTIDAD_DB_MES_12,0)) CANTIDAD_DB_MES_12,
            sum(nvl(CANTIDAD_CR_MES_1,0)) CANTIDAD_CR_MES_1,
            sum(nvl(CANTIDAD_CR_MES_2,0)) CANTIDAD_CR_MES_2,
            sum(nvl(CANTIDAD_CR_MES_3,0)) CANTIDAD_CR_MES_3,
            sum(nvl(CANTIDAD_CR_MES_4,0)) CANTIDAD_CR_MES_4,
            sum(nvl(CANTIDAD_CR_MES_5,0)) CANTIDAD_CR_MES_5,
            sum(nvl(CANTIDAD_CR_MES_6,0)) CANTIDAD_CR_MES_6,
            sum(nvl(CANTIDAD_CR_MES_7,0)) CANTIDAD_CR_MES_7,
            sum(nvl(CANTIDAD_CR_MES_8,0)) CANTIDAD_CR_MES_8,
            sum(nvl(CANTIDAD_CR_MES_9,0)) CANTIDAD_CR_MES_9,
            sum(nvl(CANTIDAD_CR_MES_10,0)) CANTIDAD_CR_MES_10,
            sum(nvl(CANTIDAD_CR_MES_11,0)) CANTIDAD_CR_MES_11,
            sum(nvl(CANTIDAD_CR_MES_12,0)) CANTIDAD_CR_MES_12,
            sum(nvl(TOTAL_DB_MES_1,0)) TOTAL_DB_MES_1,
            sum(nvl(TOTAL_DB_MES_2,0)) TOTAL_DB_MES_2,
            sum(nvl(TOTAL_DB_MES_3,0)) TOTAL_DB_MES_3,
            sum(nvl(TOTAL_DB_MES_4,0)) TOTAL_DB_MES_4,
            sum(nvl(TOTAL_DB_MES_5,0)) TOTAL_DB_MES_5,
            sum(nvl(TOTAL_DB_MES_6,0)) TOTAL_DB_MES_6,
            sum(nvl(TOTAL_DB_MES_7,0)) TOTAL_DB_MES_7,
            sum(nvl(TOTAL_DB_MES_8,0)) TOTAL_DB_MES_8,
            sum(nvl(TOTAL_DB_MES_9,0)) TOTAL_DB_MES_9,
            sum(nvl(TOTAL_DB_MES_10,0)) TOTAL_DB_MES_10,
            sum(nvl(TOTAL_DB_MES_11,0)) TOTAL_DB_MES_11,
            sum(nvl(TOTAL_DB_MES_12,0)) TOTAL_DB_MES_12,
            sum(nvl(TOTAL_CR_MES_1,0))  TOTAL_CR_MES_1,
            sum(nvl(TOTAL_CR_MES_2,0))  TOTAL_CR_MES_2,
            sum(nvl(TOTAL_CR_MES_3,0))  TOTAL_CR_MES_3,
            sum(nvl(TOTAL_CR_MES_4,0))  TOTAL_CR_MES_4,
            sum(nvl(TOTAL_CR_MES_5,0))  TOTAL_CR_MES_5,
            sum(nvl(TOTAL_CR_MES_6,0))  TOTAL_CR_MES_6,
            sum(nvl(TOTAL_CR_MES_7,0))  TOTAL_CR_MES_7,
            sum(nvl(TOTAL_CR_MES_8,0))  TOTAL_CR_MES_8,
            sum(nvl(TOTAL_CR_MES_9,0))  TOTAL_CR_MES_9,
            sum(nvl(TOTAL_CR_MES_10,0))  TOTAL_CR_MES_10,
            sum(nvl(TOTAL_CR_MES_11,0))  TOTAL_CR_MES_11,
            sum(nvl(TOTAL_CR_MES_12,0))  TOTAL_CR_MES_12,
            sum(nvl(SALDO_MES_1,0)) SALDO_MES_1,
            sum(nvl(SALDO_MES_2,0)) SALDO_MES_2,
            sum(nvl(SALDO_MES_3,0)) SALDO_MES_3,
            sum(nvl(SALDO_MES_4,0)) SALDO_MES_4,
            sum(nvl(SALDO_MES_5,0)) SALDO_MES_5,
            sum(nvl(SALDO_MES_6,0)) SALDO_MES_6,
            sum(nvl(SALDO_MES_7,0)) SALDO_MES_7,
            sum(nvl(SALDO_MES_8,0)) SALDO_MES_8,
            sum(nvl(SALDO_MES_9,0)) SALDO_MES_9,
            sum(nvl(SALDO_MES_10,0)) SALDO_MES_10,
            sum(nvl(SALDO_MES_11,0)) SALDO_MES_11,
            sum(nvl(SALDO_MES_12,0)) SALDO_MES_12,
            sum(nvl(CANTIDAD_DB_MES_13,0)) CANTIDAD_DB_MES_13,
            sum(nvl(CANTIDAD_CR_MES_13,0))	CANTIDAD_CR_MES_13,
            sum(nvl(TOTAL_DB_MES_13,0))	TOTAL_DB_MES_13,
            sum(nvl(TOTAL_CR_MES_13,0))	TOTAL_CR_MES_13,
            sum(nvl(SALDO_MES_13,0)) SALDO_MES_13
        FROM   GM_CUENTAS_SUMARIAS b,
           GM_saldos_mensuales  a,
         GM_TIPOS_DE_CUENTAS c, GM_BALANCE_CUENTAS  d,
         GM_BALANCE_CUENTAS  f,
         GM_TIPOS_DE_CUENTAS e
    WHERE b.cuenta_hasta >= a.nivel_1||a.nivel_2||a.nivel_3||a.nivel_4||a.nivel_5||
                  a.nivel_6||a.nivel_7||a.nivel_8
    AND   b.cuenta_desde <= a.nivel_1||a.nivel_2||a.nivel_3||a.nivel_4||a.nivel_5||
                  a.nivel_6||a.nivel_7||a.nivel_8
    and a.anio = 2011
    AND   b.codigo_empresa = 1
    and b.nivel_1 = '8280'
    and b.nivel_2 = '00'
    and b.nivel_3 = '00'
    and b.nivel_4 = '1'
    and b.nivel_5 = '0000'
  AND  d.cuenta = b.nivel_1||b.nivel_2||b.nivel_3||b.nivel_4||b.nivel_5||
                  b.nivel_6||b.nivel_7||b.nivel_8
  AND  f.cuenta = a.nivel_1||a.nivel_2||a.nivel_3||a.nivel_4||a.nivel_5||
                  a.nivel_6||a.nivel_7||a.nivel_8
  AND   f.Codigo_Empresa = b.Codigo_Empresa
    AND   f.recibe_movimiento  = 'S'
    AND  f.codigo_tipo = c.codigo_tipo                
    AND  e.codigo_tipo = d.codigo_tipo
    group by b.Nivel_1, b.Nivel_2,  b.Nivel_3,  b.Nivel_4,
             b.Nivel_5, b.Nivel_6,  b.Nivel_7,  b.Nivel_8, a.codigo_empresa;
    
    Ln_AnioBase   number := 2011;
    --Ln_MesBase    number := 01;
    Lv_Cuenta           Varchar2(32);
  BEGIN
    /******
            Sumarizacion para saldos mensuales
     ******/
    FOR I IN Cur_saldos_mensuales LOOP
     Lv_Cuenta := I.nivel_1||I.nivel_2||I.nivel_3||I.nivel_4||
                  I.nivel_5||I.nivel_6||I.nivel_7||I.nivel_8;
               UPDATE GM_SALDOS_mensuales
    SET SALDO_ACUMULADO_ANUAL = I.SALDO_ACUMULADO_ANUAL, 
        SALDO_MES_ANTERIOR_CALENDARIO = I.SALDO_MES_ANTERIOR_CALENDARIO,
        CANTIDAD_DB_MES_1	= I.CANTIDAD_DB_MES_1,
        CANTIDAD_DB_MES_2	= I.CANTIDAD_DB_MES_2,
        CANTIDAD_DB_MES_3	= I.CANTIDAD_DB_MES_3,
        CANTIDAD_DB_MES_4	= I.CANTIDAD_DB_MES_4,
        CANTIDAD_DB_MES_5	= I.CANTIDAD_DB_MES_5,
        CANTIDAD_DB_MES_6	= I.CANTIDAD_DB_MES_6,
        CANTIDAD_DB_MES_7	= I.CANTIDAD_DB_MES_7,
        CANTIDAD_DB_MES_8	= I.CANTIDAD_DB_MES_8,
        CANTIDAD_DB_MES_9	= I.CANTIDAD_DB_MES_9,
        CANTIDAD_DB_MES_10	= I.CANTIDAD_DB_MES_10,
        CANTIDAD_DB_MES_11	= I.CANTIDAD_DB_MES_11,
        CANTIDAD_DB_MES_12	= I.CANTIDAD_DB_MES_12,
        CANTIDAD_CR_MES_1	= I.CANTIDAD_CR_MES_1,
        CANTIDAD_CR_MES_2	= I.CANTIDAD_CR_MES_2,
        CANTIDAD_CR_MES_3	= I.CANTIDAD_CR_MES_3,
        CANTIDAD_CR_MES_4	= I.CANTIDAD_CR_MES_4,
        CANTIDAD_CR_MES_5	= I.CANTIDAD_CR_MES_5,
        CANTIDAD_CR_MES_6	= I.CANTIDAD_CR_MES_6,
        CANTIDAD_CR_MES_7	= I.CANTIDAD_CR_MES_7,
        CANTIDAD_CR_MES_8	= I.CANTIDAD_CR_MES_8,
        CANTIDAD_CR_MES_9	= I.CANTIDAD_CR_MES_9,
        CANTIDAD_CR_MES_10	= I.CANTIDAD_CR_MES_10,
        CANTIDAD_CR_MES_11	= I.CANTIDAD_CR_MES_11,
        CANTIDAD_CR_MES_12	= I.CANTIDAD_CR_MES_12,
        TOTAL_DB_MES_1	    = I.TOTAL_DB_MES_1,
        TOTAL_DB_MES_2	    = I.TOTAL_DB_MES_2,
        TOTAL_DB_MES_3	    = I.TOTAL_DB_MES_3,
        TOTAL_DB_MES_4	    = I.TOTAL_DB_MES_4,
        TOTAL_DB_MES_5	    = I.TOTAL_DB_MES_5,
        TOTAL_DB_MES_6	    = I.TOTAL_DB_MES_6,
        TOTAL_DB_MES_7	    = I.TOTAL_DB_MES_7, 
        TOTAL_DB_MES_8	    = I.TOTAL_DB_MES_8,
        TOTAL_DB_MES_9	    = I.TOTAL_DB_MES_9,
        TOTAL_DB_MES_10	    = I.TOTAL_DB_MES_10,
        TOTAL_DB_MES_11	    = I.TOTAL_DB_MES_11,
        TOTAL_DB_MES_12	    = I.TOTAL_DB_MES_12,
        TOTAL_CR_MES_1	    = I.TOTAL_CR_MES_1,
        TOTAL_CR_MES_2	    = I.TOTAL_CR_MES_2,
        TOTAL_CR_MES_3	    = I.TOTAL_CR_MES_3,
        TOTAL_CR_MES_4	    = I.TOTAL_CR_MES_4,
        TOTAL_CR_MES_5	    = I.TOTAL_CR_MES_5,
        TOTAL_CR_MES_6	    = I.TOTAL_CR_MES_6,
        TOTAL_CR_MES_7	    = I.TOTAL_CR_MES_7,
        TOTAL_CR_MES_8	    = I.TOTAL_CR_MES_8,
        TOTAL_CR_MES_9	    = I.TOTAL_CR_MES_9,
        TOTAL_CR_MES_10	    = I.TOTAL_CR_MES_10,
        TOTAL_CR_MES_11	    = I.TOTAL_CR_MES_11,
        TOTAL_CR_MES_12	    = I.TOTAL_CR_MES_12,
        SALDO_MES_1	        = I.SALDO_MES_1,
        SALDO_MES_2	        = I.SALDO_MES_2,
        SALDO_MES_3         = I.SALDO_MES_3, 	
        SALDO_MES_4	        = I.SALDO_MES_4,
        SALDO_MES_5	        = I.SALDO_MES_5,
        SALDO_MES_6	        = I.SALDO_MES_6,
        SALDO_MES_7	        = I.SALDO_MES_7,
        SALDO_MES_8	        = I.SALDO_MES_8,
        SALDO_MES_9	        = I.SALDO_MES_9,
        SALDO_MES_10	    = I.SALDO_MES_10,
        SALDO_MES_11	    = I.SALDO_MES_11,
        SALDO_MES_12	    = I.SALDO_MES_12,
        CANTIDAD_DB_MES_13	= I.CANTIDAD_DB_MES_13, 
        CANTIDAD_CR_MES_13	= I.CANTIDAD_CR_MES_13,
        TOTAL_DB_MES_13	    = I.TOTAL_DB_MES_13,
        TOTAL_CR_MES_13	    = I.TOTAL_CR_MES_13,
        SALDO_MES_13	    = I.SALDO_MES_13
        
      WHERE anio = Ln_AnioBase    AND codigo_empresa = 1  AND nivel_1 = I.Nivel_1  AND nivel_2 = I.Nivel_2
       AND nivel_3 = I.Nivel_3  AND nivel_4 = I.Nivel_4   AND nivel_5 = I.Nivel_5        AND nivel_6 = I.Nivel_6  AND nivel_7 = I.Nivel_7
       AND nivel_8 = I.Nivel_8;
      IF SQL%NOTFOUND THEN
         INSERT INTO GM_SALDOS_MENSUALES (
            ANIO	,
            CODIGO_EMPRESA	,
            NIVEL_1	,
            NIVEL_2	,
            NIVEL_3	,
            NIVEL_4	,
            NIVEL_5	,
            NIVEL_6	,
            NIVEL_7	,
            NIVEL_8	,
        SALDO_ACUMULADO_ANUAL	,
        SALDO_MES_ANTERIOR_CALENDARIO 	,
        CANTIDAD_DB_MES_1	,
        CANTIDAD_DB_MES_2	,
        CANTIDAD_DB_MES_3	,
        CANTIDAD_DB_MES_4	,
        CANTIDAD_DB_MES_5	,
        CANTIDAD_DB_MES_6	,
        CANTIDAD_DB_MES_7	,
        CANTIDAD_DB_MES_8	,
        CANTIDAD_DB_MES_9	,
        CANTIDAD_DB_MES_10	,
        CANTIDAD_DB_MES_11	,
        CANTIDAD_DB_MES_12	,
        CANTIDAD_CR_MES_1	,
        CANTIDAD_CR_MES_2	,
        CANTIDAD_CR_MES_3	,
        CANTIDAD_CR_MES_4	,
        CANTIDAD_CR_MES_5	,
        CANTIDAD_CR_MES_6	,
        CANTIDAD_CR_MES_7	,
        CANTIDAD_CR_MES_8	,
        CANTIDAD_CR_MES_9	,
        CANTIDAD_CR_MES_10	,
        CANTIDAD_CR_MES_11	,
        CANTIDAD_CR_MES_12	,
        TOTAL_DB_MES_1	,
        TOTAL_DB_MES_2	,
        TOTAL_DB_MES_3	,
        TOTAL_DB_MES_4	,
        TOTAL_DB_MES_5	,
        TOTAL_DB_MES_6	,
        TOTAL_DB_MES_7	,
        TOTAL_DB_MES_8	,
        TOTAL_DB_MES_9	,
        TOTAL_DB_MES_10	,
        TOTAL_DB_MES_11	,
        TOTAL_DB_MES_12	,
        TOTAL_CR_MES_1	,
        TOTAL_CR_MES_2	,
        TOTAL_CR_MES_3	,
        TOTAL_CR_MES_4	,
        TOTAL_CR_MES_5	,
        TOTAL_CR_MES_6	,
        TOTAL_CR_MES_7	,
        TOTAL_CR_MES_8	,
        TOTAL_CR_MES_9	,
        TOTAL_CR_MES_10	,
        TOTAL_CR_MES_11	,
        TOTAL_CR_MES_12	,
        SALDO_MES_1	,
        SALDO_MES_2	,
        SALDO_MES_3 	,
        SALDO_MES_4	,
        SALDO_MES_5	,
        SALDO_MES_6	,
        SALDO_MES_7	,
        SALDO_MES_8	,
        SALDO_MES_9	,
        SALDO_MES_10	,
        SALDO_MES_11	,
        SALDO_MES_12	,
        CANTIDAD_DB_MES_13	,
        CANTIDAD_CR_MES_13	,
        TOTAL_DB_MES_13	,
        TOTAL_CR_MES_13	,
        SALDO_MES_13)	
       values
       (  2011	,
            1	,
            I.NIVEL_1	,
            I.NIVEL_2	,
            I.NIVEL_3	,
            I.NIVEL_4	,
            I.NIVEL_5	,
            I.NIVEL_6	,
            I.NIVEL_7	,
            I.NIVEL_8	,
        I.SALDO_ACUMULADO_ANUAL	,
        I.SALDO_MES_ANTERIOR_CALENDARIO 	,
        I.CANTIDAD_DB_MES_1	,
        I.CANTIDAD_DB_MES_2	,
        I.CANTIDAD_DB_MES_3	,
        I.CANTIDAD_DB_MES_4	,
        I.CANTIDAD_DB_MES_5	,
        I.CANTIDAD_DB_MES_6	,
        I.CANTIDAD_DB_MES_7	,
        I.CANTIDAD_DB_MES_8	,
        I.CANTIDAD_DB_MES_9	,
        I.CANTIDAD_DB_MES_10	,
        I.CANTIDAD_DB_MES_11	,
        I.CANTIDAD_DB_MES_12	,
        I.CANTIDAD_CR_MES_1	,
        I.CANTIDAD_CR_MES_2	,
        I.CANTIDAD_CR_MES_3	,
        I.CANTIDAD_CR_MES_4	,
        I.CANTIDAD_CR_MES_5	,
        I.CANTIDAD_CR_MES_6	,
        I.CANTIDAD_CR_MES_7	,
        I.CANTIDAD_CR_MES_8	,
        I.CANTIDAD_CR_MES_9	,
        I.CANTIDAD_CR_MES_10	,
        I.CANTIDAD_CR_MES_11	,
        I.CANTIDAD_CR_MES_12	,
        I.TOTAL_DB_MES_1	,
        I.TOTAL_DB_MES_2	,
        I.TOTAL_DB_MES_3	,
        I.TOTAL_DB_MES_4	,
        I.TOTAL_DB_MES_5	,
        I.TOTAL_DB_MES_6	,
        I.TOTAL_DB_MES_7	,
        I.TOTAL_DB_MES_8	,
        I.TOTAL_DB_MES_9	,
        I.TOTAL_DB_MES_10	,
        I.TOTAL_DB_MES_11	,
        I.TOTAL_DB_MES_12	,
        I.TOTAL_CR_MES_1	,
        I.TOTAL_CR_MES_2	,
        I.TOTAL_CR_MES_3	,
        I.TOTAL_CR_MES_4	,
        I.TOTAL_CR_MES_5	,
        I.TOTAL_CR_MES_6	,
        I.TOTAL_CR_MES_7	,
        I.TOTAL_CR_MES_8	,
        I.TOTAL_CR_MES_9	,
        I.TOTAL_CR_MES_10	,
        I.TOTAL_CR_MES_11	,
        I.TOTAL_CR_MES_12	,
        I.SALDO_MES_1	,
        I.SALDO_MES_2	,
        I.SALDO_MES_3 	,
        I.SALDO_MES_4	,
        I.SALDO_MES_5	,
        I.SALDO_MES_6	,
        I.SALDO_MES_7	,
        I.SALDO_MES_8	,
        I.SALDO_MES_9	,
        I.SALDO_MES_10	,
        I.SALDO_MES_11	,
        I.SALDO_MES_12	,
        I.CANTIDAD_DB_MES_13	,
        I.CANTIDAD_CR_MES_13	,
        I.TOTAL_DB_MES_13	,
        I.TOTAL_CR_MES_13	,
        I.SALDO_MES_13
               );
     End if;
   END LOOP;

    
 END;
