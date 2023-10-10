select distinct code_mo													
,month,SchetType													
,t.usl_ok+'  '+t.tip+' ' +isnull(nam,''),												
count (distinct id) [кол-во зак случаев поданных на опату]
,t.PR_NOV [признак переподачи]
,sum(case when idsp in (35,36, 25) and pr_nov=0 then 0 else sumv end) [подано на сумму],
count (distinct  case when sank is not null then id end) [Снято по мэк],		
sum(case when sank is not null then sumv end) [Снято по мэк на сумму],		
count(distinct  case when sank is null then id end) [кол-во оплаченных зак случаев], 		
sum(case when sank is null then case when idsp in (35,36) and pr_nov=0 then 0 else sumv end end) [оплачено на сумму]		
,count (distinct  case when s_osn in ('1.6.2.') then id end ) [снято по объемам в 10 месяце]		
--,count (distinct case when sank.s_osn in ('5.3.2.','1.6.2.') then zs.id end ) [снято по объемам]		
,isnull(sum (case when  s_osn in ('1.6.2.')  then sumv end),0) [снято по объемам на сумму в 10 мес ]														
from 													
(select distinct --sank.id sank,sank.S_OSN, 
zs.IDSP,zs.PR_NOV,
sch.code_mo,sch.MONTH,sch.SchetType,  zs.id,---s.NHISTORY,
s.sum_m SUMV,sank.id sank,sank.s_osn s_osn,v.UMPNAME usl_ok,													
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
		where sch.year=2023 
		and sch.month<=3										
		and sch.code_mo='460026'		
		and zs.[NotExist] is null
		------------------------------------------										
													
													
													
		)t											
		group by code_mo,											
		month,	SchetType,										
		t.usl_ok+'  '+t.tip+' ' +isnull(nam,'')		
		,t.PR_NOV			
