define _editor=vi
set serveroutput on size 1000000
set trimspool on
set long 5000
set linesize 200
set pagesize 9999
set timing on
column plan_plus_exp format a80
column global_name new_value gname
set termout off
define gname=idle
column global_name new_value gname
select lower(user) || '@' || lower(substr( global_name, 1, decode( dot, 0, length(global_name),dot-1) )) || '(' || sys_context('userenv', 'sid') || ')' global_name
from (select global_name, instr(global_name,'.') dot
      from global_name ) a
/
set sqlprompt '&gname> '
set termout on

