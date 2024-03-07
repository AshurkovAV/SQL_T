-- Не заполнено обязательное поле вид полиса VPOLIS в ПАЦИЕНТЕ
--ставим - 3
UPDATE p set VPOLIS = 3
FROM [D3_PACIENT_OMS] p 
  inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
where p.D3_SCID = @p1
  and p.VPOLIS is NULL AND LEN( p.NPOLIS ) = 16
  
-- Не заполнено обязательное поле вид полиса VPOLIS в ПАЦИЕНТЕ
--ставим - 2
UPDATE p set VPOLIS = 2
FROM [D3_PACIENT_OMS] p 
  inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
where p.D3_SCID = @p1
  and p.VPOLIS is NULL AND LEN( p.NPOLIS ) = 9