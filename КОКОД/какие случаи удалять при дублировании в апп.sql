BEGIN TRAN 
--UPDATE zs SET zs.D3_SCID=210
UPDATE p SET p.D3_SCID=210
--SELECT d.* ,zs.D3_SCID,p.D3_SCID
FROM 
z_temp_delete_dubli_app_0220 d
inner join D3_ZSL_OMS zs on zs.ID=d.zs_id
--INNER JOIN [D3_SCHET_OMS] sch ON d.d3_scid =sch.id                  
  inner join D3_PACIENT_OMS p on  zs.D3_PID=p.id  
  --and sch.year=2020 and sch.month=2 --AND sch.id IN (160,166,167)
  --inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.ID=d.zs_id
  COMMIT TRAN
  
  ztemp_digCdelete
  --declare @p1 int =160
  
select 
  max(ID) zs_id, max(SUMV) zs_sumv--, '' com
  ,month, year,smo, lpu, d3_scid,  fam, im, ot, dr,os_sluch_region,IDDOKT, ct, z.DATE_2
INTO z_temp_delete_dubli_app_0220
from(
  select 
    distinct *
    ,count(id)over(PARTITION BY FAM, IM, OT, dr, DATE_2, PROFIL, lpu,IDDOKT,smo) ct --количество ВСЕГО посещений за 1 день у одного пациента
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
                 and zs.os_sluch_region IS NULL
                 --AND ISNULL(zs.MEK_COUNT,0)=0
                 --and d3_scid=190 
                 AND sc.[YEAR]=2020
                 AND sc.month=2
                 
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
group by
 month, year,smo, lpu, d3_scid,  fam, im, ot, dr,os_sluch_region,IDDOKT, ct, z.DATE_2