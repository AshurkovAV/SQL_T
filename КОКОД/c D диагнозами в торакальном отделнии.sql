
DECLARE @StartDate DATE, @EndDate DATE

SET @StartDate = '2021-03-01'

SET @EndDate = '2021-05-31'
SELECT DISTINCT s.nhistory,ds1, s.DS_ONK,p.fam, p.im,p.ot, p.dr,date_1, date_2, usl.CODE_USL

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --AND sch.month=8 
 AND sch.YEAR=2021  
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 LEFT JOIN D3_USL_OMS usl ON usl.D3_SLID = s.ID
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
where  zs.usl_ok in (1,2)
			AND s.PODr IN ('460061106004')
			AND ((s.DATE_1<=@StartDate AND  s.DATE_2  between @StartDate and @EndDate)
			     OR 
			     (s.DATE_1  between @StartDate and @EndDate AND  s.DATE_2  between @StartDate and @EndDate)
			   OR 
			     (s.DATE_1 <= @StartDate and s.DATE_2 >=@EndDate)  
			     	   OR 
			     (s.DATE_1 between @StartDate and @EndDate and s.DATE_2 >=@EndDate) 
			)
			AND ds1 LIKE 'D%' 
ORDER BY date_1, s.NHISTORY
			