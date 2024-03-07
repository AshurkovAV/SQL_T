SELECT distinct sch.month, sl.nhistory, sl.metod_hmp, sl.podr,dbo.[f_getage](p.dr, zs.date_z_1) [возраст],zs.sumv  , zs.PR_NOV--,sl.VID_HMP ,v018.[HVIDNAME],	
 --count(zs.id) [количество]     
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
	left join v018 on v018.[IDHVID]=sl.VID_HMP and sl.date_2 between v018.datebeg and isnull(v018.DATEEND, '20211231')
  where sch.code_mo=460061   	
        and sch.year=2023 AND sch.id IN (9457,9604,10754,12849,14892)--sch.month=5  	
      and zs.vidpom=32
      AND sl.METOD_HMP IN (83,84)	
      --and sa.id is null	
      --and podr is null	
     --group by sch.month,sl.VID_HMP ,v018.[HVIDNAME]	
      --order by sch.month,sl.VID_HMP ,v018.[HVIDNAME]