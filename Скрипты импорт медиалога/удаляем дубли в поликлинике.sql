declare @p1 int =20292

if OBJECT_ID('ztemp_digCdelete') is not null drop table ztemp_digCdelete
SELECT dzo.ID izslid, dso.ID slid, dzo.D3_PID, dzo.EXP_COMENT, p.FAM, p.im, p.OT, p.DR, p.NPOLIS
INTO ztemp_digCdelete
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS p ON p.ID = dzo.D3_PID
WHERE dzo.ID in (

--SELECT * FROM ztemp_digCdelete
 




select 
zs.ID--,zs.sumv
FROM [D3_SCHET_OMS] sch                  		
	inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
	inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 	
	JOIN d3_sl_oms sl ON sl.D3_ZSLID=zs.id
	left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id and sank.s_tip=1	
	join (
	select distinct sch.id,zs.id zid, p.npolis,sl.DATE_1,sl.DATE_2,zs.sumv,zs.USL_OK,sch.CODE_MO,p.novor,sl.iddokt
	from [D3_SCHET_OMS] sch                  		
	inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
	inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 	
	JOIN d3_sl_oms sl ON sl.D3_ZSLID=zs.id 	
	left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id and sank.s_tip=1	
	where sank.id is null 
	and zs.USL_OK=3 and sch.id=@p1
	            )t on t.npolis=p.npolis
				     and sl.DATE_2=t.DATE_2
					 and t.USL_OK=zs.usl_ok
					 and zs.SUMV=t.SUMV
					 and zs.id<>t.zid
					 and sch.code_mo=t.CODE_MO
					 and p.NOVOR=t.NOVOR
					 and sl.iddokt=t.IDDOKT
					-- and p.FAM = 'Гуторова'
					--AND ( p.NPOLIS = '4655040897000044' OR p.fam = 'АГИБАЛОВА' )
				and zs.EXP_COMENT LIKE '%Дублирование пол%'

	
where sch.id=@p1
and sank.id is null
and zs.USL_OK=3
and (sl.P_CEL25<>'2.3' or sl.P_CEL25 is null)
)

GO 
if OBJECT_ID('ztemp_digCdeletet') is not null drop table ztemp_digCdeletet
SELECT dzo.ID izslid, dso.ID slid, dzo.D3_PID, dzo.EXP_COMENT, p.FAM, p.im, p.OT, p.DR, p.NPOLIS
INTO ztemp_digCdeletet
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS p ON p.ID = dzo.D3_PID
WHERE dzo.ID in (

SELECT MIN(g.izslid) AS id FROM ztemp_digCdelete g
GROUP BY g.npolis  
)
GO

--SELECT * FROM ztemp_digCdeletet





DELETE FROM D3_USL_OMS
WHERE D3_SLID IN (SELECT slid FROM ztemp_digCdeletet)

DELETE FROM D3_SL_OMS
WHERE ID IN (SELECT slid FROM ztemp_digCdeletet)

DELETE FROM D3_ZSL_OMS
WHERE ID IN (SELECT izslid FROM ztemp_digCdeletet)

DELETE FROM D3_PACIENT_OMS
WHERE ID IN (SELECT D3_PID FROM ztemp_digCdeletet)

