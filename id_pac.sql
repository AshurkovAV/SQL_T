--select * 
<<<<<<< HEAD
DECLARE @p INT = 23799
=======
DECLARE @p INT = 23744
>>>>>>> e8f1c39c6b0ec0db9093e40e90869ce12ca5707c
update p set ID_PAC = newid()
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
	inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
where zs.EXP_COMENT like '%id_pac%' and zs.D3_SCID = @p
  
update zs SET EXP_COMENT = NULL, D3_PGID = p.ID_PAC
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
	  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
where zs.EXP_COMENT like '%id_pac%' and zs.D3_SCID = @p