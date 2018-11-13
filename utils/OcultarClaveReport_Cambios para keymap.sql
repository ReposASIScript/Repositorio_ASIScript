
Crear  usuario con los permisos de un usuario de abanks pero sin acceso a la aplicación.
Notas: 
1- Utiliza un usuario genérico para ejecutar reportes que esta en los permisos de ABANKS
pero no creado en el sistema(MG_USUARIOS_DEL_SISTEMA).
2- Los  reportes salen con la identificación de este usuario y no el que lo ejecuto
3- No se ha validado los comprobantes de caja
4- Esta confgiuración esta en IUBANK
5- No pensado para esquema multiempresa

##################################################################################
Variables a agregar en archivo cgicmd.dat del Weblogic/OAS:
Archivo de weblogig: $DOMAIN_HOME/config/fmwconfig/servers/WLS_REPORTS/applications/reports_12.2.1/configuration/cgicmd.dat
##################################################################################
Variables agregadas para conexión:
	;  Key para reportes de abanks
	rpt1n: userid=repdsaas/repdsaas@as15nodo %*
	rpt1a: userid=repdsaas/repdsaas@as15agen %*

##################################################################################
Librerias a modificar:
##################################################################################

#### Cambio en libreria ABANKS70I.pll ####
    Program Unit: PU_P_RUN_REPORT_OBJECT_PROC
  
  (1) Seteo de variable de Key
  	--Se reutilizará la variable vc_user_connect para almacenar el key de nodo o agencia 
  	--Se pone en comentario la variable y se coloca validación si es nodo o agencia indicada en parametros dinamicos
  	
  	Antes:
  	vc_user_connect:=get_application_property(connect_string);	  
  	
  	Despues:
  	--vc_user_connect:=get_application_property(connect_string);	  
  	
  	--Define que Keymap utilizará si nodo o agencia
  	--Esos valores deben existir en el cgicmd.cfg del server de forms
  	--15Sept16
	IF PU_F_ES_NODO 
	THEN  
		SELECT valor INTO vc_connect FROM mg_parametros_dinamicos	WHERE parametro = 'KEY_NODO';
	ELSE  
		SELECT valor INTO vc_connect FROM mg_parametros_dinamicos	WHERE parametro = 'KEY_AGEN';
	END IF;
  
  
  
  (2) Se agrega la variable vc_connect que contiene la variable de nodo o agencia en el llamado del webshow
  	Antes:
  	web.show_document(Lv_HttpRepServer||'/reports/rwservlet/getjobid='||vjoib_id||'?server='||Lv_Repserver,'_blank');
  	
  	Despues:
  	web.show_document(Lv_HttpRepServer||'/reports/rwservlet/getjobid='||vjoib_id||'?'||vc_connect||'?server='||Lv_Repserver,'_blank');
                                       
    
#### Cambio en libreria ABANKSWEB.pll ####
  	Program Unit: pu_p_forma_de_parametros
  (1) Se quita userid y se agrega la variable que tiene la variable del keymap
  	Antes:
  	vc_hidden_runtime_values:='report='||vc_report_name||'&destype='||Gv_DesType||'&desformat='||Gv_DesFormat||'&userid='||Gv_UserConnect||'&server='||Gv_ServerName;
  	Despues:
  	vc_hidden_runtime_values:=Gv_UserConnect||'&report='||vc_report_name||'&destype='||Gv_DesType||'&desformat='||Gv_DesFormat||'&server='||Gv_ServerName;

	
	
###Se insertan nuevos parametros que incluirán los keys de nodo y agencia los cuales deben haberse configurado en el el weblogic
SET DEFINE OFF;
Insert into MG_PARAMETROS_DINAMICOS
   (CODIGO_APLICACION, SET_PARAMETRO, TIPO_PARAMETRO, PARAMETRO, DESCRIPCION, VALOR, ADICIONADO_POR, FECHA_ADICION, MODIFICADO_POR, SET_PARAMETRO_ORIGEN)
 Values
   ('BMG', 1, 'D', 'KEY_AGEN', 'Keymap Agen', 'rpt1a', USER, TO_DATE('12/21/2005 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), USER, 0);
Insert into MG_PARAMETROS_DINAMICOS
   (CODIGO_APLICACION, SET_PARAMETRO, TIPO_PARAMETRO, PARAMETRO, DESCRIPCION, VALOR, ADICIONADO_POR, FECHA_ADICION, MODIFICADO_POR, SET_PARAMETRO_ORIGEN)
 Values
   ('BMG', 1, 'D', 'KEY_NODO', 'Keymap Nodo', 'rpt1n', USER, TO_DATE('12/21/2005 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), USER, 0);
COMMIT;
