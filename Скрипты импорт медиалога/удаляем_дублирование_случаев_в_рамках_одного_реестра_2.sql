declare @p1 int=20292 

if OBJECT_ID('ztemp_digCdelete') is not null drop table ztemp_digCdelete
SELECT dzo.ID izslid, dso.ID slid, dzo.D3_PID, dzo.EXP_COMENT, p.FAM, p.im, p.OT, p.DR, p.NPOLIS
INTO ztemp_digCdelete
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS p ON p.ID = dzo.D3_PID
WHERE dzo.ID in (

select ID--, SUMV, '' com--'дублирование случаев в рамках одного реестра' com--,FAM,IM, OT, DR
from (
  SELECT   ROW_NUMBER() OVER (PARTITION BY v.FAM, v.IM, v.OT, v.DR, v.PROFIL ORDER BY v.p_cel25 desc) RN
        ,v.ID
        ,v.FAM
        ,v.IM
        ,v.OT
        ,v.DR
        ,v.PROFIL
        ,v.p_cel25
        ,v.SUMV
    from  (select  distinct zsl.id as ID
              --,sl.id
              ,pa.FAM
              ,pa.IM
              ,pa.OT
              ,pa.DR
              ,date_z_1
              ,zsl.LPU
              ,zsl.SUMV
              ,sl.profil,SUBSTRING(sl.ds1,1,3) as ds
              ,max(case when sl.p_cel25 = '1.1' then '5.0' else sl.p_cel25 end) p_cel25
          from D3_ZSL_OMS zsl
          join D3_SL_OMS sl on zsl.id=sl.D3_ZSLID and  OS_SLUCH_REGION is null and zsl.USL_OK in (3) 
          AND zsl.IDSP<>28
          join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID  and pa.D3_SCID=@p1
          --ищем полные дубли
          join(  select   pa.FAM
                  ,pa.IM
                  ,pa.OT
                  ,pa.DR
                  ,DATE_1
                  ,zsl.lpu
                  ,sl.profil,SUBSTRING(sl.ds1,1,3) as ds
              FROM D3_ZSL_OMS zsl
              join D3_SL_OMS sl on zsl.id=sl.D3_ZSLID and  OS_SLUCH_REGION is null-- and isnull(zsl.MEK_COUNT,0)=0 
              
              join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID and zsl.USL_OK in (3) and pa.D3_SCID=@p1
                            and sl.profil not in (85,86,87,88,89,90,140,171)
              join D3_SCHET_OMS sch on sch.id=pa.D3_SCID    and sch.CODE_MO not in (460039,460061,460003,460010)                             
              group by pa.FAM,pa.IM,pa.OT,pa.DR,DATE_1,zsl.lpu,
			  --date_z_1,
			  sl.profil,SUBSTRING(sl.ds1,1,3) 
              having count(*)>1
       
            ) t on pa.FAM=t.FAM and pa.IM=t.IM and pa.ot=t.ot and pa.dr=t.dr and sl.DATE_1=t.DATE_1  and sl.profil=t.profil
                and zsl.lpu=t.lpu and SUBSTRING(sl.ds1,1,3)=t.ds
          
          group by  zsl.id,date_z_1,pa.FAM,pa.IM,pa.OT,pa.DR,zsl.LPU,zsl.SUMV,sl.profil,SUBSTRING(sl.ds1,1,3) 
        ) v
    
 ) m
where RN>1


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