--âìï
select distinct sch.month,sch.year,sl.podr
,k.name, case when zs.VIDPOM=32 then 'ÂÌÏ' ELSE 'ÊÑÃ' end names,sl.nhistory,sl.SUM_M,sl.VID_HMP ,v019.NameWithID	, usl.CODE_USL, y.Name, v23.NameWithID, sl.SUM_M
  	
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
    left join d3_usl_oms usl on usl.D3_SLID=sl.id	
    left join Yamed_Spr_UslCode y on y.ID=usl.code_usl	 
	left join v019 on v019.IDHM=sl.METOD_HMP and sl.date_2 between v019.datebeg and isnull(v019.DATEEND, '20231231')
	left join KOKOD_OTD k on k.kod_otd=sl.podr
	LEFT JOIN D3_KSG_KPG_OMS ksg ON ksg.D3_SLID=sl.ID
	left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND sl.DATE_2 between v23.DATEBEG AND  isnull(v23.DATEend ,'20231231')
  where sch.code_mo=460061   	
        and (sch.year=2023 )--AND sch.month=11)  	
      AND zs.VIDPOM=32
      --and sa.id is null	
      and sl.podr='460061106001'	
    -- group by sch.month,sl.VID_HMP ,v018.[HVIDNAME]	
   AND usl.code_usl NOT LIKE 'A08%'
      order by sch.month,sl.nhistory--sl.VID_HMP ,v018.[HVIDNAME]
     
  --êñã
     
   --âìï
select distinct sch.month,sch.year,sl.podr
,k.name, case when zs.VIDPOM=32 then 'ÂÌÏ' ELSE 'ÊÑÃ' end names,sl.nhistory,sl.SUM_M,sl.VID_HMP ,v019.NameWithID	, usl.CODE_USL, y.Name, v23.NameWithID
, CASE WHEN k1.nksg IS NOT NULL THEN 1 ELSE 0 END pr_ksg
  	
	
FROM [D3_SCHET_OMS] sch    	
    inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]	
    	
    inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]	
    inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]	
    join d3_usl_oms usl on usl.D3_SLID=sl.id	
    left join Yamed_Spr_UslCode y on y.ID=usl.code_usl	 
	left join v019 on v019.IDHM=sl.METOD_HMP and sl.date_2 between v019.datebeg and isnull(v019.DATEEND, '20231231')
	left join KOKOD_OTD k on k.kod_otd=sl.podr
	LEFT JOIN D3_KSG_KPG_OMS ksg ON ksg.D3_SLID=sl.ID
	left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND sl.DATE_2 between v23.DATEBEG AND  isnull(v23.DATEend ,'20231231')
	 JOIN (SELECT DISTINCT usl, nksg 
	           FROM SprKSGDecode AS sk 
	           where YEAR(dbeg)=2023 
	           AND YEAR(dend)=2023 
	           AND usl IS NOT NULL 
	           AND  nksg LIKE 'st%') k1 ON k1.usl=usl.CODE_USL AND k1.nksg=v23.K_KSG
  where sch.code_mo=460061   	
        and (sch.year=2023 )--AND sch.month=11)  	
      AND zs.VIDPOM!=32
      --and sa.id is null	
      and sl.podr='460061106001'	
      
    -- group by sch.month,sl.VID_HMP ,v018.[HVIDNAME]	
  
      order by sch.month,sl.nhistory--sl.VID_HMP ,v018.[HVIDNAME]  
   
   
    
   SELECT DISTINCT usl, nksg FROM SprKSGDecode AS sk where YEAR(dbeg)=2023 AND YEAR(dend)=2023 AND usl IS NOT NULL AND  nksg LIKE 'st%'