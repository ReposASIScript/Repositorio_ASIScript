set echo off
set pagesize 3000
set linesize 170
set feedback off
spool Foreign_key_tmp.sql

select uc.table_name, uc.constraint_name, b.table_name, b.constraint_name
from user_constraints uc, user_constraints b
where uc.constraint_type='R'
and uc.r_constraint_name = b.constraint_name
and exists
(select ucc.position, ucc.column_name
from user_cons_columns ucc
where ucc.constraint_name=uc.constraint_name
minus
select uic.column_position as position, uic.column_name
from user_ind_columns uic
where uic.table_name=uc.table_name);

spool off
set echo on
set feed on
set linesize 2000
set pagesize 24
