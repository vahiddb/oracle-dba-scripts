set lines 200
col name for a40
col space_limit_gb for 999,999.99
col space_used_gb for 999,999.99
col pct_used for 999.99

select 
   name,
   space_limit / 1024 / 1024 / 1024 as space_limit_gb,
   space_used / 1024 / 1024 / 1024 as space_used_gb,
   round((space_used/space_limit)*100, 2) as pct_used
from 
   v$recovery_file_dest;
