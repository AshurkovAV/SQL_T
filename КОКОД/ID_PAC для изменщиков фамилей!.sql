select * 
--update p set ID_PAC = newid()
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
  where zs.EXP_COMENT like '%id_pac%' and zs.D3_SCID = 16122
 SELECT * 
--  update zs SET EXP_COMENT = NULL, D3_PGID = p.ID_PAC
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
  where zs.EXP_COMENT like '%id_pac%' and zs.D3_SCID = 16122