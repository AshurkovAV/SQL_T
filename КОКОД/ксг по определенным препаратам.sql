
select distinct s.nhistory, 
               KsgKpg.n_ksg,
               v23.N_KSG
               ,lek.CODE_SH,v024.DKKNAME
               --sumv [сцмма выставленная]
               , t2.now
               --case when kd<4 then ROUND(sumv*0.2,2) ELSE ROUND(sumv*0.5,2) END sum_new
    FROM D3_ZSL_OMS zs  
            join D3_PACIENT_OMS p on p.id=zs.D3_PID  
            join [D3_SCHET_OMS] sch on sch.id=zs.D3_SCID and sch.CODE_MO=460061 and sch.YEAR=2022 
            join D3_SL_OMS s on s.D3_ZSLID=zs.ID
            left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID = s.id --КСГ --KsgKpg.n_ksg
                    
          
            left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
            left join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
            join D3_LEK_PR_OMS lek on lek.D3_ONKUSLID=ou.ID
              left join v023 v23 ON v23.K_KSG=KsgKpg.N_KSG  and s.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')	
               left  JOIN v024 ON v024.IDDKK=lek.CODE_SH   AND date_2 BETWEEN v024.DATEBEG and isnull(v024.DATEEND,'20991231')  
           
              left join v009 on v009.IDRMP=zs.RSLT
              join (
                    SELECT distinct 

                        [NKSG]
    
                        ,[DOP_KR]
  
                      FROM [SprKSGDecode]
                      where year(dbeg)=2022 
                        and dop_kr in (SELECT distinct [CODE_SH]
                                 FROM [N021]
                                 where  [ID_LEKP] IN ( 000246,--	Атезолизумаб
											             001691,--	Пембролизумаб
														 001554,--Ниволумаб
														 001038,--Ипилимумаб
														 002722,--Пролголимаб
									
														 002120,--Трастузумаб
														 002121,--Трастузумаб эмтанзин
														 000300,--Бевацизумаб
														 001705,--Пертузумаб
									                     002302, --Цетуксимаб
														 001653,--	Панитумумаб
														 000412)--Брентуксимаб ведотин) 
                                 and dateend is null)
                                 ) t on t.DOP_KR=lek.CODE_SH and KsgKpg.n_ksg=t.NKSG
    --   присоединяю стоимости ксг на текущий момент
	LEFT JOIN (SELECT distinct v23.[K_KSG]
						 ,round (convert(numeric(12,2),bt.BZTSZ) * v23.KOEF_Z *( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*isnull(case when calc.up is not null then 1 else upr.upr end,1)* 
					CASE WHEN v23.K_KSG LIKE 'ds%' or calc.up is not null THEN 1.00  ELSE ISNULL(upr.upr,1.00) END  * 1) +convert(numeric(12,2),bt.BZTSZ)* 
					1  * 0,2) [now]




					FROM  v023 v23    --AND year(v23.DATEBEG)>=2019
					 left join [CalcKsg] calc on calc.K_KSG=v23.[K_KSG] AND YEAR(calc.[DATEBEG])=2022
					left join SprBZTSZ bt on bt.USL_OK=case when v23.k_ksg like 'st%' then 1 else 2 END AND YEAR(bt.[DBEG])=2022
					LEFT JOIN [CalcUprk] upr ON upr.[IDKSG]=v23.K_KSG
					WHERE   --sch.id IN (1751,1747,1746)-- and zs.pr_nov=0-- AND  --AND zs.DATE_Z_2 BETWEEN '20200914' AND '20200920'  AND 

											 YEAR(v23.DATEBEG)=2022 
											 AND bt.DEND LIKE '2022-12-31')  t2 ON t2.K_KSG=KsgKpg.N_KSG              
WHERE date_z_2 BETWEEN '20220101' AND '20220630'       
       