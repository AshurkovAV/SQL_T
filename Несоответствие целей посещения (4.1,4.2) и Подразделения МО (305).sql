--select * 
DECLARE @p INT = 23800
update dso SET P_CEL25 = '4.1', P_CEL = '4.1'
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
	inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = zs.ID
where zs.EXP_COMENT like '%Несоответствие целей посещения (4.1,4.2) и Подразделения МО (305)%' and zs.D3_SCID = @p
  
update zs SET EXP_COMENT = NULL
fROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
	  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
where zs.EXP_COMENT like '%Несоответствие целей посещения (4.1,4.2) и Подразделения МО (305)%' and zs.D3_SCID = @p
