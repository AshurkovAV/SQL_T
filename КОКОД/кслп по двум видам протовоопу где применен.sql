SELECT DISTINCT  sch.id AS schit,sch.SchetType, zs.id zslid,s.podr
,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,zs.vidpom,v23.NameWithID, zs.ishod,v12.IZNAME,v009.NameWithID v9, zs.sumv,zs.usl_ok, usl.VID_VME,u.name,cr.crit
,ksg.it_sl,koef.IDSL,koef.z_sl,spr.[USLKOEF]
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 AND sch.code_mo=460061 AND sch.month=9--AND sch.id IN (688,686)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 LEFT JOIN D3_CRIT_OMS AS cr ON cr.D3_KSGID=ksg.id
left JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u on u.id=usl.vid_vme
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
left join D3_SL_KOEF_OMS koef on koef.D3_KSGID=ksg.id
left join [SprKSLP] spr on spr.[IDSL]=koef.idsl
where koef.IDSL in (81)
ORDER BY p.npolis,zs.DATE_Z_1