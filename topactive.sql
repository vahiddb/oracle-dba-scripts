set lin 200
 col username for a15
col machine for a30
col service_name for a15
select inst_id,username , machine ,service_name,sql_id, COUNT(*)  from gv$session where username is not null and status='ACTIVE' GROUP BY inst_id,USERNAME ,MACHINE , SERVICE_NAME,sql_id having count(*)>1 ORDER BY COUNT(*);

