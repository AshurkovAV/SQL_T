
											
	select DISTINCT k.name	,nhistory,zsl.USL_OK,p.NPOLIS, sch.[MONTH]
									
	FROM [D3_SCHET_OMS] sch                  										
left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id	
left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID											
left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id												
----OnkSl---------------------------------------------											
left join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 											
							
left join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 											
left join KOKOD_OTD k on k.kod_otd=sl.podr	
		where YEAR=2023	
			AND sch.month=10		
			and zsl.usl_ok in (1,2)								
										
			and sch.code_mo='460061'								
		 AND OnkSl.id is NULL AND (sl.VID_HMP IS NOT NULL OR KsgKpg.N_KSG LIKE 'st19%' OR KsgKpg.N_KSG LIKE 'ds19%')
	ORDER BY k.name	
    
