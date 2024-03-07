SELECT DISTINCT  sch.month,sch.id AS schit,sch.[NSCHET], zs.id zslid
,s.podr
,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis
,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,v23.NameWithID
                                                   , zs.ishod,v12.IZNAME,v009.NameWithID v9, s.sum_m ,zs.sumv,crit, y.NameWithID, n20.MNN

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --AND sch.month=8 
 --AND sch.YEAR=2021  and  sch.month=9 and   sch.id in (3125)--,3121,3117)
 and sch.id in  (Select 
						--sch.month,nschet
						id

						FROM [D3_SCHET_OMS] sch  
						WHERE YEAR=2022 and   sch.id in (4071,4072)
)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 LEFT join d3_usl_oms usl on usl.D3_SLID=s.id
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN D3_CRIT_OMS AS crit
          ON crit.D3_KSGID = ksg.ID
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG  AND s.DATE_2 between v23.DATEBEG AND  isnull(v23.DATEend ,'20221231') --AND year(v23.DATEBEG)>=2019
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
LEFT JOIN Yamed_Spr_Usl804 AS y ON y.ID=usl.CODE_USL
left join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=s.id 									
								
left join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 											
left join N013 n013 on n013.id_tlech=Onkusl.usl_tip											
left join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 											
left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and s.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')	

where  zs.usl_ok in (1) 
        AND (crit.CRIT LIKE 'fr21%' OR crit.CRIT LIKE 'fr30%' or crit.CRIT LIKE 'fr33%') 
        AND code_usl LIKE 'A07%'