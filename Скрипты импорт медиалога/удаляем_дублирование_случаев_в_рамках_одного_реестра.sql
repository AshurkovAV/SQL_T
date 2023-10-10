declare @p1 int =20292

if OBJECT_ID('ztemp_digCdelete') is not null drop table ztemp_digCdelete
SELECT dzo.ID izslid, dso.ID slid, dzo.D3_PID, dzo.EXP_COMENT, p.FAM, p.im, p.OT, p.DR, p.NPOLIS
INTO ztemp_digCdelete
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS p ON p.ID = dzo.D3_PID
WHERE dzo.ID in (


select (zs.ID) --,zs.sumv --
from [D3_SCHET_OMS] sch 								
            inner join [D3_PACIENT_OMS] p on p.[D3_SCID]=sch.ID											
            inner join [D3_ZSL_OMS] zs on zs.[D3_PID]=p.id											
            inner join [D3_SL_OMS] s on s.[D3_ZSLID]=zs.ID 	
			left JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id and dso.S_TIP=1
			 left join (
			 select sch.id sch,zs.DATE_Z_1,zs.DATE_Z_2,zs.USL_OK,p.NOVOR,s.prvs,s.profil,p.fam,p.im,p.ot,p.dr,s.IDDOKT,count (distinct zs.id) k
			 from [D3_SCHET_OMS] sch 								
            inner join [D3_PACIENT_OMS] p on p.[D3_SCID]=sch.ID											
            inner join [D3_ZSL_OMS] zs on zs.[D3_PID]=p.id											
            inner join [D3_SL_OMS] s on s.[D3_ZSLID]=zs.ID 	 and s.PROFIL not in (63,85,86,87,88,89,90,171)
			left join d3_usl_oms usl on usl.D3_SLID=s.id and usl.CODE_USL like 'R%'
			where 
			(
			( zs.OS_SLUCH_REGION not in (6) or zs.OS_SLUCH_REGION is null)
			and
			usl.id is null
			)
			 group by sch.id,zs.DATE_Z_1,zs.DATE_Z_2,zs.USL_OK,p.NOVOR,s.prvs,s.profil,p.fam,p.im,p.ot,p.dr,s.IDDOKT
			 having count (distinct zs.id)>1
							 )z on zs.DATE_Z_1=z.DATE_Z_1 and zs.DATE_Z_2=z.DATE_Z_2 
							 and zs.USL_OK=z.USL_OK
							 and p.NOVOR=z.NOVOR and s.prvs=z.prvs and s.profil=z.profil 
							 and p.fam=z.fam and p.im=z.im and p.ot=z.ot and p.dr=z.dr and s.IDDOKT=z.IDDOKT
							 and z.sch=sch.id
			 where sch.id=@p1
			 and sch.code_mo not in ('460039','460061')
			 and z.sch is not null
			 and zs.USL_OK<>4
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
	
	
DELETE FROM D3_USL_OMS
WHERE D3_SLID IN (SELECT slid FROM ztemp_digCdeletet)

DELETE FROM D3_SL_OMS
WHERE ID IN (SELECT slid FROM ztemp_digCdeletet)

DELETE FROM D3_ZSL_OMS
WHERE ID IN (SELECT izslid FROM ztemp_digCdeletet)

DELETE FROM D3_PACIENT_OMS
WHERE ID IN (SELECT D3_PID FROM ztemp_digCdeletet)	