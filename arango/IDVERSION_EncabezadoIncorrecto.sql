SELECT *
  FROM user_source x
 WHERE x.type = 'PROCEDURE'
   AND x.text LIKE '%PROCEDURE%_P_%IDVER%';
  
SELECT *
  FROM user_source x
 WHERE x.type = 'PACKAGE'
   AND x.text LIKE '%PACKAGE%_K_%IDVER%';

SELECT *
  FROM user_source x
 WHERE x.type = 'FUNCTION'
   AND x.text LIKE '%FUNCTION%_F_%IDVER%';

SELECT *
  FROM user_source x
 WHERE x.type = 'TRIGGER'
   AND x.text LIKE '%TRIGGER%_T_%IDVER%';