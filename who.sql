alter session set nls_calendar=gregorian;
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
col sid1 for a11 heading "SID|Serial"
set pages 1000
col machine for a23
col program for a52
col username for a15
col osuser for a15
set lines 999 
col program for a53
select s.inst_id,s.status,s.sid||','||s.serial# sid1,s.program,s.osuser,s.username,s.machine,logon_time
--,s.schemaname 
--select 'alter system kill session '''||s.sid||','||s.serial#||'''immediate;' 
-- ,p.spid
from gv$session s
--, gv$process p
--select distinct(program) from v$session
--where lower(program) like '%iohand%' or lower(program) like '%ware%'
--where lower(program) like '%ussd-app%'
--where lower(program) like '%httpd%'
--where lower(terminal) like 'mt%'
--where lower(osuser) = 'mwesb'
--where upper(username) like '%USSD%' or upper(username) like '%IVR%' 
--where upper(username) like '%EDW%' 
--where upper(username) like '%IELL_SSP%' 
--where upper(username) not in ('SYS','USSDAPP','IVRSAPP','DMSAPP') 
--where upper(username) like '%IVR%' 
-- where upper(username) like '%PROV%'
--where lower(machine) like '%001'
--and sid = 211 or sid = 191
--and s.status = 'INACTIVE'
--where s.status != 'KILLED' 
--where s.status = 'INACTIVE' and s.schemaname = 'IEA'
--or machine like 'MTN\AB%'
--order by osuser,username,machine
--order by status desc ,program desc, 3,4
order by 7 desc,2;
--order by logon_time desc;
--/
