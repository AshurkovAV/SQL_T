--R01.001.006
--R01.001.005
--update zs set zs.date_z_1=zs.npr_date
--update s set s.date_1=zs.npr_date
update usl set usl.date_in=zs.npr_date
--SELECT sch.id AS schid_old,usl.CODE_USL,zs.id AS zslid,zs.npr_date,zs.date_z_1,zs.date_z_2,date_1,date_2,date_in,date_out
--zs.id izslid, s.id slid,p.ID D3_PID
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

--INTO ztemp_digCdelete_062020
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=7 AND sch.id IN (413,412 )
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
 where (usl.code_usl like 'R01.001.006%' or 
 usl.code_usl like 'R01.001.005%')
 --and zs.npr_date is null

-- select * from medicalServices