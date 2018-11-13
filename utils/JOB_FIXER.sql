/* Filename on companion disk: job5.sql */
CREATE OR REPLACE PROCEDURE job_fixer
AS
   /*
   || calls DBMS_JOB.BROKEN to try and set
   || any broken jobs to unbroken
   */
   
   /* cursor selects user's broken jobs */
   CURSOR broken_jobs_cur
   IS
   SELECT job
     FROM user_jobs
    WHERE broken = 'Y';
    
BEGIN
   FOR job_rec IN broken_jobs_cur
   LOOP
      DBMS_JOB.BROKEN(job_rec.job,FALSE,SYSDATE);
   END LOOP;
END job_fixer;
/