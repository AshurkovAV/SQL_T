 
 --UPDATE KsgKpg SET SL_K=1 --добавляем признак использования кслп
 
 --вставляем новый критерий SUPT%
 
 --INSERT INTO [D3_CRIT_OMS] ( 
 --     [D3_KSGID]
 --     ,[D3_KSGGID]
 --     ,[CRIT])
 --SELECT DISTINCT  ksgkpg.id, KsgKpg.KSG_ID,'supt05'
 
 --вставляем кслп
 
 --INSERT INTO [D3_SL_KOEF_OMS] (
 --     [D3_KSGID]
 --     ,[D3_KSGGID]
 --     ,[IDSL]
 --     ,[Z_SL])
 
 --SELECT DISTINCT  ksgkpg.id, KsgKpg.KSG_ID,'3131',1.2
 
 --увеличиваем стоимость на величину БС*1.2=16698.74
 
-- UPDATE zsl SET zsl.sumv=zsl.sumv+16698.74
--UPDATE zsl SET zsl.sumv=4230.35
--UPDATE sl SET sl.sum_m=sl.sum_m+16698.74
--UPDATE sl SET sl.sum_m=4230.35
--UPDATE sl SET sl.tarif=sl.sum_m
--UPDATE sl SET sl.tarif=21151.74
 
 --SELECT sl.nhistory,	sl.podr, p.fam,zsl.date_z_1	, sl.P_PER, sum_m,sl.tarif,sumv, v12.IZNAME, v9.RMPNAME,Crit.id, Crit.CRIT, KsgKpg.SL_K,SlKoef.IDSL,SlKoef.Z_SL	, sl.KD	, KsgKpg.N_KSG				
	FROM [D3_SCHET_OMS] sch                  										
 join D3_PACIENT_OMS p on p.d3_scid=sch.id 									
								
join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id																					
join v009 v9 on v9.IDRMP=zsl.RSLT											
join v012 v12 on v12.id=zsl.ISHOD											
--SL---------------------------------------------------------------------											
join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID											
										
----OnkSl---------------------------------------------											
join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 											
										
join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 											
									
--join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 											
--left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and sl.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')											
 join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id											
 join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')											
											
left join D3_SL_KOEF_OMS SlKoef on SlKoef.D3_KSGID=KsgKpg.ID											
join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id											
--left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')											
 WHERE nhistory IN ('486/00486','185/00185','633/00633' ,'365/00365','227/00227')
 AND podr LIKE '460061206014'
 AND KsgKpg.N_KSG  LIKE '%36.006'
  and sch.id=9382