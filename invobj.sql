set linesize 200
set pagesize 600
col owner for a20
col object_type  form a25
col object_name form a40
col created_date for a30
col "Last DDL Date" form a30
col status form a15
select owner, object_type, object_name, to_char(created,'DD Month YYYY HH24:MI') as
created_date, to_char(last_ddl_time,'DD Month YYYY HH24:MI') "Last DDL Date",Status
from dba_objects where status <> 'VALID'
order by owner
/
