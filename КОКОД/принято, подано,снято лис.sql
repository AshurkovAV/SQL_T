select distinct MONTH,
t.nam_mok,

t.code_usl
,ms_name
 ,t.VID_VME
 , y_name
-- ,count(*) [количество],SUM(sumv) [сумма] ,	
												
,count (distinct id) [кол-во зак случаев поданных на опату]
,sum(case when idsp in (35,36) and pr_nov=0 then 0 else sumv end) [подано на сумму],
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
f003.nam_mok,
sch.code_mo,sch.MONTH,/*sch.SchetType,*/  zs.id,---s.NHISTORY,
s.sum_m SUMV, sank.id sank, sank.s_osn s_osn,v.UMPNAME usl_ok,	

usl.code_usl
 ,ms.name AS ms_name
 ,usl.VID_VME
 , y.name AS y_name
 ---,sumv ,
 --											
,CASE 													
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
		join medicalServices ms on ms.code_usl =usl.CODE_USL and s.DATE_2 between ms.dataBegin and isnull(ms.dataend,'20991231')	AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
		--left JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'										
		left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id and sank.s_tip=1								
		left join v006 v on v.IDUMP=zs.USL_OK	
		LEFT JOIN f003 ON f003.mcod=zs.NPR_MO	
		left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme										
		where sch.year=2022 
		and sch.month IN (1, 2, 3, 4, 5, 6, 7, 8, 9)									
		and sch.code_mo='460061'		
		--and zs.[NotExist] is null
		------------------------------------------										
													
		--AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'											
													
		)t											
		group by 	month	, t.nam_mok,										
						
		t.code_usl
,ms_name
 ,t.VID_VME
 , y_name