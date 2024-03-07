select   v018.[HVIDNAME], sl.VID_HMP ,v019.[HMNAME],sl.METOD_HMP,ds1,
 count(zs.id) [количество]    	
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
	left join[V019] v019 on cast(v019.IDHM as int)=sl.metod_hmp  											
				   --------------------------------с 21 года----------------							
				                              and 							
											cast(case when year(zs.date_z_2)=2020 then v019.IDMODP else  sl.MP_HMP end as nvarchar) =cast(v019.IDMODP as nvarchar)
											and sl.VID_HMP=HVID
											-- метод ВМП-- метод ВМП
									   AND zs.DATE_z_2>=v019.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v019.dateend,'21000101')		
				   left join v018 v018 on v019.HVID=V018.idhvid                                 -- вид ВМП							
									   AND zs.DATE_z_2>=V018.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v018.dateend,'21000101')	
	--left join KOKOD_OTD k on k.kod_otd=sl.podr
  where sch.code_mo=460061   	
        and (sch.year=2022 )--AND sch.month=11)  	
      and zs.vidpom=32	
	  and zs.PR_NOV=0
      --and sa.id is null	
      --and podr is null	
      group by v018.[HVIDNAME],sl.VID_HMP ,v019.[HMNAME],sl.METOD_HMP,ds1, 
      order by v018.[HVIDNAME],sl.VID_HMP ,v019.[HMNAME],sl.METOD_HMP,ds1