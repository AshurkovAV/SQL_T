SELECT DISTINCT  sch.month,sch.id AS schit,sch.[NSCHET], zs.id zslid
,s.podr
,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis
,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,v23.NameWithID, zs.ishod,v12.IZNAME,v009.NameWithID v9, s.sum_m ,zs.sumv,zs.usl_ok

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 AND sch.month=7-- and sch.id in (2227,2230,2231)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
where zs.id in (SELECT DISTINCT zs.id--,count (*),count(s.podr),count(distinct s.podr)
--sch.month,sch.id AS schit,sch.[NSCHET], zs.id zslid--s.id
--,s.podr
--,k.name
--,p.fam,p.im,p.ot,p.dr, p.npolis
--,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory--,s.ds1--,ksg.n_ksg,v23.NameWithID, zs.ishod,v12.IZNAME,v009.NameWithID v9, s.sum_m ,zs.sumv,zs.usl_ok

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 AND sch.month=7
  -- and sch.id in (2313,2314)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
--where fam like 'Костюченков'

group by sch.month, zs.id 
having count (*)>1 and count(s.podr)<>count(distinct s.podr)
)
order by zs.id

--where s.podr like '460061106004'
--where zs.usl_ok in (1,2)
--WHERE zs.RSLT<>105 and 
--(zs.sumv<27000 and zs.usl_ok=1 or zs.sumv<15000 and zs.usl_ok=2)



--SELECT DISTINCT  sch.id AS schit,sch.SchetType, zs.id zslid,s.podr
--,k.name
--,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,s.METOD_HMP,zs.vidpom, zs.ishod,v12.IZNAME,v009.NameWithID v9, zs.sumv,zs.usl_ok

--FROM [D3_SCHET_OMS] sch                  
--  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
--  and sch.year=2020 and sch.month=10 AND sch.code_mo=460061 --AND sch.id IN (1088,1084,1087)
--  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) AND zs.vidpom=32 --AND zs.id=20906231
-- join D3_SL_OMS s on s.D3_ZSLID=zs.ID
-- --JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
-- --left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
-- LEFT JOIN v012 v12 ON v12.id=zs.ishod
-- LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
--left join KOKOD_OTD k on k.kod_otd=s.podr
--where s.podr like '460061106004'