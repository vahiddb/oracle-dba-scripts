select name , free_mb , total_mb ,round((total_mb-free_mb)/total_mb*100,0) percent_of_use from v$asm_diskgroup where total_mb<>0;

