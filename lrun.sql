alter session set nls_date_format = 'ddMON HH24:MI';
column TOTALWORK format 99999999999999999999
column SOFAR format 99999999999999999999
set linesi 200
column min/sec format 999.99
column message format a85
column percent format 999.99
column TIME_REMAINING format 99999
select sid, round((sofar/totalwork*100),2) Percent, message, start_time, last_update_time, (time_remaining/60) "Min/Sec"
from gv$session_longops where time_remaining <> 0 
--and message like '%TRANS_PR.GSM_PREPAID_CDRS:%' 
order by 6;


