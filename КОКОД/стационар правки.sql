
 --UPDATE zsl SET zsl.date_z_1='20221228',zsl.date_z_2='20230120'
--UPDATE zsl SET zsl.sumv=4230.35
--UPDATE sl SET sl.date_1='20221231',sl.date_2='20230120'
--UPDATE sl SET sl.sum_m=4230.35
--UPDATE sl SET sl.tarif=sl.sum_m
--UPDATE sl SET sl.tarif=21151.74
 --UPDATE usl SET usl.DATE_IN='20221231',usl.DATE_OUT='20221231'
 --UPDATE KsgKpg SET KsgKpg.N_KSG='st19.110'
 
 --UPDATE KsgKpg SET KsgKpg.koef_up=1, koef_z=2.68

 --UPDATE LekPr SET LekPr.date_inj='29.12.2022'
 --update onksl set onksl.wei=97,hei=172,bsa=2.15

 SELECT sl.nhistory,zsl.id, zsl.DATE_Z_1,zsl.DATE_Z_2,sl.id, sl.DATE_1,sl.date_2, KsgKpg.N_KSG	,v23.N_KSG, usl.id--, usl.code_usl,usl.DATE_IN, usl.DATE_OUT ,
 ,sl.podr, p.fam,zsl.date_z_1, 
 --sl.P_PER, sum_m,sl.tarif,sumv, v12.IZNAME, v9.RMPNAME,Crit.id, Crit.CRIT	, sl.KD	, KsgKpg.N_KSG		
onksl.*		
	FROM [D3_SCHET_OMS] sch                  										
 join D3_PACIENT_OMS p on p.d3_scid=sch.id 									
								
join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id																					
join v009 v9 on v9.IDRMP=zsl.RSLT											
join v012 v12 on v12.id=zsl.ISHOD											
--SL---------------------------------------------------------------------											
join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID			
LEFT JOIN D3_USL_OMS AS usl ON usl.D3_SLID=sl.id								
										
----OnkSl---------------------------------------------											
join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 											
										
join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 											
									
 --join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 											
--left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and sl.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')											
 join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id											
  join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')										
											
--left join D3_SL_KOEF_OMS SlKoef on SlKoef.D3_KSGID=KsgKpg.ID											
left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id											
--left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')											
 WHERE sch.id=9382 AND sl.id=19240038
 --AND usl.
  --and sch.id=9382