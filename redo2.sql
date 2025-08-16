col day for a10
select to_char(first_time,'YYYY-MM-DD') day,
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),'9999') "00",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),'9999') "01",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),'9999') "02",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),'9999') "03",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),'9999') "04",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),'9999') "05",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),'9999') "06",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),'9999') "07",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),'9999') "08",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),'9999') "09",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),'9999') "10",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),'9999') "11",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),'9999') "12",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),'9999') "13",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),'9999') "14",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),'9999') "15",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),'9999') "16",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),'9999') "17",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),'9999') "18",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),'9999') "19",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),'9999') "20",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),'9999') "21",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),'9999') "22",
to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),'9999') "23"
from v$log_history
where first_time > sysdate -14
group by to_char(first_time,'YYYY-MM-DD')
order by 1
/

