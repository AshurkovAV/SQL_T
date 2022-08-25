 if OBJECT_ID('ztamp_dublzsl') is not null drop table ztamp_dublzsl
 	declare @pp1 int = 2155
 select dzo.id zsl_id, dso.ID sl_id, dpo.FAM, dpo.IM, dpo.OT, dpo.ID D3_PID, dso.P_CEL25  --distinct t1.id as ID--, t1.SUMV as SUMV, 'перекрест поликлиники зак случай с другим зак сл' com
   INTO ztamp_dublzsl
   --UPDATE dzo SET dzo.EXP_COMENT = 'перекрест поликлиники зак случай с другим зак сл'
   FROM D3_ZSL_OMS AS dzo
   JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
   JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
   WHERE dzo.ID IN (
   SELECT t1.id 
    from
    (select  distinct zsl.id, pa.FAM, pa.IM, pa.OT, pa.DR
    , DATE_z_1, DATE_z_2
    , zsl.LPU, zsl.SUMV, sl.profil,SUBSTRING(sl.ds1,1,3) as ds
    FROM D3_ZSL_OMS zsl
    join D3_SL_OMS sl on zsl.id=sl.D3_ZSLID 
    join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID and zsl.USL_OK in (3) and isnull(zsl.MEK_COUNT,0)=0 and zsl.D3_SCID=@pp1
                                                            and sl.profil not in (85,86,87,88,89,90,140,171)
                                                            and OS_SLUCH_REGION is null
                                                            and FOR_POM<>2 AND (zsl.PR_NOV IS NULL OR zsl.PR_NOV = 0)
    
 
    )as t1 --все случаи поликлиники из данного счета
    inner     join (select  zsl.id as id, pa.FAM, pa.IM, pa.OT, pa.DR,SUBSTRING(sl.ds1,1,3) as ds
    , DATE_Z_1, DATE_Z_2, 
    zsl.LPU, zsl.SUMV, sl.profil
                    FROM D3_ZSL_OMS zsl
                        join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
                                                    and zsl.D3_SCID=@pp1
                                                     and isnull(zsl.MEK_COUNT,0)=0 
                                                     and zsl.USL_OK = 3
                                                       and FOR_POM<>2 and OS_SLUCH_REGION is NULL AND (zsl.PR_NOV IS NULL OR zsl.PR_NOV = 0)
                        join D3_SL_OMS sl on zsl.id=sl.D3_ZSLID AND sl.profil not in (85,86,87,88,89,90,140,171)
 
                 ) as t2 on t1.FAM=t2.FAM
                         and t1.im=t2.im
                         and t1.ot=t2.ot
                         and t1.dr=t2.dr
                         and (
                         (t1.DATE_z_1>=t2.DATE_Z_1 and t1.DATE_z_1<=t2.DATE_Z_2) or (t2.DATE_z_1>=t1.DATE_Z_1 and t2.DATE_Z_1<=t1.DATE_Z_2)
                              )
                         and t1.id<>t2.id
                         and t1.PROFIL=t2.PROFIL
                         and t1.ds=t2.ds) 
--AND p_cel25 = '1.0'         
         
SELECT * FROM ztamp_dublzsl --WHERE p_cel25 = '1.0' ORDER BY fam       

--DELETE FROM D3_SL_OMS
--WHERE ID IN (SELECT sl_id FROM ztamp_dublzsl)

--DELETE FROM D3_ZSL_OMS
--WHERE ID IN (SELECT zsl_id FROM ztamp_dublzsl)

--DELETE FROM D3_PACIENT_OMS
--WHERE ID IN (SELECT D3_PID FROM ztamp_dublzsl)                  
                         
----UPDATE dz SET dz.D3_SCID = 2144, dz.EXP_COMENT = 'перекрест поликлиники зак случай с другим зак сл'
----FROM D3_ZSL_OMS dz 
----WHERE id IN (
----SELECT id
----FROM ztamp_dublzsl01042019)