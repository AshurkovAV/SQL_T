
--update sl set sl.MP_HMP=v019.[IDMODP]	
select	distinct zs.id	
--	--sch.year,sch.month,sl.podr,k.name
--	,sl.NHISTORY,sl.date_2--,sl.iddokt,zs.id	
,sl.METOD_HMP,sl.VID_HMP,v019.HVID,sl.MP_HMP,v019.[IDMODP]	

FROM [D3_SCHET_OMS] sch		
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
		
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		left join D3_SANK_OMS sa on sa.D3_ZSLID=zs.id and sa.s_tip=1
		left join KOKOD_OTD k on k.kod_otd=sl.podr
		left join v019 on v019.IDHM=sl.METOD_HMP and date_2 between v019.datebeg and isnull(v019.DATEEND,'20201231')
		left join v019 v19 on v19.IDHM=sl.METOD_HMP and date_2 between v19.datebeg and isnull(v19.DATEEND,'20201231') and charindex(ds1,v19.[DIAG])<>0
	where sch.code_mo=460061 	
	      and (sch.year=2021 AND sch.month=3)	
		  and zs.vidpom=32
		  and sl.MP_HMP is null
		  --and sa.id is null
		  --and podr is null
		-- group by sch.year,sch.month,sl.podr,k.name,sl.METOD_HMP--,sl.VID_HMP
		 -- order by sch.year,sch.month--,sl.podr
