UPDATE p SET SPOLIS = NULL
FROM [D3_PACIENT_OMS] p
	inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
where p.D3_SCID = 2177
	and p.VPOLIS<>1 --Не полис ОМС старого образца
	and p.SPOLIS is not null 