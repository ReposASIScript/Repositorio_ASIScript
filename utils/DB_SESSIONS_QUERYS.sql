select x.*, B.SQL_FULLTEXT, B.SQL_TEXT
from (
SELECT a.sid ,a.schemaname,
       DECODE (a.sql_hash_value, 0, a.prev_hash_value, a.sql_hash_value)
          hash,
       DECODE (a.sql_hash_value,
               0, RAWTOHEX (a.prev_sql_addr),
               RAWTOHEX (a.sql_address))
          address,
       DECODE (a.sql_id, NULL, a.prev_sql_id, a.sql_id) sql_id,
       DECODE (a.sql_child_number, NULL, a.prev_child_number, a.sql_child_number)
          sql_child_number
  FROM v$session a
  ) x,  v$sql b  
 WHERE x.sid = &introduzcaSID
    and x.sql_id=B.SQL_ID;