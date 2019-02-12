set echo off
set pagesize 3000
set linesize 170
set feedback off
spool Foreign_key_tmp.sql

select uc.table_name, uc.constraint_name, b.table_name, b.constraint_name
from all_constraints uc, all_constraints b
where uc.owner = '&usuario_duenio'
and uc.constraint_type='R'
and uc.r_constraint_name = b.constraint_name
and exists
(select ucc.position, ucc.column_name
from all_cons_columns ucc
where ucc.owner = '&usuario_duenio'
and ucc.constraint_name=uc.constraint_name
minus
select uic.column_position as position, uic.column_name
from all_ind_columns uic
where uic.index_owner = '&usuario_duenio'
and uic.table_name=uc.table_name);

spool off
set echo on
set feed on
set linesize 2000
set pagesize 24
