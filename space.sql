set lin 100
set echo off
set term off
set feedback off
set verify off
set pages 999
set lines 500
spool /oracle/admin/dba/sql/space.txt
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
set feedback on
set verify on
set term on
spool off
