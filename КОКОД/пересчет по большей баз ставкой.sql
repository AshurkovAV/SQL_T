Select sch.month,sch.id AS schit,sch.[NSCHET], zs.id zslid

,ks.n_ksg,v23.NameWithID
 , s.sum_m ,zs.sumv,zs.usl_ok
 ,round (convert(numeric(12,2),bt.BZTSZ) * ks.KOEF_Z *( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*isnull(case when calc.up is not null then 1 else ks.koef_up end,1)* 
CASE WHEN zs.usl_ok=2 or calc.up is not null THEN 1.00  ELSE ISNULL(ks.KOEF_U,1.00) END  * ks.KOEF_D) +convert(numeric(12,2),bt.BZTSZ)* 
ks.KOEF_D  * case when isnull(ks.IT_SL,0)=0 then 0 else ks.IT_SL end ,2) [now]

 ,round (convert(numeric(12,2),case when zs.usl_ok=1 then 24255 else 13915 end) * ks.KOEF_Z *( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*isnull(case when calc.up is not null then 1 else ks.koef_up end,1)* 
CASE WHEN zs.usl_ok=2 or calc.up is not null THEN 1.00  ELSE ISNULL(ks.KOEF_U,1.00) END  * ks.KOEF_D) +convert(numeric(12,2),case when zs.usl_ok=1 then 24255 else 13915 end)* 
ks.KOEF_D  * case when isnull(ks.IT_SL,0)=0 then 0 else ks.IT_SL end ,2) [future]



FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1,2) --AND p.smo=46006
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
 JOIN D3_KSG_KPG_OMS AS ks ON ks.D3_SLID=s.id
LEFT JOIN d3_sank_oms sa ON sa.D3_ZSLID=zs.id AND sa.S_TIP=1
left join KOKOD_OTD k on k.kod_otd=s.podr
 left JOIN v023 v23 ON v23.K_KSG=ks.N_KSG  AND s.DATE_2 between v23.DATEBEG AND  isnull(v23.DATEend ,'20221231') --AND year(v23.DATEBEG)>=2019
 left join [CalcKsg] calc on calc.K_KSG=ks.N_KSG and s.DATE_2 between calc.DATEBEG and isnull(calc.DATEEND,'20991231')
left join SprBZTSZ bt on bt.USL_OK=zs.usl_ok and s.DATE_2 between bt.DBEG and bt.DEND
WHERE   --sch.id IN (1751,1747,1746)-- and zs.pr_nov=0-- AND  --AND zs.DATE_Z_2 BETWEEN '20200914' AND '20200920'  AND 

						 sch.year=2022 and sch.id in  (

                      Select 
						--sch.month,nschet,
						id

						FROM [D3_SCHET_OMS] sch  
						WHERE YEAR=2022 AND sch.month=1  AND nschet LIKE '%сдан%')
AND  sum_m<>0