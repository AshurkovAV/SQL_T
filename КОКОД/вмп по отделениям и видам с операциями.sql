--это первая выборка без услуг


select distinct sch.month,sl.podr
,k.name, sl.nhistory,sl.VID_HMP ,v018.[HVIDNAME]	
 --count(zs.id) [количество]    	
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
	left join v018 on v018.[IDHVID]=sl.VID_HMP and sl.date_2 between v018.datebeg and isnull(v018.DATEEND, '20211231')
	left join KOKOD_OTD k on k.kod_otd=sl.podr
  where sch.code_mo=460061   	
        and (sch.year=2021 )--AND sch.month=11)  	
      and zs.vidpom=32	
      --and sa.id is null	
      --and podr is null	
    -- group by sch.month,sl.VID_HMP ,v018.[HVIDNAME]	
      order by sch.month--,sl.VID_HMP ,v018.[HVIDNAME]
      
    --тут закончилась первая выборка
    --
    --начинается вторая  
      
      
      --c usl
      select distinct sch.month,sl.podr
,k.name, sl.nhistory,sl.VID_HMP ,v018.[HVIDNAME]	, usl.CODE_USL, y.Name
 --count(zs.id) [количество]    	
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
   left join d3_usl_oms usl on usl.D3_SLID=sl.id	

left join Yamed_Spr_UslCode y on y.ID=usl.code_usl	 
	left join v018 on v018.[IDHVID]=sl.VID_HMP and sl.date_2 between v018.datebeg and isnull(v018.DATEEND, '20211231')
	left join KOKOD_OTD k on k.kod_otd=sl.podr
  where sch.code_mo=460061   	
        and (sch.year=2021 )--AND sch.month=11)  	
      and zs.vidpom=32	
      --and sa.id is null	
      --and podr is null	
    -- group by sch.month,sl.VID_HMP ,v018.[HVIDNAME]	
      order by sch.month,sl.nhistory--sl.VID_HMP ,v018.[HVIDNAME]
      
      --кончилась вторая