--if OBJECT_ID('ztemp_digCdelete_112021') is not null drop table ztemp_digCdelete_112021

--!!!!!!
SELECT distinct sch.id AS schid_old,usl.CODE_USL,zs.id AS zslid,p.ID AS pid,p.fam,p.im,p.ot,p.dr, usl.VID_VMe, p.npolis,usl.DATE_IN,usl.DATE_OUT,zs.sumv
--zs.id izslid, s.id slid,p.ID D3_PID
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD
--t.DATE_Z_1, t.DATE_Z_2,zs.D3_SCID AS zs_d3_schid,p.D3_SCID p_D3_SCID
--INTO ztemp_digCdelete_062023_233
--INTO ztemp_digCdelete_082023_283
--INTO ztemp_digCdelete_092023_240
--INTO ztemp_digCdelete_112023_65
--INTO ztemp_digCdelete_122023_191
--INTO ztemp_digCdelete_012024_258
INTO ztemp_digCdelete_022024_580
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024      aND   sch.id     IN  (18501,18502,18504)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id AND code_usl LIKE 'R%' AND code_usl not LIKE 'R03%'-- AND code_usl LIKE 'R01.001.007'
--JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231') AND ms.code_usl NOT LIKE 'R03%'
JOIN
(
select sch.id AS schit, zs.id,zs.DATE_Z_1, zs.DATE_Z_2, p.npolis
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024  and   sch.id    IN   (18501,18502,18504)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
) t ON t.npolis=p.npolis AND t.date_z_1<usl.DATE_IN AND usl.date_in<t.DATE_Z_2
--WHERE zs.D3_SCID IN (1247,1248,1258)
--where p.id=1239687