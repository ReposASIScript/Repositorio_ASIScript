declare
   startdate date;
   dateafter date;
   nextdate  date;
begin
   startdate := TO_TIMESTAMP_TZ('03-10-2019 20:30:00.000000000 AMERICA/REGINA','DD-MM-YYYY HH24:MI:SS.FF TZR'); --TO_DATE('03-10-2019 20:30:00','DD-MM-YYYY HH24:MI:SS');
   dateafter := startdate;
   for i in 1..24 loop
      dbms_scheduler.evaluate_calendar_string(
         'FREQ=DAILY;BYDAY=MON,TUE,WED,THU,FRI;BYHOUR=20;BYMINUTE=30'
       , startdate
       , dateafter
       , nextdate
      );
      dbms_output.put_line('startdate: '||to_char(startdate,'YYYY-MM-DD HH24:MI')||' nextdate: '||to_char(nextdate,'YYYY-MM-DD HH24:MI'));
      dateafter := nextdate;
   end loop;
end;
/