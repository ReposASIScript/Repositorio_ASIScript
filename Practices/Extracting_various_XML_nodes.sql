DECLARE
  Lv_Destination VARCHAR2(100);
  cursor c_cursor is
    SELECT extractvalue(column_value, '/user/name') "user"
      FROM TABLE(XMLSequence(XMLTYPE(
                   '<?xml version="1.0"?>
                      <users>
                          <user>
                              <name>user1</name>
                          </user>
                          <user>
                              <name>user2</name>
                          </user>
                          <user>
                              <name>user3</name>
                          </user>
                       </users>').extract('/users/user'))) t;
BEGIN
  OPEN c_cursor;
  LOOP
    FETCH c_cursor INTO Lv_Destination;
      If c_cursor%FOUND Then
        dbms_output.put_line('usuario: '||Lv_Destination);
      End If;
    EXIT WHEN c_cursor%NOTFOUND;
  END LOOP;
END;