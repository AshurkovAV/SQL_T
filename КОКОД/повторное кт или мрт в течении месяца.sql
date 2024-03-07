SELECT distinct sch.id, zs.id,s.nhistory, usl.CODE_USL, usl.VID_VME,u.name, p.npolis,usl.DATE_IN, p.fam,p.im
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=11 --AND sch.id  IN  (1082,1088)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u on u.id=usl.vid_vme
JOIN(
select usl.CODE_USL, usl.VID_VMe, p.npolis,COUNT(*) kol_vo
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=11 --AND sch.id  IN  (1082,1088)--AND sch.id not IN  (1083,1084,1086,1113)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231')
where usl.code_usl like 'R01.001.001%' OR  usl.code_usl like 'R01.001.002%'
GROUP BY  usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD, p.npolis--,usl.DATE_IN
HAVING COUNT(*)>1
) t ON t.npolis=p.NPOLIS AND t.CODE_USL=usl.CODE_USL
ORDER BY npolis, usl.CODE_USL, usl.VID_VME

--SELECT * FROM  medicalServices