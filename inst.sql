col host_name for a30
set line 200
col host_name for a12
alter session set nls_calendar=gregorian;
alter session set nls_date_format='DD-MON-YY HH24:MI:SS';
select Instance_name,Host_Name,logins,Version,startup_time,status,archiver,log_switch_wait,database_status,instance_role from gv$instance
/


