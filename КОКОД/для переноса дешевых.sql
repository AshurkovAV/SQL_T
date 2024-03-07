--SELECT *
-- from
--(
	SELECT DISTINCT sch.id AS schit,sch.SchetType, zs.id zslid,  rslt, ds_onk
	,p.id pid
	--,s.podr,k.name,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,zs.vidpom
	--,v23.NameWithID, zs.ishod,v12.IZNAME,v009.NameWithID v9
	, zs.sumv,zs.usl_ok
--into ztemp_desh_Cdelete_092020_dn
--into ztemp_desh_Cdelete_092020_ks_33
--into ztemp_desh_Cdelete_092020_ks_50
--into ztemp_desh_Cdelete_092020_ks_70
--into ztemp_desh_Cdelete_102020
--into ztemp_desh_Cdelete_112020_new
--into ztemp_desh_Cdelete_012021
--into ztemp_desh_Cdelete_022021
--into ztemp_desh_Cdelete_032021
--into ztemp_desh_Cdelete_042021
--into ztemp_desh_Cdelete_042021_ks_37
--into ztemp_desh_Cdelete_042021_ks_7_new
--into ztemp_desh_Cdelete_052021_ks_29
--into ztemp_desh_Cdelete_052021_ds_2
--into ztemp_desh_Cdelete_062021_ds
--into ztemp_desh_Cdelete_062021_ds_4 
--into ztemp_desh_Cdelete_062021_ds_36
 
 --into ztemp_desh_Cdelete_062021_ks
  --into ztemp_desh_Cdelete_062021_ks_3
   --into ztemp_desh_Cdelete_082021_ks
  --  into ztemp_desh_Cdelete_082021_ds
 -- into ztemp_desh_Cdelete_082021_ds_53
  --into ztemp_desh_Cdelete_082021_ks_1
   --into ztemp_desh_Cdelete_092021_ks
    --into ztemp_desh_Cdelete_092021_ks_112
    -- into ztemp_desh_Cdelete_092021_ds
    --into ztemp_desh_Cdelete_092021_ds_175
 -- into ztemp_desh_Cdelete_032022_ds_10
 -- into ztemp_desh_Cdelete_052022_ks_312
  --into ztemp_desh_Cdelete_052022_ds_244
    --into ztemp_desh_Cdelete_052022_ds_80
     -- into ztemp_desh_Cdelete_072022_ks_347
     -- into ztemp_desh_Cdelete_072022_ds_274
      -- into ztemp_desh_Cdelete_082022_ks_386
      --  into ztemp_desh_Cdelete_082022_ks_401
      --  into ztemp_desh_Cdelete_082022_ks_15
         --into ztemp_desh_Cdelete_082022_ds_290
       --  into ztemp_desh_Cdelete_082022_ds_158
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --AND sch.month=6 AND sch.YEAR=2021 and  sch.id in (2610,2612,2615,2639)
  --AND sch.month=8 
 AND sch.YEAR=2022  AND sch.id in (6850,7067)--(3121,3122,3117)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
 left join KOKOD_OTD k on k.kod_otd=s.podr
--WHERE  zs.usl_ok=2 AND zs.sumv<16792.27 and  zs.RSLT<>105 ----!!! 108 +4 за 16792.27
--WHERE  zs.usl_ok=2 AND zs.sumv=16792.27 and  zs.RSLT<>105
--WHERE  zs.usl_ok=2 AND zs.sumv>=19130.43 and  zs.RSLT<>105 ----!!! 36  переносим в онкореестр
	--WHERE  zs.usl_ok=2 --AND zs.VIDPOM<>32
--	AND zs.sumv=6818.65-- AND zs.PR_NOV=0
--AND sch.id=8442
	--and  zs.RSLT<>105 --AND ds_onk IS NOT null
	--ORDER BY sumv
	--
	--
	----select * from  ztemp_desh_Cdelete_082022_ks_15