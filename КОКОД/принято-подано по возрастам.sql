select distinct code_mo													
,month,SchetType													
,t.usl_ok+'  '+t.tip+' ' +isnull(nam,''),												
count (id) [кол-во зак случаев]
,sum(sumv) [на сумму],
	
count(distinct  case when pr_det=1 then id end) [из них детей случаев], 		
sum(distinct  case when pr_det=1 then sumv end) [из них детей сумма],	
													
count(distinct  case when pr_pens=1 then id end) [из них пенсионеров случаев], 		
sum(distinct  case when pr_pens=1 then sumv end) [из них пенсионеров сумма]														
from 													
(select distinct --sank.id sank,sank.S_OSN, 
zs.IDSP,zs.PR_NOV,
sch.code_mo,sch.MONTH,sch.SchetType,  zs.id,---s.NHISTORY,
s.sum_m SUMV,sank.id sank,sank.s_osn s_osn,v.UMPNAME usl_ok,
CASE WHEN 	[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	<=17 THEN 1 ELSE 0 END pr_det,
CASE WHEN 	[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	>=60 THEN 1 ELSE 0 END pr_pens,													
CASE 													
										WHEN s.P_CEL25='1.1' THEN 'НЕОТЛОЖКА АПП'			
										WHEN  ( (s.P_CEL25 LIKE '1%' AND s.P_CEL25 NOT LIKE '1.1')			
												OR 	s.P_CEL25 IN ('2.1','2.5','2.6')
												AND    zs.OS_SLUCH_REGION IS NULL	
												) OR	
												zs.OS_SLUCH_REGION in (29,35,48,23,12,18)  THEN 'ПРОФИЛАКТИКА АПП'	
										WHEN 			
										(s.P_CEL25 = '3.0' and OS_SLUCH_REGION is null)			
										or 			
										zs.OS_SLUCH_REGION in (21,30,31,32,33,34,36,39,40) 			
										OR 			
										(s.P_CEL25='2.3' AND usl.CODE_USL like 'R03%')			
											then 'ЗАБОЛЕВАНИЯ АПП'		
											WHEN  		
										zs.OS_SLUCH_REGION in (6) 			
											then 'ЗАБОЛЕВАНИЯ АПП гемодиализ'		
										when usl.code_usl like 'R01%' then ms.name			
										ELSE ''			
										END tip	,db.Name nam		
FROM [D3_SCHET_OMS] sch													
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id											
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id											
		inner join d3_sl_oms s on s.D3_ZSLID=zs.id 											
		LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=s.id	
		left join OsobSluchDb db on db.Id=zs.OS_SLUCH_REGION
		left join medicalServices ms on ms.code_usl =usl.CODE_USL and s.DATE_2 between ms.dataBegin and isnull(ms.dataend,'20991231')											
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id and sank.s_tip=1								
		left join v006 v on v.IDUMP=zs.USL_OK											
		where sch.year=2022 
		AND sch.id IN (9205,9206)
		AND zs.usl_ok=3 								
		and sch.code_mo='460061'		
		and sank.id IS null
		)t											
		group by code_mo,											
		month,	SchetType,										
		t.usl_ok+'  '+t.tip+' ' +isnull(nam,'')					
