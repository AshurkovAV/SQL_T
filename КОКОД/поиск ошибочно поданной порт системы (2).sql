SELECT DISTINCT  sch.id AS schit,sch.SchetType, zs.id zslid
--,s.podr
--,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2
--, s.nhistory,s.ds1,ksg.n_ksg,v23.NameWithID
,zs.vidpom, zs.ishod,v12.IZNAME,v009.NameWithID v9, zs.sumv,zs.usl_ok

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=10-- AND sch.code_mo=460061 AND sch.id IN (502)-- (495,486)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
 left join KOKOD_OTD k on k.kod_otd=s.podr
WHERE zs.id IN ( SELECT DISTINCT   zs.id

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=10-- AND sch.code_mo=460061 AND sch.id IN (502)-- (495,486)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
WHERE zs.usl_ok IN (1,2)
GROUP BY sch.id,sch.SchetType, zs.id 
HAVING COUNT(*)>1
)
GROUP BY sch.id,sch.SchetType, zs.id
--,s.podr
--,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2,zs.vidpom, zs.ishod,v12.IZNAME,v009.NameWithID , zs.sumv,zs.usl_ok
HAVING SUM(CASE WHEN ksg.n_ksg LIKE 'st19.038' THEN 1 ELSE 0 END)=0