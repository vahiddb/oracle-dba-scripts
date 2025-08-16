REM  LAST SQL executed (or being executed )
REM   By a session

col sql_text for a300

SELECT sql_hash_value FROM v$session WHERE sid = &1
/
SELECT sql_text FROM v$sqltext WHERE hash_value = &2 ORDER by piece asc
/

--SELECT sql_text FROM v$sqltext WHERE hash_value in 
-- (SELECT sql_hash_value FROM v$session WHERE sid = &1)
-- ORDER by piece asc
--/

