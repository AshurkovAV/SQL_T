UPDATE naz SET NAZ_N = 1
FROM [D3_SCHET_OMS] sch									
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.month=11
  and sch.id=2347
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID	
  join 	D3_NAZ_OMS naz ON naz.D3_SLID=s.id	
where   naz.NAZ_N IS NULL 
--group by zs.id, zs.SUMV