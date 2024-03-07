--1--удаляю блок направления, где некорректные услуги и при этом нет подозрения на онко
--BEGIN tran --commit tran
declare @p1 int =2612
DELETE  FROM n
--Select zs.id as ID, zs.sumv as SUMV, '' com,n.NAPR_USL,s.DS_ONK
FROM [D3_SCHET_OMS] sch									
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id--and sch.month=11
									and sch.year=2023   and sch.month in (1) and sch.id IN (9374,9382,9395) --and sch.code_mo not like '460061'
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID	
 join 	D3_NAPR_OMS n on n.D3_SLID=s.id	
 left join Yamed_Spr_Usl804 u on u.id=n.NAPR_USL
where  n.NAPR_USL is not null and u.id is NULL AND ds_onk=0
--group by zs.id, zs.SUMV




---2-- заменяю вид направления на 1, где стоит подозрение и некорректная услуга в направлении

declare @p1 int =2612
UPDATE n SET n.napr_v=1, n.met_issl=NULL, n.napr_usl=NULL
--Select zs.id as ID, zs.sumv as SUMV, '' com,n.*
FROM [D3_SCHET_OMS] sch									
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id--and sch.month=11
									and sch.year=2022   and sch.month in (10)-- and sch.id IN (3274,3275,3279)  --and sch.code_mo not like '460061'
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID	
 join 	D3_NAPR_OMS n on n.D3_SLID=s.id	
 left join Yamed_Spr_Usl804 u on u.id=n.NAPR_USL
where  n.NAPR_USL is not null and u.id is NULL AND ds_onk=1



--BEGIN tran --commit tran
--declare @p1 int =2612
--DELETE  FROM n
Select zs.id as ID, zs.sumv as SUMV, '' com,n.*,s.DS_ONK
FROM [D3_SCHET_OMS] sch									
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id--and sch.month=11
									and sch.year=2022   and sch.month in (10) --and sch.id IN (3274,3275,3279) --and sch.code_mo not like '460061'
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID	
 join 	D3_NAPR_OMS n on n.D3_SLID=s.id	
 left join Yamed_Spr_Usl804 u on u.id=n.NAPR_USL
where  --n.NAPR_V is  null AND ds_onk IS NOT NULL
 zs.id=13746816
 