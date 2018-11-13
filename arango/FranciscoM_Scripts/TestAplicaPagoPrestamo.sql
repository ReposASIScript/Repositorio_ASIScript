declare
ld_fechahoy date;
cursor c_prestamo is
  select * from pr_prestamos where numero_prestamo = &prestamo;
r_prestamo c_prestamo%rowtype;
gv_tipopago varchar2(1) := '&tipopago';
gn_cuotasapagar number := &cuotaspagar;
gn_codigooperacion number := 2;
montoadistribuir number;
montoabonoextracapital number;
ld_fechavalida date;
ln_numerorecibo number;
ln_movimieintosrelacionados number;
ln_secuenciamovimiento number;
pago pr_k_aplica_pago_prestamo.t_pago;
identificadorerror varchar2(300);
ln_total number := 0;
Operador number;
--Operador segun ubicacion contbale
FUNCTION F_OPERADOR (CodigoSubAplicacion Number, CodigoTipoSaldo Number) RETURN Number IS
CURSOR C_Operador IS
  SELECT decode(nvl(ubicacion_contable,'A'),'P', -1, 1) operador 
    FROM pr_tipo_saldo_subaplicacion
   WHERE codigo_sub_aplicacion = CodigoSubAplicacion
     AND codigo_tipo_saldo = CodigoTipoSaldo;
Li_Operador Number;
BEGIN
  OPEN C_Operador;
  FETCH C_Operador INTO Li_Operador;
  IF C_Operador%NotFound THEN
    Li_Operador := 0;
  END IF;
  CLOSE C_Operador;
  RETURN Li_Operador;
END;
begin
  if ld_fechavalida is not null then
    ld_fechahoy := ld_fechavalida;
  else
    ld_fechahoy := mg_f_fecha_calendario(1,'BPR');
  end if;
  if gv_tipopago = 'M' then
    if gn_codigooperacion is null then
      gn_codigooperacion := 35;
    end if;
  elsif gv_tipopago = 'C' then
    if gn_codigooperacion is null then
      gn_codigooperacion := 21;
    end if;
  end if;
  if gn_codigooperacion is null then
    gn_codigooperacion := 2;
  end if;
  open c_prestamo;
  fetch c_prestamo into r_prestamo;
  if c_prestamo%found then
    --calcula el pago
    pr_k_aplica_pago_prestamo.pr_prestamo_a_pagar(r_prestamo.codigo_empresa,
                                                  r_prestamo.codigo_agencia,
                                                  r_prestamo.codigo_sub_aplicacion,
                                                  r_prestamo.numero_prestamo,
                                                  r_prestamo.codigo_cliente,
                                                  r_prestamo.barrido,
                                                  gn_codigooperacion,
                                                  null, --tipoabono
                                                  user,
                                                  ld_fechahoy,
                                                  ld_fechahoy,
                                                  null, --codigotipopago
                                                  montoadistribuir,
                                                  'Prueba de abono del prestamo.',
                                                  r_prestamo.codigo_agencia,
                                                  ln_numerorecibo,
                                                  ln_movimieintosrelacionados,
                                                  ln_secuenciamovimiento,
                                                  'N', --recalculacuota
                                                  '&aplicacalcula', --aplicacalcula
                                                  montoabonoextracapital,
                                                  gv_tipopago,
                                                  gn_cuotasapagar, 
                                                  null, --forma de pago
                                                  pago,
                                                  identificadorerror);
    if identificadorerror is not null then
      dbms_output.put_line(identificadorerror);
    end if;
    dbms_output.put_line('Detalle de Calculo del pago:');
    if pago.count > 0 then
      Operador := 1;
      for i in pago.first..pago.last loop
        if gv_tipopago = 'C' then
          Operador := F_Operador(r_prestamo.codigo_sub_aplicacion, pago(i).codigo_tipo_saldo);
        end if;
        pago(i).monto := pago(i).monto * Operador;
        dbms_output.put_line('Pre: '||pago(i).numero_prestamo||' '||
                             'Ope:'||to_char(pago(i).codigo_operacion,'99')||' '||
                             'Trx:'||to_char(pago(i).codigo_tipo_transaccion,'999')||' '||
                             'Sld:'||to_char(pago(i).codigo_tipo_saldo,'99')||' '||
                             'Val:'||ltrim(to_char(pago(i).monto,'999,999,999,990.00')));
        ln_total := ln_total + pago(i).monto;
      end loop;
      dbms_output.put_line('Monto a Pagar = '||ltrim(to_char(ln_total,'999,999,999,990.00')));
    else
      dbms_output.put_line('No hay detalle de pago.');
    end if;
  else
    dbms_output.put_line('Prestamo no existe!');
  end if;
  close c_prestamo;
  rollback;
exception
when others then
dbms_output.put_line(sqlerrm);
end;
