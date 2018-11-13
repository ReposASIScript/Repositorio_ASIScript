SET DEFINE OFF

   -----------------------------------------------------------
PROMPT TYPES...   
@@type_stab.typ
@@type_ntab.typ

PROMPT TYP and ENV package specs (must proceed view creation)...
PROMPT typ.pks
@@typ.pks
SET DEFINE ON
PROMPT env.pks
@@env.pks
SET DEFINE OFF

   -----------------------------------------------------------
PROMPT VIEWS...
PROMPT app_vw
@@app_vw.sql
PROMPT app_env_vw
@@app_env_vw.sql
PROMPT app_env_parm_vw
@@app_env_parm_vw.sql
PROMPT app_parm_vw
@@app_parm_vw.sql
PROMPT sec_role_vw
@@sec_role_vw.sql
PROMPT sec_pmsn_vw
@@sec_pmsn_vw.sql
PROMPT sec_user_app_vw
@@sec_user_app_vw.sql
PROMPT sec_user_role_vw
@@sec_user_role_vw.sql
PROMPT sec_role_pmsn_vw
@@sec_role_pmsn_vw.sql

   -----------------------------------------------------------
PROMPT OraMail java CLASS
PROMPT This will not compile on Oracle XE. It does not have a JVM.
@@OraMail.java
PROMPT Required on 11g and higher, grant the class directly...
GRANT EXECUTE ON "OraMail" TO PUBLIC;

   -----------------------------------------------------------
PROMPT PACKAGES...

PROMPT cnst.pks
@@cnst.pks

PROMPT dt.pks
@@dt.pks

--PROMPT codes.pks
--@@codes.pks

PROMPT parm.pks
@@parm.pks

PROMPT timer.pks
@@timer.pks

PROMPT str.pks
@@str.pks

PROMPT num.pks
@@num.pks

PROMPT msgs.pks
@@msgs.pks

PROMPT api_app_log.pks
@@app_log_api.pks

PROMPT io.pks
@@io.pks

PROMPT excp.pks
@@excp.pks

PROMPT util.pks
@@util.pks

PROMPT logs.pks
@@logs.pks

PROMPT mail.pks
@@mail.pks

PROMPT locks.pks
@@locks.pks

PROMPT ddl_utils.pks
@@ddl_utils.pks

PROMPT util.pkb
@@util.pkb

PROMPT timer.pkb
@@timer.pkb

PROMPT str.pkb
@@str.pkb

PROMPT num.pkb
@@num.pkb

PROMPT msgs.pkb
@@msgs.pkb

PROMPT mail.pkb
@@mail.pkb

PROMPT parm.pkb
@@parm.pkb

PROMPT api_app_log.pkb
@@app_log_api.pkb

PROMPT io.pkb
@@io.pkb

PROMPT excp.pkb
@@excp.pkb

PROMPT env.pkb
@@env.pkb

PROMPT dt.pkb
@@dt.pkb

--PROMPT codes.pkb
--@@codes.pkb

PROMPT logs.pkb
@@logs.pkb

PROMPT locks.pkb
@@locks.pkb

PROMPT ddl_utils.pkb
@@ddl_utils.pkb

   -----------------------------------------------------------
PROMPT TRIGGERS...
PROMPT app_bi.trg
@@app_bi.trg

PROMPT app_aiud.trg
@@app_aiud.trg

--PROMPT app_codeset_bi.trg
--@@app_codeset_bi.trg
--
--PROMPT app_codeset_aiud.trg
--@@app_codeset_aiud.trg
--
--PROMPT app_code_bi.trg
--@@app_code_bi.trg
--
--PROMPT app_code_aiud.trg
--@@app_code_aiud.trg

PROMPT app_db_aiud.trg
@@app_db_aiud.trg

PROMPT app_env_aiud.trg
@@app_env_aiud.trg

PROMPT app_env_parm_aiud.trg
@@app_env_parm_aiud.trg

PROMPT app_log_bi.trg
@@app_log_bi.trg

PROMPT app_msg_aiud.trg
@@app_msg_aiud.trg

PROMPT app_parm_aiud.trg
@@app_parm_aiud.trg

PROMPT sec_role_aiud.trg
@@sec_role_aiud.trg

--PROMPT app_sql_bi.trg
--@@app_sql_bi.trg
--
--PROMPT app_sql_aiud.trg
--@@app_sql_aiud.trg

PROMPT sec_user_aiud.trg
@@sec_user_aiud.trg

   -----------------------------------------------------------
PROMPT JOBS...
PROMPT trim_app_log.job
@@trim_app_log.job

SET DEFINE ON
   -----------------------------------------------------------
PROMPT CONTEXTS...
PROMPT app_core_ctx
@@app_core_ctx.sql


