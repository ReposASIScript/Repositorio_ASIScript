DECLARE
   l_xmltype XMLTYPE;
   l_ctx dbms_xmlgen.ctxhandle;
BEGIN
  l_ctx := dbms_xmlgen.newcontext
           ('SELECT ''@E03CTACODCLI@'' ETIQUETA,
             c.codigo_cliente VALOR_ET,
             ''@E03CTACODCUE@'' ETIQUETA,
             TO_CHAR(c.codigo_agencia) || ''-'' || TO_CHAR(c.codigo_sub_aplicacion) || ''-'' || TO_CHAR(c.numero_prestamo) VALOR_ET,
             ''@E03CTAVADES@'' ETIQUETA,
             c.valor_desembolsos VALOR_ET,
             ''@E03CTANUMDES@'' ETIQUETA,
             c.numero_desembolsos VALOR_ET
        FROM pr_prestamos c,
             pr_contratos b,
             lc_operaciones_x_linea_credito f,
             mg_monedas m,
             mg_sub_aplicaciones e,
             pr_parametros_x_subaplicac s
       WHERE b.numero_contrato          = c.numero_contrato
         AND b.codigo_sub_aplicacion    = c.codigo_sub_aplicacion
         AND b.codigo_agencia           = c.codigo_agencia
         AND b.codigo_empresa           = c.codigo_empresa
         AND s.codigo_sub_aplicacion    = c.codigo_sub_aplicacion
         AND s.codigo_aplicacion        = c.codigo_aplicacion
         AND s.codigo_empresa           = c.codigo_empresa
         AND f.numero_linea_credito(+)  = b.codigo_linea_credito
         AND f.codigo_sub_aplicacion(+) = b.codigo_sub_aplicacion_lc
         AND f.codigo_agencia(+)        = b.codigo_agencia_lc
         AND f.codigo_empresa(+)        = b.codigo_empresa_lc
         AND f.codigo_cuenta_cli(+)     = b.numero_contrato
         AND f.codigo_sub_aplic_cli(+)  = b.codigo_sub_aplicacion
         AND f.codigo_agencia_cli(+)    = b.codigo_agencia
         AND f.codigo_empresa_cli(+)    = b.codigo_empresa
         AND e.codigo_aplicacion        = c.codigo_aplicacion
         AND e.codigo_sub_aplicacion    = c.codigo_sub_aplicacion
         AND m.codigo_moneda            = e.codigo_moneda
         AND c.codigo_empresa           = ' ||1  ||
        'AND c.codigo_agencia           = ' ||39 ||
        'AND c.codigo_sub_aplicacion    = ' ||201||
        'AND c.numero_prestamo          = ' ||230420);

  dbms_xmlgen.setrowsettag(l_ctx, 'DATOS'); 
  dbms_xmlgen.setrowtag(l_ctx, 'DATO_ITEM');

  l_xmltype := dbms_xmlgen.getXmlType(l_ctx) ;
  dbms_xmlgen.closeContext(l_ctx);

  dbms_output.put_line(l_xmltype.getClobVal);
End;
/