select w, count(*)   --Yamed_Spr_MedicalEmployee.NameWithID, D3_PACIENT_OMS.FAM, D3_PACIENT_OMS.im, D3_PACIENT_OMS.ot, D3_PACIENT_OMS.dr, ds1,Yamed_Spr_Dn.NameWithID, DATE_Z_2, D3_DSS_OMS.DS,dss_dn.NameWithID
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						--join Yamed_Spr_MedicalEmployee on IDDOKT=SNILS
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (118)
AND DATEDIFF(yy,dr,GETDATE())>20 and DATEDIFF(yy,dr,GETDATE())<39
GROUP BY w

select w, count(*)   --Yamed_Spr_MedicalEmployee.NameWithID, D3_PACIENT_OMS.FAM, D3_PACIENT_OMS.im, D3_PACIENT_OMS.ot, D3_PACIENT_OMS.dr, ds1,Yamed_Spr_Dn.NameWithID, DATE_Z_2, D3_DSS_OMS.DS,dss_dn.NameWithID
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						--join Yamed_Spr_MedicalEmployee on IDDOKT=SNILS
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (120)
AND DATEDIFF(yy,dr,GETDATE())>38 and DATEDIFF(yy,dr,GETDATE())<61
GROUP BY w


select w, count(*)   --Yamed_Spr_MedicalEmployee.NameWithID, D3_PACIENT_OMS.FAM, D3_PACIENT_OMS.im, D3_PACIENT_OMS.ot, D3_PACIENT_OMS.dr, ds1,Yamed_Spr_Dn.NameWithID, DATE_Z_2, D3_DSS_OMS.DS,dss_dn.NameWithID
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						--join Yamed_Spr_MedicalEmployee on IDDOKT=SNILS
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (118)
AND DATEDIFF(yy,dr,GETDATE())>60 
GROUP BY w

//новая форма 1000

declare  @sc1 int = 170
select '18-34' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())>17 and DATEDIFF(yy,dr,GETDATE())<35
GROUP BY  D3_PACIENT_OMS.w
UNION
select '35-39' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())>34 and DATEDIFF(yy,dr,GETDATE())<40
GROUP BY  D3_PACIENT_OMS.w

UNION
select '40-54' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())>39 and DATEDIFF(yy,dr,GETDATE())<55
GROUP BY  D3_PACIENT_OMS.w


UNION
select '55-59' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())>54 and DATEDIFF(yy,dr,GETDATE())<60
GROUP BY  D3_PACIENT_OMS.w


UNION
select '60-64' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())>59 and DATEDIFF(yy,dr,GETDATE())<65
GROUP BY  D3_PACIENT_OMS.w


UNION
select '65-74' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())>64 and DATEDIFF(yy,dr,GETDATE())<75
GROUP BY  D3_PACIENT_OMS.w


UNION
select '75 и старше' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())>74 
GROUP BY  D3_PACIENT_OMS.w
UNION
select '55 женщины' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())=55 and w=2
GROUP BY  D3_PACIENT_OMS.w
UNION
select '60 мужчины' as 'Возраст',w, count(*) 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID

where D3_ZSL_OMS.D3_SCID in (@sc1)
AND DATEDIFF(yy,dr,GETDATE())=60  and w=1
GROUP BY  D3_PACIENT_OMS.w


//  2000
declare  @sc1 int = 168, @sc2 int = 170
select  comentu, npl,D3_USL_OMS.p_otk, count(*) 
-- select *  --Yamed_Spr_MedicalEmployee.NameWithID, D3_PACIENT_OMS.FAM, D3_PACIENT_OMS.im, D3_PACIENT_OMS.ot, D3_PACIENT_OMS.dr, ds1,Yamed_Spr_Dn.NameWithID, DATE_Z_2, D3_DSS_OMS.DS,dss_dn.NameWithID
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						--join Yamed_Spr_MedicalEmployee on IDDOKT=SNILS
					--	join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--left join D3_DSS_OMS on D3_SL_OMS.id=D3_DSS_OMS.D3_SLID
		--			left JOIN Yamed_Spr_Dn dss_dn on D3_DSS_OMS.pr_ds2_n=dss_dn.id
				--	left JOIN Yamed_Spr_Dn on D3_SL_OMS.dn=Yamed_Spr_Dn.id
					left join D3_USL_OMS on D3_SL_OMS.id=D3_USL_OMS.D3_SLID
					
where D3_ZSL_OMS.D3_SCID in (@sc1,@sc2) 
GROUP BY comentu, npl,D3_USL_OMS.p_otk
ORDER BY comentu

//2001
declare  @sc1 int = 168
select  V017.namewithid, count(*)

from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
				join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
				LEFT JOIN v017 on RSLT_D=V017.iddr
where D3_ZSL_OMS.D3_SCID in (@sc1) and V017.dateend is null and V017.namewithid like '%Направлен%'
GROUP BY V017.namewithid
ORDER BY V017.namewithid



//3000

declare  @sc1 int = 169

select comentu, npl,D3_USL_OMS.p_otk, count(*) 
-- select *  --Yamed_Spr_MedicalEmployee.NameWithID, D3_PACIENT_OMS.FAM, D3_PACIENT_OMS.im, D3_PACIENT_OMS.ot, D3_PACIENT_OMS.dr, ds1,Yamed_Spr_Dn.NameWithID, DATE_Z_2, D3_DSS_OMS.DS,dss_dn.NameWithID
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						--join Yamed_Spr_MedicalEmployee on IDDOKT=SNILS
					--	join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--left join D3_DSS_OMS on D3_SL_OMS.id=D3_DSS_OMS.D3_SLID
		--			left JOIN Yamed_Spr_Dn dss_dn on D3_DSS_OMS.pr_ds2_n=dss_dn.id
				--	left JOIN Yamed_Spr_Dn on D3_SL_OMS.dn=Yamed_Spr_Dn.id
					left join D3_USL_OMS on D3_SL_OMS.id=D3_USL_OMS.D3_SLID
					
where D3_ZSL_OMS.D3_SCID in (@sc1)
GROUP BY comentu, npl, D3_USL_OMS.p_otk
ORDER BY comentu


//4000 ?
//  косяки с изменением диагноза проверим
новая
убрать отброс диагноза после точки

declare  @sc1 int = 168, @sc2 int = 170

SELECT ds, vozr, sum(kol) from (
select  ds  , vozr = case  --left(ds,3) ds  
when DATEDIFF(yy,dr,GETDATE())<61 and w=1 then 'муж младше 61' 
when DATEDIFF(yy,dr,GETDATE())>60 and w=1 then 'муж старше 60'
when DATEDIFF(yy,dr,GETDATE())<56 and w=2 then 'жен младше 56'
when DATEDIFF(yy,dr,GETDATE())>55 and w=2 then 'жен старше 55'
else 'Чушь'  end
, count(*)  as kol
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						--join Yamed_Spr_MedicalEmployee on IDDOKT=SNILS
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--left join D3_DSS_OMS on D3_SL_OMS.id=D3_DSS_OMS.D3_SLID
		--			left JOIN Yamed_Spr_Dn dss_dn on D3_DSS_OMS.pr_ds2_n=dss_dn.id
				--	left JOIN Yamed_Spr_Dn on D3_SL_OMS.dn=Yamed_Spr_Dn.id
					left join D3_USL_OMS on D3_SL_OMS.id=D3_USL_OMS.D3_SLID
				
where D3_ZSL_OMS.D3_SCID in (@sc1,@sc2) 
and ds1<>ds 
GROUP BY  ds, DATEDIFF(yy,dr,GETDATE()), w) as tt

GROUP BY ds, vozr


старая

select w, ds, DATEDIFF(yy,dr,GETDATE()), count(*) 
-- select *  --Yamed_Spr_MedicalEmployee.NameWithID, D3_PACIENT_OMS.FAM, D3_PACIENT_OMS.im, D3_PACIENT_OMS.ot, D3_PACIENT_OMS.dr, ds1,Yamed_Spr_Dn.NameWithID, DATE_Z_2, D3_DSS_OMS.DS,dss_dn.NameWithID
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						--join Yamed_Spr_MedicalEmployee on IDDOKT=SNILS
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--left join D3_DSS_OMS on D3_SL_OMS.id=D3_DSS_OMS.D3_SLID
		--			left JOIN Yamed_Spr_Dn dss_dn on D3_DSS_OMS.pr_ds2_n=dss_dn.id
				--	left JOIN Yamed_Spr_Dn on D3_SL_OMS.dn=Yamed_Spr_Dn.id
					left join D3_USL_OMS on D3_SL_OMS.id=D3_USL_OMS.D3_SLID
					--LEFT JOIN Yamed_Spr_UslCode on D3_USL_OMS.VID_VME=Yamed_Spr_UslCode.ID
					--LEFT JOIN Yamed_Spr_Dn on D3_SL_OMS.dn=Yamed_Spr_Dn
					--join D3_SCHET_OMS on D3_ZSL_OMS.D3_SCID=D3_SCHET_OMS.id 
					--LEFT JOIN D3_ONK_SL_OMS on D3_SL_OMS.id=D3_ONK_SL_OMS.d3_slid
					--LEFT JOIN n003 on D3_ONK_SL_OMS.ONK_T=n003.id_t
					--LEFT JOIN n004 on D3_ONK_SL_OMS.ONK_N=n004.id_n
					--LEFT JOIN n005 on D3_ONK_SL_OMS.ONK_M=n005.id_m
					--LEFT JOIN n002 on D3_ONK_SL_OMS.STAD=n002.id_st
					--LEFT JOIN D3_CONS_OMS on D3_SL_OMS.id=D3_CONS_OMS.d3_slid
					--LEFT JOIN D3_NAPR_OMS on D3_SL_OMS.id=D3_NAPR_OMS.d3_slid 
					--LEFT JOIN D3_NAZ_OMS on D3_SL_OMS.id=D3_NAZ_OMS.d3_slid 
				--	JOIN v025 on D3_SL_OMS.P_CEL25=idpc
where D3_ZSL_OMS.D3_SCID in (118,120) 
and ds1<>ds 
GROUP BY w, ds, DATEDIFF(yy,dr,GETDATE())


//   4001
declare  @sc1 int = 168, @sc2 int = 170

SELECT count(*)
from D3_ZSL_OMS 
where D3_ZSL_OMS.ID not in (
select DISTINCT D3_ZSL_OMS.ID 
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
				left join D3_USL_OMS on D3_SL_OMS.id=D3_USL_OMS.D3_SLID 
			
where D3_ZSL_OMS.D3_SCID in (@sc1,@sc2) 
and left(ds,3) ='Z72')
and D3_ZSL_OMS.D3_SCID in (@sc1,@sc2) 








//5000.1 и 2  новые 

declare  @sc1 int = 168

-- Трудоспособные
select *, count(*) 
from (
select left(ds1,3) as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())<56 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<61 and w=1))

UNION all
select  left(ds,3) as d, pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())<56 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<61 and w=1))
) as ddd
GROUP BY d,  dn
ORDER BY d,  dn

--Старше трудоспособного
select *, count(*) 
from (
select left(ds1,3) as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())>55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>60 and w=1))

UNION all
select  left(ds,3) as d,  pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())>55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>60 and w=1))
) as ddd
GROUP BY d,  dn
ORDER BY d,  dn


-- 2 часть для впервые выявленных
-- Трудоспособные
select *, count(*) 
from (

select left(ds1,3) as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())<56 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<61 and w=1))
and ds1_pr=1   

UNION all

select  left(ds,3) as d, pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())<56 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<61 and w=1))
and ds_pr=1
) as ddd
GROUP BY d,  dn

ORDER BY d

--Старше трудоспособного
select *, count(*) 
from (

select left(ds1,3) as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())>55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>60 and w=1))
and ds1_pr=1  

UNION all

select  left(ds,3) as d,  pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (@sc1) 
and ((DATEDIFF(yy,dr,GETDATE())>55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>60 and w=1))
and ds_pr=1
) as ddd
GROUP BY d,  dn

ORDER BY d


//6000 

-- Трудоспособные
select 'Трудоспособные' as n, V017.namewithid,  count(*)
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
				join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
				LEFT JOIN v017 on RSLT_D=V017.iddr
where D3_ZSL_OMS.D3_SCID in (123,125) and V017.dateend is null
and ((DATEDIFF(yy,dr,GETDATE())<56 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<61 and w=1))
GROUP BY V017.namewithid
 UNION all
--Старше трудоспособного
select 'Старше трудоспособного' as n, V017.namewithid,   count(*)
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
				join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
				LEFT JOIN v017 on RSLT_D=V017.iddr
where D3_ZSL_OMS.D3_SCID in (123,125) and V017.dateend is null
and ((DATEDIFF(yy,dr,GETDATE())>55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>60 and w=1))
GROUP BY V017.namewithid
ORDER BY n, V017.namewithid

//600х

declare  @sc1 int = 168, @sc2 int = 170


select Work_stat= CASE
when Work_stat=1 then 'Работающий'
when Work_stat=2 then 'Не работающий'
when Work_stat=3 then 'Студент очного'
else 'Неизвестно' end, count(*) 'Кол-во'
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
				join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
			
where D3_ZSL_OMS.D3_SCID in (@sc1,@sc2) 
GROUP BY Work_stat







//5000.1 и 2  старое , до объединения диагнозов
 
-- Трудоспособные
select *, count(*) 
from (
select ds1 as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())<55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<60 and w=1))

UNION all
select  ds as d, pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())<55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<60 and w=1))
) as ddd
GROUP BY d,  dn
ORDER BY d,  dn

--Старше трудоспособного
select *, count(*) 
from (
select ds1 as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())>54 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>59 and w=1))

UNION all
select  ds as d,  pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())>54 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>59 and w=1))
) as ddd
GROUP BY d,  dn
ORDER BY d,  dn


-- 2 часть для впервые выявленных
-- Трудоспособные
select *, count(*) 
from (

select ds1 as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())<56 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<61 and w=1))
and ds1_pr=1   

UNION all

select  ds as d, pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())<56 and w=2)  or (DATEDIFF(yy,dr,GETDATE())<61 and w=1))
and ds_pr=1
) as ddd
GROUP BY d,  dn

ORDER BY d

--Старше трудоспособного
select *, count(*) 
from (

select ds1 as d,  dn as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					--LEFT JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())>55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>60 and w=1))
and ds1_pr=1  

UNION all

select  ds as d,  pr_ds2_n as dn
from D3_ZSL_OMS   join D3_SL_OMS  on D3_SL_OMS.D3_ZSLID=D3_ZSL_OMS.ID
						join D3_PACIENT_OMS on D3_ZSL_OMS.D3_PID=D3_PACIENT_OMS.ID
					JOIN d3_dss_oms  on D3_SL_OMS.id=d3_dss_oms.d3_slid
where D3_ZSL_OMS.D3_SCID in (123) 
and ((DATEDIFF(yy,dr,GETDATE())>55 and w=2)  or (DATEDIFF(yy,dr,GETDATE())>60 and w=1))
and ds_pr=1
) as ddd
GROUP BY d,  dn

ORDER BY d




