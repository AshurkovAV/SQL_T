SELECT sank.*
INTO ztemp_sank022019
FROM [D3_SCHET_OMS] sch                
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.month=2  AND sch.code_mo=460026 AND sch.year=2019
   -- and sch.id=@p1 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id --and zs.usl_ok<>4 and (zs.OS_SLUCH_REGION not in (7,8,9,11,12,17,18,22,23,37,38) or zs.OS_SLUCH_REGION is null)
  JOIN D3_SANK_OMS AS sank ON sank.D3_ZSLID=zs.id AND sank.S_TIP=1
