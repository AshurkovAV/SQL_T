--declare @p1 int =160
  
select 
  ID, SUMV, '' com
  ,month, year,smo, lpu, d3_scid, id, fam, im, ot, dr, ct, z.DATE_2

from(
  select 
    distinct *
    ,count(id)over(PARTITION BY FAM, IM, OT, dr, DATE_2,smo) ct --количество ВСЕГО посещений за 1 день у одного пациента
  from(
    select 
      distinct
      zs.ID, zs.SUMV, pa.FAM, pa.IM, pa.OT, dr, sl.DATE_2 , pa.smo
      ,sc.MONTH, sc.YEAR, sl.DS1, zs.USL_OK, sl.PROFIL, sl.P_CEL25, zs.D3_SCID, zs.LPU--, mek_coment
      ,zs.os_sluch_region,sl.IDDOKT --9999 это без признака
     
    from 
      D3_ZSL_OMS zs
        join D3_SCHET_OMS sc on sc.id=zs.D3_SCID
                  and zs.lpu in (460003,460010,460061,460039)
                 and zs.os_sluch_region IS NULL
                 --AND ISNULL(zs.MEK_COUNT,0)=0
                 --and d3_scid in (190,191)
                 AND sc.[YEAR]=2020
                 AND sc.month=7
                 
        join D3_SL_OMS sl on sl.d3_zslid=zs.id AND sl.lpu_1<>302
        join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID --AND pa.smo NOT LIKE '46%'
        left   JOIN D3_USL_OMS AS u ON u.D3_SLID = sl.ID
      -- LEFT  JOIN medicalServices AS ms ON u.CODE_USL = ms.code_usl
    where 
      zs.usl_ok in (1,2)
     -- AND ms.code_usl IS  NULL
    )z
  )z
where
	ct>=2
	--and d3_scid=@p1 
	--AND z.[YEAR]=2020
--group by
--	ID, SUMV  
-- -- order by fam, im, ot