SELECT sch.id, zs.id, usl.CODE_USL, usl.VID_VME, p.npolis,usl.DATE_IN
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and sch.month=7-- AND sch.id IN (171)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
JOIN(
select usl.CODE_USL,p.npolis,usl.DATE_IN,COUNT(*) kol_vo
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and sch.month=7-- AND sch.id IN (160,166,167)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231') AND ms.id LIKE 'R01.001.006'
GROUP BY  usl.CODE_USL,ms.ishod,zs.ISHOD, p.npolis,usl.DATE_IN
HAVING COUNT(*)>1
) t ON t.npolis=p.NPOLIS AND t.CODE_USL=usl.CODE_USL
ORDER BY npolis


--SELECT * FROM medicalServices