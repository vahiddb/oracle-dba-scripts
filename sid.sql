/*  Script to give statistics of user please specify SID */
REM   Usage @sid sidno 
REM   Gives SQL,last execution time and locks being held 
REM   This script is for DB where timed_statistics = false
REM   If timed_statistics = true alter script to use
REM   process last non-idle time value from v$sesstat
REM   see example in idle.sql

set serveroutput on veri off pages 24 lines 132
declare
   TYPE userrec IS RECORD  (    sid      v$session.sid%type,
				serialno v$session.serial#%type,
				paddr    v$session.paddr%type,
				username v$session.username%type,
				command  v$session.command%type,
				taddr    v$session.taddr%type,
				status   v$session.status%type,
                                osuser   v$session.osuser%type,
				process  v$session.process%type,
				program  v$session.program%type,
				module   v$session.module%type,
				sesstype v$session.type%type,
				hash_value v$session.sql_hash_value%type,
				l_time   v$session.logon_time%type,
				last_call v$session.last_call_et%type,
                                machine   v$session.machine%type,
                                sql_text  v$sqltext.sql_text%type,
                                usn       v$transaction.xidusn%type,
                                rbs       v$rollname.name%type,
                                obj_id    v$locked_object.object_id%type,
                                object    dba_objects.object_name%type,
                                event     v$session_wait.event%type,
                                wait_seq  v$session_wait.seq#%type,
                                state     v$session_wait.state%type);
  user  userrec;
  name  dba_objects.object_name%type;
  owner dba_objects.owner%type;
  last  date;
  statno v$sesstat.statistic#%type;
  CPU    v$sesstat.value%type;
begin
  user.sid := &1;

  select serial#,paddr,username,command,taddr,status,
	 osuser,process,program,module,type,sql_hash_value,
	 logon_time,last_call_et,machine
    into user.serialno, user.paddr, user.username,
         user.command, user.taddr, user.status,
         user.osuser, user.process, user.program, user.module,
         user.sesstype, user.hash_value, user.l_time,
         user.last_call,user.machine 
   from  gv$session
  where  sid = user.sid;
last:= sysdate -(user.last_call/60/60/24);

if user.hash_value != 0 then
  select sql_text into user.sql_text
   from  v$sqltext 
  where  hash_value = user.hash_value
    and  piece = 0;
else 
   user.sql_text := 'No SQL found';
end if;

if user.taddr is not null then
  for c1 in ( select xidusn from v$transaction 
             where addr = user.taddr)
   loop
     user.usn := c1.xidusn;
        select name into user.rbs
          from v$rollname
        where usn = c1.xidusn;
    end loop;
else
  user.rbs := 'No RBS';
end if;
if user.rbs is null  then user.rbs :='No RBS';
end if;

 select state,seq#,event 
   into user.state,user.wait_seq,user.event
   from v$session_wait
  where sid = user.sid;
 
 select statistic# into statno 
  from  v$statname 
  where name ='CPU used by this session';
 select value into CPU 
   from v$sesstat
  where sid = user.sid
    and statistic# = statno;

dbms_output.put('==> Sid             : '||user.sid||'            ');
dbms_output.put('==> Serial# : '||user.serialno||'    ');
dbms_output.put_line('==> Status : '||user.status||'    ');
dbms_output.put('==> Username        : '||user.username||'     ');
dbms_output.put_line('==> Osuser  : '||user.osuser||'  ');
dbms_output.put_line('==> Machine         : '||user.machine||'  ');
dbms_output.put('==> Logon Time      : ');
dbms_output.put_line(to_char(user.l_time,'Dy DD Mon HH24:MI:SS'));
dbms_output.put('==> Curr Time       : ');
dbms_output.put_line(to_char((sysdate),'Dy DD Mon HH24:MI:SS'));
dbms_output.put('==> Last Call       : ');
dbms_output.put_line(to_char((last),'Dy DD Mon HH24:MI:SS'));
dbms_output.put_line('==> Program         : '||user.program);
dbms_output.put_line('==> Module          : '||user.module);
dbms_output.put_line('==> SQL Text        : '||user.sql_text);
dbms_output.put_line('==> SQL Hash        : '||user.hash_value);
dbms_output.put_line('==> Current RBS     : '||user.rbs);
dbms_output.put_line('==> Locking <==');
dbms_output.put_line('==> State           : '||user.state);
if user.state ='WAITING' then 
   dbms_output.put_line('==> Event           : '||user.event);
   dbms_output.put_line('==> Wait Seq        : '||user.wait_seq);
end if;
if CPU > 0 then
   dbms_output.put_line('==> CPU used        : '||CPU);
end if;

dbms_output.new_line();
dbms_output.put_line('Locked object(s)    :    ');
dbms_output.new_line();
for c2 in ( select * from v$locked_object 
                     where session_id = user.sid)
 loop
select owner,object_name into owner,name from dba_objects 
   where object_id = c2.object_id;
   dbms_output.put_line('   Name ==> '||owner||'.'||name||' ( Obj ID : '||c2.object_id||')');
 end loop;

dbms_output.new_line();
dbms_output.put_line('Accessing object(s) : ');
dbms_output.new_line();
--for c3 in ( select * from v$access 
--                     where sid = user.sid)
-- loop
--    dbms_output.put_line('   Name  ==> '||c3.owner||'.'||c3.object||'  ('||c3.type||')');
-- end loop;

exception
  when value_error then
     dbms_output.put_line('Value error cannot perform request');
  when others then
     dbms_output.put_line('Value error cannot perform request');
end;
/

