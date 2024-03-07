--declare @p1 int =160
  
select 
  ID, SUMV, '' com
  ,month, year,smo, lpu, d3_scid, id, fam, im, ot, dr,os_sluch_region,IDDOKT, ct, z.DATE_2
  ,code_usl
from(
  select 
    distinct *
    ,count(id)over(PARTITION BY FAM, IM, OT, dr, DATE_2, PROFIL, lpu,IDDOKT,smo,os_sluch_region) ct --количество ВСЕГО посещений за 1 день у одного пациента
  from(
    select 
      distinct
      zs.ID, zs.SUMV, pa.FAM, pa.IM, pa.OT, dr, sl.DATE_2 , pa.smo
      ,sc.MONTH, sc.YEAR, sl.DS1, zs.USL_OK, sl.PROFIL, sl.P_CEL25, zs.D3_SCID, zs.LPU--, mek_coment
      ,zs.os_sluch_region,sl.IDDOKT --9999 это без признака
      ,ms.code_usl
    from 
      D3_ZSL_OMS zs
        join D3_SCHET_OMS sc on sc.id=zs.D3_SCID
                  and zs.lpu in (460003,460010,460061,460039)
                 and (zs.os_sluch_region IS NULL OR zs.os_sluch_region IN (59,63,40))
                 --AND ISNULL(zs.MEK_COUNT,0)=0
                 --and d3_scid=@p1 
                 AND sc.[YEAR]=2024
                 AND sc.month=1
                --AND   sc.id      IN (17386,17389,17390)
                 
        join D3_SL_OMS sl on sl.d3_zslid=zs.id AND sl.lpu_1<>302
        join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID --AND pa.smo NOT LIKE '46%'
        left   JOIN D3_USL_OMS AS u ON u.D3_SLID = sl.ID
       LEFT  JOIN medicalServices AS ms ON u.CODE_USL = ms.code_usl
    where 
      zs.usl_ok=3
      AND ms.code_usl IS  NULL
    )z
  )z
where
	ct>=2
	--and d3_scid=@p1 
	--AND z.[YEAR]=2020
--group by
--	ID, SUMV  
-- -- order by fam, im, ot