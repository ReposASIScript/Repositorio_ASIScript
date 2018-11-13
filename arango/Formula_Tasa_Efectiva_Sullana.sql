SELECT ROUND(NVL((((POWER((1+(&porc_tasa/100)),((nvl(&dias,1))/360))-1))*&capital),0),2) interes_calculado_efectivo FROM DUAL
/