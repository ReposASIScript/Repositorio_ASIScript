REM ASI   =======================================================================
REM
REM                        CASE*Repository (TM)
REM   Copyright (c) Oracle Corporation 1988, 1994.  All rights reserved.
REM
REM ===========================================================================
SET arraysize 1
SET TERMOUT ON
column nl newline

PROMPT ***************************************************************
PROMPT * Recompiling invalid Repository objects...
PROMPT *
PROMPT ***************************************************************

set heading off 
set feedback off 
set termout off 
set pages 0

spool cdapicom.tmp

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository views...
PROMPT PROMPT

select 'PROMPT Compiling View '||object_name nl
,      'alter view '||object_name||' compile;' nl
from  user_objects
where object_type = 'VIEW'
and   status      =  'INVALID'
order by created
/

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository functions specifications...
PROMPT PROMPT

select 'PROMPT Compiling Funciont  '||object_name nl
,      'alter function '||object_name||' compile;' nl
from  user_objects
where object_type = 'FUNCTION'
and   status      =  'INVALID'
order by created
/

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository Procedures specifications...
PROMPT PROMPT

select 'PROMPT Compiling procedure  '||object_name nl
,      'alter procedure '||object_name||' compile;' nl
from  user_objects
where object_type = 'PROCEDURE'
and   status      =  'INVALID'
order by created
/

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository package specifications...
PROMPT PROMPT

select 'PROMPT Compiling Package  '||object_name nl
,      'alter package '||object_name||' compile package;' nl
from  user_objects
where object_type = 'PACKAGE'
and   status      =  'INVALID'
order by created
/

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository packages...
PROMPT PROMPT

select 'PROMPT Compiling Package Body '||object_name nl
,      'alter package '||object_name||' compile body;' nl
from  user_objects
where object_type = 'PACKAGE BODY'
and   status      =  'INVALID'
order by created
/

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository triggers...
PROMPT PROMPT

select 'PROMPT Compiling Trigger '||object_name nl
,      'alter TRIGGER '||object_name||' compile;' nl
from  user_objects
where object_type = 'TRIGGER'
and   status      =  'INVALID'
order by created
/

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository synonyms...
PROMPT PROMPT

select 'PROMPT Compiling Synonym '||object_name nl
,      'alter SYNONYM '||object_name||' compile;' nl
from  user_objects
where object_type = 'SYNONYM'
and   status      =  'INVALID'
order by created
/

PROMPT PROMPT
PROMPT PROMPT Re-compiling invalid Repository materialized views...
PROMPT PROMPT

select 'PROMPT Compiling Materialized View '||object_name nl
,      'alter MATERIALIZED VIEW '||object_name||' compile;' nl
from  user_objects
where object_type = 'MATERIALIZED VIEW'
and   status      =  'INVALID'
order by created
/
select 'PROMPT Compiling Type '||object_name nl
,      'alter TYPE '||object_name||' compile;' nl
from  user_objects
where object_type = 'TYPE'
and   status      =  'INVALID'
order by created
/

spool off

set termout on 
spool cdapicom.lis

start cdapicom.tmp

spool off
rem  
rem ----------------------------------------------------------------------------
rem $$Header_is_done
rem  End of file $RCSfile: cdapicom.sql $
rem ----------------------------------------------------------------------------
rem
select 'Quedan '||count(*)||' objetos invalidos!' from user_objects
where status = 'INVALID' and object_type in
('FUNCTION','PROCEDURE','PACKAGE BODY','TRIGGER','VIEW','TYPE');
set head on