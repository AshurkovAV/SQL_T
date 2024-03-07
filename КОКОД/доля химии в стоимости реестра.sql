SELECT distinct year, month,schettype,nschet,zs.usl_ok, sum(sumv) as [summs himia]
--, k.name
--, lek.code_sh--,  v024.DKKNAME 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  --and sch.year=2021 
  --and sch.id in --(2230, 2091, 2001, 1639, 2211, 2010, 1753, 1586)
  --(1585, 1586, 1747, 1753, 2021, 2010, 2230, 2211,2384)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
 --left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 		
	--			on sank.[D3_ZSLID]=zs.id
	--			and sank.s_tip=1
 -- LEFT JOIN v024 ON v024.IDDKK=lek.CODE_SH AND date_z_2 between v024.datebeg and isnull(v024.[DATEEND],'20211231')
 left join KOKOD_OTD k on k.kod_otd=s.podr
where sch.id in (1639, 1641, 1638, 1586, 2001, 2002, 2003, 1753, 2091, 2084, 2086, 2010, 2314, 2313, 2312, 2211,2429, 2428, 2427, 2430) and year(date_z_2)=2021
group by year,month,schettype,zs.usl_ok,nschet
order by year,month,zs.usl_ok--,code_sh