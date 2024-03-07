update ksg set ksg.koef_u=1
--select sch.id AS schit, zs.id,ksg.koef_u
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=6 AND sch.id IN (402)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 