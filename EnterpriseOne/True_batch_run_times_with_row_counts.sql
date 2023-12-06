select JCPID, JCVERS 
,datediff(mi,JCSTDTIM,JCETDTIM) as min_to_completion 
,JCPWPRCD as rows_processed
,JCSBMDATE as submitted_date 
,JCSBMTIME as submitted_time 
,JCSTDTIM as execute_time 
,JCETDTIM as complete_time 
from f986110 a, f986114 b 
where a.JCJOBNBR=b.JCJOBNBR 
--and JCPID = 'R31802A' and JCVERS ='GSU0004' 
--order by JCSTDTIM desc 

select JCPID, JCVERS, count(JCPID) as count1, avg(sec_to_completion) as average_time, avg(rows_processed) as average_rows from batch_time_and_rows
group by JCPID, JCVERS
order by average_time desc

select count(*) from f986110
