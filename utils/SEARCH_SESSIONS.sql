SET LINESIZE 2000
SET ECHO OFF
SET MARKUP HTML ON SPOOL ON
SPOOL c:\search_sessions.html
SHOW USER

  SELECT ses.sid, ses.serial#, ses.osuser, ses.schemaname, ses.machine, ses.program, ses.module, ses.status
    FROM v$session ses
   WHERE ses.schemaname = NVL(UPPER('&nombre_esquema'),ses.schemaname)
ORDER BY ses.schemaname, ses.sid, ses.serial#
/

SPOOL OFF
SET MARKUP HTML OFF
SET ECHO ON
HOST c:\search_sessions.html