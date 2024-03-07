--update zs set zs.npr_mo=460061
SELECT zs.ID,zs.SUMV,zs.npr_mo , zs.npr_date ,zs.date_z_1,s.nhistory
--sch.id AS schid_old,zsl_id,usl.CODE_USL,zs.id AS zslid,p.ID AS pid, usl.VID_VMe, p.npolis,usl.DATE_IN,usl.DATE_OUT,zs.npr_mo, zs.npr_date,usl.code_usl
--zs.id izslid, s.id slid,p.ID D3_PID
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

--INTO ztemp_digCdelete
--update zs set npr_date = zs.date_z_1, npr_mo = '460061'
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=6-- AND sch.id not IN (210)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (3) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id and code_usl like 'R%'
 where (zs.npr_mo is  null or zs.npr_date is  null) --and sch.id=@p1