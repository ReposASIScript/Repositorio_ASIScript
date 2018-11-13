select case when regexp_like('Google' ,'^[[:alpha:]]{6}$') then 'Match Found' else 'No Match Found' end as output from dual;

select case when regexp_like('Terminator' ,'^([[:lower:]]{3,12})$') then 'Match Found' else 'No Match Found' end as output from dual;

select case when regexp_like('Republic Of India' ,'of', 'c') then 'Match Found' else 'No Match Found' end as output from dual;

select regexp_replace('Help   Earth        Stay     Green','[[:blank:]]{2,8}',' ') from dual;

select case when REGEXP_LIKE('tom_kyte@oracle.com', '^([[:alnum:]]+(_?|\.))[[:alnum:]]*@[[:alnum:]]+(\.([[:alnum:]]+)){1,2}$') then 'Match Found' else 'No Match Found' end as output from dual;

select regexp_substr('Republicc Of Africaa' ,'([a-z])\1', 1,2,'i') from dual;

select regexp_substr('Go to http://www.oracle.com/products and click on database','http://([[:alnum:]]+\.?){3,4}/?') result from dual;