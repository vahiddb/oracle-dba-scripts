set lin 200
col event for a24
col username for a12
select INST_ID,sid, blocking_session, username, blocking_session_status,sql_id,
program, event, seconds_in_wait
from gv$session t
where blocking_session_status = 'VALID';

