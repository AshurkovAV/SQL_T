update sl set  TAL_D=DATE_1,TAL_P=DATE_1
--SELECT --COUNT(DISTINCT zs.id)
--sch.code_mo,zs.id,sl.TAL_D,sl.tal_p,dr,nhistory,date_1,date_2
FROM  D3_SCHET_OMS sch                      	
  inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID] --AND sch.[YEAR]=2019 AND sch.month=8	
  inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]   	
    join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 	
	
	where zs.vidpom=32 AND sch.year=2023 AND sch.month=12
	-- and sch.code_mo=460061 
	 and (sl.TAL_D<dr or TAL_D>DATE_2 or TAL_P<TAL_D or TAL_P<DR)