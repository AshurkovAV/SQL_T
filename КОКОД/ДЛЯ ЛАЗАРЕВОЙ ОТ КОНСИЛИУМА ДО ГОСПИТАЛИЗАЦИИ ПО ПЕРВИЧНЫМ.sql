	WITH cons AS (										
	select DISTINCT 
	p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) npolis,									
	--cast (zsl.USL_OK as nvarchar)+ ' '+v6.UMPNAME usl_ok,										
	min(cast(sl.DATE_1 as date)) min_cons, max(cast(sl.DATE_1 as date)) max_cons
								
	FROM [D3_SCHET_OMS] sch                  										
  join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
  join temp_pervich_app_2022_10_12 t on t.npolis = p.npolis OR (t.fam = p.fam AND t.im=p.im AND t.ot=p.ot AND t.dr=p.dr)	
  join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id											

--SL---------------------------------------------------------------------											
 join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID											
											
--left join v002 v2 on v2.IDPR=sl.PROFIL and sl.DATE_2 between v2.DATEBEG and isnull(v2.DATEEND,'20991231')											
										
--join D3_CONS_OMS cons on cons.d3_slid=sl.id 	AND cons.PR_CONS<>0										
									
left join M001_oplata_status m on m.idds=sl.ds1									
		where 					
			 date_z_2 BETWEEN '20221001' AND '20221231'	
			and zsl.usl_ok in (3)	
			AND zsl.os_sluch_region=40							
								
			and sch.code_mo='460061'	
			--and sl.ds1 like 'C%'							
			
	group  BY p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) 
	      )	
      
      
SELECT t1.*, t2.min_cons [дата первого консилиума],  DATEDIFF(dd,t1.date_min,t2.min_cons) [разность дней между первой явкой и первым консилиумом],

t2.max_cons [дата последнего консилиума], t3.date_z_1 [дата первой госпитазации], DATEDIFF(dd,t2.max_cons ,t3.date_Z_1) [разность дней между послед консилиумом и госпитализацией]                    
FROM temp_pervich_app_2022_10_12 t1
LEFT JOIN cons t2 ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)	
LEFT JOIN (	--stac
	       select DISTINCT 
						p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) npolis,									
						--cast (zsl.USL_OK as nvarchar)+ ' '+v6.UMPNAME usl_ok,										
						min(cast(zsl.DATE_z_1 as date)) date_Z_1--[дата первой госпитализации]--cast(sl.DATE_2 as date)DATE_2,										
											
								
			FROM [D3_SCHET_OMS] sch                  										
			join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
			join temp_pervich_app_2022_10_12 t on t.npolis = p.npolis OR (t.fam = p.fam AND t.im=p.im AND t.ot=p.ot AND t.dr=p.dr)	
			 join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id	and zsl.usl_ok in (1,2)		
			 where 	 date_z_2 BETWEEN '20221001' AND '20221231'								
			group by  p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) 
           	
	      ) t3 ON t3.npolis = t1.npolis OR (t3.fam = t1.fam AND t3.im=t1.im AND t1.ot=t3.ot AND t1.dr=t3.dr)	

ORDER BY t1.npolis