Set pages 100
Set lin 200	
SELECT SESSION_KEY ,input_type,to_char(start_time,'day,yy/mm/dd hh24:mi','nls_calendar=persian') start_time,status ,OUTPUT_BYTES/1024/1024/1024 GB,
 ELAPSED_SECONDS/3600 HRS FROM V$RMAN_BACKUP_JOB_DETAILS ORDER BY SESSION_KEY;

