set echo off
set term off
set feedback off
set verify off
set pages 999
spool /oracle/admin/dba/sql/space.txt
create view t_alloc as
select t.tablespace_name ts,t.contents ct,t.extent_management xm,
sum(d.bytes)/1024/1024 alloc
from dba_temp_files d,dba_tablespaces t
where t.tablespace_name =d.tablespace_name
group by t.tablespace_name,t.contents,t.extent_management
/
create view t_used as
select tablespace_name ts,
        sum(bytes_used)/1024/1024 used
   from V$TEMP_SPACE_HEADER
  group by tablespace_name
/
create view t_free as
select tablespace_name ts,
        sum(bytes_free)/1024/1024 free
   from V$TEMP_SPACE_HEADER
  group by tablespace_name
/
create view v_alloc as
  select t.tablespace_name ts, t.contents ct,t.extent_management xm,
  sum(d.bytes)/1024/1024 alloc
  from dba_data_files d, dba_tablespaces t 
  where t.tablespace_name =d.tablespace_name
  group by t.tablespace_name,t.contents,t.extent_management
/
create view v_used as
  select tablespace_name ts,
  sum(bytes)/1024/1024 used
  from dba_segments
  group by tablespace_name
/
create view v_free as
  select tablespace_name ts,
  sum(bytes)/1024/1024 free
  from dba_free_space
  group by tablespace_name
/
set lin 200
set pagesize 1000
set term on
col ts heading 'TABLESPACE' format a25
col ct heading 'C' format a1
col xm heading 'T' format a1
col alloc heading 'ALLOC (MB)' format 9,999,999,999,999
col free heading 'FREE (MB)' format 9,999,999,999,999
col used heading 'USED (MB)' format 9,999,999,999,999
comp sum of alloc on report
comp sum of used on report
comp sum label 'Sum' of free on report
break on report
select substr(a.ct, 1,1) ct,substr(a.xm, 1,1) xm, a.ts,a.alloc,u.used,f.free, round(u.used/a.alloc*100) "PCT USED"
  from v_alloc a, v_used u, v_free f
  where u.ts(+) = a.ts
  and f.ts (+) = a.ts
union
select substr(a.ct, 1,1) ct,substr(a.xm, 1,1) xm, a.ts,a.alloc,u.used,f.free, round(u.used/a.alloc*100) "PCT USED"
  from t_alloc a, t_used u, t_free f
  where u.ts(+) = a.ts
  and f.ts = a.ts
  order by "PCT USED"
--  order by 3
/
