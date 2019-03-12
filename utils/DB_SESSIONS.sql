SET LIN 2000

  SELECT ver.SID, ver.SERIAL#, ver.USERNAME, ver.PROGRAM, ver.STATUS, ver.SCHEMANAME, ver.OSUSER, ver.MACHINE
    FROM v$session ver
   WHERE ver.USERNAME = NVL('&Introduzca_Usuario',ver.USERNAME)
ORDER BY 1, 2;