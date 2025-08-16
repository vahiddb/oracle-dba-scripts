
select a.dest_id, a.thread# , b.last_seq , a.applied_seq, a.last_app_timestamp, b.last_seq-a.applied_seq arc_diff 
from (select dest_id,thread#, max(sequence#) applied_seq , max(next_time) last_app_timestamp from gv$archived_log 
where applied='YES' GROUP BY dest_id , thread#) A , (SELECT THREAD# , MAX(SEQUENCE#) LAST_SEQ FROM GV$ARCHIVEd_LOG GROUP BY THREAD#) B 
WHERE A.THREAD# = B.THREAD# order by dest_id ,thread#;
