select t1.namewithid,t1.datebeg,t1.dateend,t2.namewithid,t2.datebeg,t2.dateend
from
(
select * from v024
where year(datebeg)=2021 and iddkk like 'sh%' and  charindex('.',iddkk)=0 
) t1 
left join
(
select *,concat(substring(iddkk,1,2),'0',substring(iddkk,3,3)) as new_sh--concat(substring(iddkk,1,2))iddkk
 from v024
where year(datebeg)<2021 and iddkk like 'sh%' and dateend='2020-12-31' and charindex('.',iddkk)=0) t2
 on t2.new_sh=t1.iddkk
 union
 select t1.namewithid,t1.datebeg,t1.dateend,t2.namewithid,t2.datebeg,t2.dateend
from
(
select * from v024
where year(datebeg)=2021 and iddkk like 'sh%' and  charindex('.',iddkk)<>0
) t1 
left join
(
select *,concat(substring(iddkk,1,2),'0',substring(iddkk,3,5)) as new_sh--concat(substring(iddkk,1,2))iddkk
 from v024
where year(datebeg)<2021 and iddkk like 'sh%' and dateend='2020-12-31' and charindex('.',iddkk)<>0) t2
 on t2.new_sh=t1.iddkk