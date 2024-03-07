 SELECT distinct   sch.id AS schit,sch.SchetType, zs.id zslid, sumv, rslt, s.DS_ONK
 	,p.id pid,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2--, s.nhistory,s.ds1,ksg.n_ksg,zs.vidpom,s.podr,k.name

 	--, zs.sumv,zs.usl_ok
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
 --into ztemp_desh_Cdelete_072021_ks
 --into ztemp_desh_Cdelete_052021_ds_2
 -- into ztemp_desh_Cdelete_072021_ds                           select * from  ztemp_desh_Cdelete_072021_ds
 --  into ztemp_desh_Cdelete_102021_ds_16
 --   into ztemp_desh_Cdelete_102021_ds_52
 --  into ztemp_desh_Cdelete_102021_ks_c_7
 --  into ztemp_desh_Cdelete_102021_ks_new_1
 --  into ztemp_desh_Cdelete_102021_ds_new_1
 --  into ztemp_desh_Cdelete_112021_ks_377
 -- into ztemp_desh_Cdelete_112021_ks_314
 --  into ztemp_desh_Cdelete_112021_ds_240
 --  into ztemp_desh_Cdelete_112021_ds_40
 -- into ztemp_desh_Cdelete_112021_ds_11
 -- into ztemp_desh_Cdelete_112021_kt_445
 --into ztemp_desh_Cdelete_112021_mrt_500
 INTO ztemp_desh_Cdelete_122021_ds_500
 FROM [D3_SCHET_OMS] sch                  
   inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  AND sch.month=11 AND sch.YEAR=2021 and  sch.id IN (3551)
   inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID
				
join d3_usl_oms usl on usl.D3_SLID=s.id	

  LEFT JOIN v012 v12 ON v12.id=zs.ishod
  LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
  left join KOKOD_OTD k on k.kod_otd=s.podr
 
 WHERE  zs.usl_ok=3 --AND code_usl LIKE 'R01.001.002.001'
-- --R01.001.001.001 --кт
-- R01.001.002.001--мрт