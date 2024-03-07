
SELECT distinct p.fam,p.im,p.ot,p.dr, p.npolis,s.ds1 [диагноз гистологии], usl.VID_VMe,zs.NPR_DATE [дата направления], zs.DATE_Z_2[дата исследования], t.name [отделение]
, t.NHISTORY [номер истории], t.ds1 [диагноз госпитализации],  t.DATE_Z_1 [дата начала госпит],t.DATE_Z_2 [дата оконч госпит]
 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022   
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id  AND code_usl LIKE 'R01.001.006'
--JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231') AND ms.code_usl NOT LIKE 'R03%'
JOIN
(
select sch.id AS schit, zs.id,zs.DATE_Z_1, zs.DATE_Z_2, p.NPOLIS,k.name, s.NHISTORY , s.ds1
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
left join KOKOD_OTD k on k.kod_otd=s.podr 
) t ON t.npolis=p.npolis AND zs.NPR_DATE between t.date_z_1 AND t.date_z_2 AND zs.DATE_Z_2>t.date_z_2
