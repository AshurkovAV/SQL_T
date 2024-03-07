SELECT --COUNT(DISTINCT zs.id)	
--sch.month,sch.id,nhistory--,
--sch.id,
 usl.code_usl,m.[name],count(zs.zsl_id),count(distinct zs.id) as ID, sum(zs.sumv) as SUMV	
FROM  D3_SCHET_OMS sch                      	
  inner join  [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID] --AND sch.[YEAR]=2019 AND sch.month=8	
  inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]   	
    join  D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 	
	join d3_usl_oms usl on usl.D3_SLID=sl.id
	left join [medicalServices] m on m.[code_usl]=usl.[code_usl] 
	where usl.code_usl like 'R01%' AND sch.year=2020 AND sch.month=6 and sch.code_mo=460061 AND sch.id not IN (383,389)
group by sch.month, usl.code_usl,m.[name]	
	
SELECT --COUNT(DISTINCT zs.id)	
sch.month, usl.code_usl,m.[name],count(zs.zsl_id),count(distinct zs.id) as ID, sum(zs.sumv) as SUMV	
FROM  [ELMEDICINENEWFOND].[dbo].D3_SCHET_OMS sch                      	
  inner join  [ELMEDICINENEWFOND].[dbo].[D3_PACIENT_OMS] p on sch.id=p.[D3_SCID] --AND sch.[YEAR]=2019 AND sch.month=8	
  inner join  [ELMEDICINENEWFOND].[dbo].[D3_ZSL_OMS] zs on p.id=zs.[D3_PID]   	
    join  [ELMEDICINENEWFOND].[dbo].D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 	
	join d3_usl_oms usl on usl.D3_SLID=sl.id
	left join [medicalServices] m on m.[code_usl]=usl.[code_usl] 
	left join d3_sank_oms sa on sa.D3_ZSLID=zs.id and sa.s_tip=1
	where usl.code_usl like 'R01%' AND sch.year=2020 AND sch.month between 1 and 2 and sch.code_mo=460061 and sa.id is null
    --AND zs.D3_SCID=@p1	
   -- left JOIN  [ELMEDICINENEWFOND].[dbo].v002_v020_2020 v2 ON v2.V002=sl.PROFIL	
--WHERE zs.usl_ok IN (3) AND sch.year=2020 AND sch.month=2 and sch.code_mo=460061 and	
--(sl.p_cel25 like '1.3' or sl.p_cel like '1.3' or dn is not null)	
group by sch.month, usl.code_usl,m.[name]	
	
	
SELECT --COUNT(DISTINCT zs.id)	
sch.month,p.smo, usl.code_usl,m.[name], zs.id,zs.sumv, sa.s_osn,sa.s_tip,sa.s_com	
FROM  [ELMEDICINENEWFOND].[dbo].D3_SCHET_OMS sch                      	
  inner join  [ELMEDICINENEWFOND].[dbo].[D3_PACIENT_OMS] p on sch.id=p.[D3_SCID] --AND sch.[YEAR]=2019 AND sch.month=8	
  inner join  [ELMEDICINENEWFOND].[dbo].[D3_ZSL_OMS] zs on p.id=zs.[D3_PID]   	
    join  [ELMEDICINENEWFOND].[dbo].D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 	
	join d3_usl_oms usl on usl.D3_SLID=sl.id
	left join [medicalServices] m on m.[code_usl]=usl.[code_usl] 
	 join d3_sank_oms sa on sa.D3_ZSLID=zs.id and sa.s_tip=1
	where usl.code_usl like 'R01%' AND sch.year=2020 AND sch.month between 1 and 2 and sch.code_mo=460061 --and sa.id is null
