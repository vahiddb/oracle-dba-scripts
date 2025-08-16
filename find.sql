set echo off
select table_name from dict where table_name like upper('%&tablename%')
/
set echo on

