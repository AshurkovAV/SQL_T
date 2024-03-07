SELECT distinct year, zs.usl_ok
--, k.name
, lek.code_sh--,  v024.DKKNAME 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  --and sch.year=2021 
  --and sch.id in --(2230, 2091, 2001, 1639, 2211, 2010, 1753, 1586)
  --(1585, 1586, 1747, 1753, 2021, 2010, 2230, 2211,2384)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 ,
JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
 -- LEFT JOIN v024 ON v024.IDDKK=lek.CODE_SH AND date_z_2 between v024.datebeg and isnull(v024.[DATEEND],'20211231')
 left join KOKOD_OTD k on k.kod_otd=s.podr
where sch.year>=2021 and s.podr like '460061206014'
order by year,usl_ok,code_sh
--group by month,s.podr

-- !!!!!!!!!!!

SELECT distinct s.podr,k.name,  lek.code_sh,  v024.DKKNAME 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 
  --and sch.id in --(2230, 2091, 2001, 1639, 2211, 2010, 1753, 1586)
  --(1585, 1586, 1747, 1753, 2021, 2010, 2230, 2211,2384)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
  LEFT JOIN v024 ON v024.IDDKK=lek.CODE_SH AND v024.[DATEEND]	IS null	
  left join KOKOD_OTD k on k.kod_otd=s.podr