--BEGIN TRAN
--UPDATE zs SET for_pom=1
--commit tran




SELECT DISTINCT  sch.month,sch.id AS schit,sch.[NSCHET], zs.id zslid, zs.FOR_POM
,s.podr
,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis
,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,v23.NameWithID, cr.CRIT
                                                     , zs.ishod,v12.IZNAME,v009.NameWithID v9, s.sum_m ,zs.sumv,zs.usl_ok, kd,kd_z

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --AND sch.month=8 
 --AND sch.YEAR=2021  and  sch.month=9 and   sch.id in (3125)--,3121,3117)
 and sch.id in  (Select 
--sch.month,nschet,
id

FROM [D3_SCHET_OMS] sch  
WHERE (YEAR=2021  AND sch.month=12 or  
 sch.id in (3748,3749))
)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
LEFT JOIN D3_CRIT_OMS AS cr ON cr.D3_KSGID=ksg.ID
where  zs.usl_ok in (1,2) AND s.podr LIKE '460061106031' AND crit IS null
--AND p.NPOLIS LIKE '4652040840000052'