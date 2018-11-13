SELECT dbms_xmlgen.getxml('SELECT codigo_aplicacion dato_item, codigo_sub_aplicacion dato_item, fecha dato_item,
                                  tasa_minima dato_item, tasa_maxima dato_item, adicionado_por
                             FROM mg_tasas_min_max') xml
FROM dual
/