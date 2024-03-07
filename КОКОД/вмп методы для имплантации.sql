SELECT distinct  sl.metod_hmp,v037.code, v037.[NAME]
      ,[Parameter]
      ,[COMMENT],sl.podr,sl.IDDOKT,	kp.fam+' '+kp.im+' '+kp.ot,
--sch.month, sl.nhistory, sl.metod_hmp, sl.podr--,sl.VID_HMP ,v018.[HVIDNAME],	
count(zs.id) [количество]    	
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
	left join v018 on v018.[IDHVID]=sl.VID_HMP and sl.date_2 between v018.datebeg and isnull(v018.DATEEND, '20211231')
	LEFT JOIN v037 ON v037.code=sl.METOD_HMP
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
	
  where sch.code_mo=460061   	
        and sch.year=2021 --AND sch.month=11  	
      and zs.vidpom=32
     -- AND sl.METOD_HMP IN (1080, 1081)	
      --and sa.id is null	
      and v037.CODE IS NOT null
     group by sl.metod_hmp,v037.code, v037.[NAME]
      ,[Parameter]
      ,[COMMENT]	
	  ,sl.podr
	 ,sl.IDDOKT
      ,	kp.fam+' '+kp.im+' '+kp.ot
ORDER BY count(zs.id) desc