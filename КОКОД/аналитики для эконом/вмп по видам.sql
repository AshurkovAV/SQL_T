select sch.month,sl.VID_HMP ,v018.[HVIDNAME],zs.usl_ok,	zs.PR_NOV,
 count(zs.id) [количество]    	
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
	left join v018 on v018.[IDHVID]=sl.VID_HMP and sl.date_2 between v018.datebeg and isnull(v018.DATEEND, '20241231')
  where sch.code_mo=460061   	
        and (sch.year=2024 AND sch.month=1)  	
      and zs.vidpom=32	
      --and sa.id is null	
      --and podr is null	
     group by sch.month,sl.VID_HMP ,v018.[HVIDNAME],zs.usl_ok,zs.PR_NOV
      order by sch.month,sl.VID_HMP ,v018.[HVIDNAME]