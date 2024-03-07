	WITH cons AS (										
	select DISTINCT 
	p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) npolis,									
	--cast (zsl.USL_OK as nvarchar)+ ' '+v6.UMPNAME usl_ok,										
	min(cast(sl.DATE_1 as date)) DATE_1	
								
	FROM [D3_SCHET_OMS] sch                  										
left join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id											
left join v006 v6 on v6.IDUMP=zsl.USL_OK											
										
--SL---------------------------------------------------------------------											
left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID											
--left join v025 v25 on v25.IDPC=sl.P_CEL25											
left join v002 v2 on v2.IDPR=sl.PROFIL and sl.DATE_2 between v2.DATEBEG and isnull(v2.DATEEND,'20991231')											
--left join D3_NAPR_OMS napr on napr.D3_SLID=Sl.id 											
join D3_CONS_OMS cons on cons.d3_slid=sl.id 	AND cons.PR_CONS<>0										
--left join D3_NAZ_OMS Naz on Naz.D3_SLID=sl.ID											
left join M001_oplata_status m on m.idds=sl.ds1 --and m.ACTUAL=1											
		where 					
			 date_z_2 BETWEEN '20220101' AND '20221231'	
			and zsl.usl_ok in (3)	
			AND zsl.os_sluch_region=40							
								
			and sch.code_mo='460061'								
			
	group  BY p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) 
	      )	
      
      
SELECT t1.*, t2.DATE_1 [дата консилиума],  DATEDIFF(dd,t1.date_min,t2.DATE_1) [разность дней между первой явкой и консилиумом],
             t3.date_z_1 [дата госпитазации], DATEDIFF(dd,t1.date_min,t3.date_Z_1) [разность дней между первым приемом и госпитализацией]                    
FROM temp_pervich_app_2022_3 t1
LEFT JOIN cons t2 ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)	
LEFT JOIN (	--stac
	       select DISTINCT 
						p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) npolis,									
						--cast (zsl.USL_OK as nvarchar)+ ' '+v6.UMPNAME usl_ok,										
						min(cast(zsl.DATE_z_1 as date)) DATE_z_1--cast(sl.DATE_2 as date)DATE_2,										
											
								
			FROM [D3_SCHET_OMS] sch                  										
			left join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
			left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id	and zsl.usl_ok in (1,2)										
			group by  p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) 
           	
	      ) t3 ON t3.npolis = t1.npolis OR (t3.fam = t1.fam AND t3.im=t1.im AND t1.ot=t3.ot AND t1.dr=t3.dr)	

ORDER BY t1.npolis