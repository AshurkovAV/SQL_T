--if OBJECT_ID('ztemp_digCdelete_072020') is not null drop table ztemp_digCdelete_062020

--!!!!!!
--begin tran --commit tran
--update usl set date_in=t.DATE_Z_1,date_out=t.DATE_Z_1
SELECT distinct sch.id AS schid_old,usl.CODE_USL,zs.id AS zslid,p.ID AS pid,p.fam,p.im,p.ot,p.dr, usl.VID_VMe, p.npolis,usl.DATE_IN,usl.DATE_OUT,zs.sumv,
--zs.id izslid, s.id slid,p.ID D3_PID
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD
t.DATE_Z_1, t.DATE_Z_2,zs.D3_SCID AS zs_d3_schid,p.D3_SCID p_D3_SCID, datediff(dd,date_in,t.DATE_Z_1)
--INTO ztemp_digCdelete_012021
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021  and sch.id in (2784,2783,2782)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id AND code_usl LIKE 'R%' AND code_usl not LIKE 'R03%' AND code_usl  LIKE 'R01.001.007'
--JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231') AND ms.code_usl NOT LIKE 'R03%'
JOIN
(
select sch.id AS schit, zs.id,zs.DATE_Z_1, zs.DATE_Z_2, p.npolis
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021   and sch.id in (2784,2783,2782)-- and sch.month=12-- AND sch.id IN (1275,1276,1278)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
) t ON t.npolis=p.npolis AND t.date_z_1<usl.DATE_IN AND usl.date_in<t.DATE_Z_2
--WHERE zs.D3_SCID IN (1247,1248,1258)
--where p.id=1239687
--where abs(datediff(dd,date_in,t.DATE_Z_1))=1



--дописать апдейт на даты случая и законченного и даты напарвления в законченном и даты напраления  в блоке направлений