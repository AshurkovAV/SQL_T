DECLARE @D3_SCID INT = 2077
select zsl.ID,							
		 p.fam,					
		 p.IM,					
		 p.ot,					
		 CAST(p.DR AS DATE) dr,
     --p.NPOLIS,
     CAST(zsl.DATE_Z_1 AS DATE) DATE_Z_1,
     CAST(zsl.DATE_Z_2 AS DATE) DATE_Z_2,  					
		 'Дублирование случаев в поликлинике' com					
FROM D3_ZSL_OMS_OMS zsl							
inner join D3_D3_PACIENT_OMS_OMS p on zsl.D3_PID=p.ID							
						   and  zsl.ID in (select ID	
					--'Дублирование случаев в поликлинике' com		
				from (SELECT ROW_NUMBER() OVER (PARTITION BY pa.FAM, pa.IM, pa.OT, pa.DR, sl.PROFIL, sl.DATE_2, sl.PODR ORDER BY zsl.SUMV) RN			
							 ,zsl.ID, zsl.SUMV
						 FROM D3_D3_PACIENT_OMS_OMS pa	
						 join D3_ZSL_OMS_OMS zsl on pa.ID = zsl.D3_PID	
						 join D3_SL_OMS_OMS sl on sl.D3_ZSL_OMSid=zsl.id	
						 Where 	
						 zsl.d3_SCID = @D3_SCID and	
						  zsl.OS_SLUCH_REGION is null  and sl.PROFIL not in (85,86,87,88,89,90) and zzzsl.usl_ok = 3	
					 ) t		
				WHERE  RN > 1)	
ORDER BY p.FAM, p.IM, p.OT, p.DR		

--UPDATE D3_ZSL_OMS_OMS SET D3_SCID = 2084, MEK_COMENT = 'Дублирование случаев в поликлинике' 							
--WHERE ID in (select ID	
--				from (SELECT ROW_NUMBER() OVER (PARTITION BY pa.FAM, pa.IM, pa.OT, pa.DR, sl.PROFIL, sl.DATE_2, sl.PODR ORDER BY zsl.SUMV) RN			
--							 ,zsl.ID, zsl.SUMV
--						 FROM d3_D3_PACIENT_OMS_OMS pa	
--						 join D3_ZSL_OMS_OMS zsl on pa.ID = zsl.D3_PID	
--						 join D3_SL_OMS_OMS sl on sl.D3_ZSL_OMSid=zsl.id	
--						 Where 	
--						 zsl.d3_SCID = @D3_SCID and	
--						  zsl.OS_SLUCH_REGION is null  and sl.PROFIL not in (85,86,87,88,89,90) and zzzsl.usl_ok = 3	
--					 ) t		
--				WHERE  RN > 1)		 					
