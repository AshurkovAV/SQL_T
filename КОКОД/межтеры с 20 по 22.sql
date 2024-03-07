--42000, 66000,  29000,  70000,  15000, 46000,24000, 82000				
Select DISTINCT				
 sch.YEAR[Ãîä]	
 ,v006.UMPNAME	
 ,CASE 													
										WHEN s.P_CEL25='1.1' THEN 'ÍÅÎÒËÎÆÊÀ ÀÏÏ'			
										WHEN  ( (s.P_CEL25 LIKE '1%' AND s.P_CEL25 NOT LIKE '1.1')			
												OR 	s.P_CEL25 IN ('2.1','2.5','2.6')
												AND    zs.OS_SLUCH_REGION IS NULL	
												) OR	
												zs.OS_SLUCH_REGION in (29,35,48,23,12,18)  THEN 'ÏÐÎÔÈËÀÊÒÈÊÀ ÀÏÏ'	
										WHEN 			
										(s.P_CEL25 = '3.0' and OS_SLUCH_REGION is null)			
										or 			
										zs.OS_SLUCH_REGION in (21,30,31,32,33,34,36,39,40) 			
										OR 			
										(s.P_CEL25='2.3' AND usl.CODE_USL like 'R03%')			
											then 'ÇÀÁÎËÅÂÀÍÈß ÀÏÏ'		
											WHEN  		
										zs.OS_SLUCH_REGION in (6) 			
											then 'ÇÀÁÎËÅÂÀÍÈß ÀÏÏ ãåìîäèàëèç'		
										when usl.code_usl like 'R01%' then ms.name			
										ELSE ''			
										END tip	,db.Name nam			
--,sch.month as [Ìåñÿö]				
,CASE WHEN f002.tf_okato  in (35000) THEN 'Êðûì' ELSE [name_tfp]	end			

		
,count(zs.id) [êîëè÷åñòâî]				
 ,sum(sumv) [ñòîèìîñòü] 
 ,sum(sump) [ñóììà ïðèíÿòàÿ]  				
			
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 		
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
    left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
     left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20211231')		
left join f002 on f002.[smocod]=p.smo 				
		left join [dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
	left join v006 on v006.IDUMP=zs.USL_OK			
	left join f001 on f001.tf_okato=f002.tf_okato
	   left join KOKOD_OTD k on k.kod_otd=s.podr	
	 	
	left join[V019] v019 on cast(v019.IDHM as int)=s.metod_hmp  											
				   --------------------------------ñ 21 ãîäà----------------							
				                              and 							
											cast(case when year(zs.date_z_2)=2020 then v019.IDMODP else  s.MP_HMP end as nvarchar) =cast(v019.IDMODP as nvarchar)
											and s.VID_HMP=HVID
											-- ìåòîä ÂÌÏ-- ìåòîä ÂÌÏ
									   AND zs.DATE_z_2>=v019.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v019.dateend,'21000101')			
									    left join v018 v018 on v019.HVID=V018.idhvid                                 -- âèä ÂÌÏ							
									   AND zs.DATE_z_2>=V018.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v018.dateend,'21000101')					   		
where f002.tf_okato not in (38000)--(42000, 66000,  29000,  70000,  15000, 46000,24000, 82000)				
  and sank.id is null	
  and sch.YEAR between 2020 AND 2022 
GROUP BY YEAR,  v006.UMPNAME,CASE WHEN f002.tf_okato  in (35000) THEN 'Êðûì' ELSE [name_tfp]	end	
ORDER BY  YEAR,  v006.UMPNAME,CASE WHEN f002.tf_okato  in (35000) THEN 'Êðûì' ELSE [name_tfp]	end	

			