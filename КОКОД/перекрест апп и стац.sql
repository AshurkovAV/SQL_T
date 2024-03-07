--DROP TABLE ztemp_per_112020 
SELECT sch.id AS schid_old,zs.id AS zslid,p.ID AS pid,p.fam,p.im,p.ot,p.dr, p.npolis,zs.date_z_1,zs.sumv,
--zs.id izslid, s.id slid,p.ID D3_PID
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD
t.DATE_Z_1, t.DATE_Z_2,
zs.D3_SCID AS zs_d3_schid,p.D3_SCID p_D3_SCID
--INTO ztemp_per_112020
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2023  AND  sch.id      IN (16249,16250,16251)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (3) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 left jOIN d3_usl_oms usl ON usl.D3_SLID=s.id
---JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231') AND ms.code_usl NOT LIKE 'R03%'
JOIN
(
select sch.id AS schit, zs.id,zs.DATE_Z_1, zs.DATE_Z_2, p.npolis
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2023   AND  sch.id     IN (16249,16250,16251)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
) t ON t.npolis=p.npolis AND t.date_z_1<zs.date_z_1 AND zs.date_z_1<t.DATE_Z_2
WHERE  ( code_usl IS NULL)