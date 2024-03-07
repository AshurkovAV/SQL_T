--UPDATE ZS SET zs.npr_mo='460002'
SELECT 	zs.id as ID, zs.sumv as SUMV, ''com,zs.npr_mo
--p.OKATOG,o.ter+o.kod1+o.kod2+o.kod3
from   D3_SCHET_OMS sch
		 join D3_PACIENT_OMS p on sch.id=p.[D3_SCID] --and sch.id=@p1
		 join D3_ZSL_OMS zs on p.id=zs.D3_PID 
		 left join f003 on f003.mcod=zs.npr_mo
		 where sch.month=8 and sch.year=2020 --and (f003.mcod is null and npr_mo is not null)
		  AND NPR_MO LIKE '~%'