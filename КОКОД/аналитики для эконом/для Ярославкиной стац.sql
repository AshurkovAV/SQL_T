--BEGIN TRAN
--UPDATE zs SET for_pom=1
--commit tran




SELECT DISTINCT  sch.month,sch.id AS schit,sch.[NSCHET],case when p.smo like '46%' then p.smo else '46' end as [Плательщик], zs.id zslid, zs.FOR_POM
,s.podr
,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis
,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,case when zs.VIDPOM=32 then 'ВМП' ELSE 'КСГ' end names,		ksg.n_ksg,v23.NameWithID--, cr.CRIT
                                                     , zs.ishod,v12.IZNAME,v009.NameWithID v9, s.sum_m ,zs.sumv,zs.usl_ok, kd_z [койко-дни зак сл], kd [койко-дни случ], month(date_z_2) [месяц лечения]
                                                     , zs.PR_NOV
                                                     
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --AND sch.month=8 
 --AND sch.YEAR=2021  and  sch.month=9 and   sch.id in (3125)--,3121,3117)
 and sch.id in  (Select 
--sch.month,nschet,
id

FROM [D3_SCHET_OMS] sch  
WHERE YEAR=2023  AND sch.month=12 and   sch.id in (17339,17386,17389,17390)
)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 left JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 LEFT JOIN D3_CRIT_OMS cr ON cr.D3_KSGID=ksg.ID
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND s.DATE_2 between v23.DATEBEG AND  isnull(v23.DATEend ,'20231231')
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
where  zs.usl_ok in (1,2) --AND s.podr LIKE '460061106013' --AND (ksg.N_KSG LIKE 'st19.090' OR ksg.N_KSG LIKE 'st36.012')
ORDER BY dr desc