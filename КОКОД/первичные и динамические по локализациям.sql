
      

	WITH  vse AS(
		select	DISTINCT
		                case when (ds1 between 'C00' and 'C14.Z' 
		                           OR ds1 LIKE 'C30%'    
		                           OR ds1 LIKE 'C31%'
		                           OR ds1 LIKE 'C32%' 
		                           or ds1 LIKE 'C70%'
		                          or ds1 LIKE 'C71%'
		                          or ds1 LIKE 'C72%'        
		                          or ds1 LIKE 'C75.2%'   
		                          or ds1 LIKE 'C76.0%'  
		                          or ds1 LIKE 'C77.0%'    
		                           or ds1 LIKE 'C79.3%' 
		                          or ds1 LIKE 'D00.0%'
		                          or ds1 LIKE 'D02.0%'  )     then 'Голова, шея'										
			              when (ds1  like 'C50%' or ds1 LIKE 'C77.3' or ds1 LIKE 'D05.1') then ' маммологи'								
						  when (ds1  like 'C34%'  
						         or ds1 LIKE 'С15%' 
						         or ds1 LIKE 'С33%' 
						         or ds1 LIKE 'С37%' 
						         or ds1 LIKE 'С38%'
						          or ds1 LIKE 'С76.1%'
						          or ds1 LIKE 'С77.1%'
						          or ds1 LIKE 'С78.0%'
						          or ds1 LIKE 'С78.8%')then 'торакальные'					
						  when (ds1  like 'C16%' 
								  or ds1 like 'C17.1%'
								    or ds1 like 'C17.8%'
								      or ds1 like 'C17.9%'
								  or ds1 like 'C22%'
								  or ds1 like 'C23%'
								  or ds1 like 'C24%'
								  or ds1 like 'C25%'
								  or ds1 like 'C76.2%'
								  or ds1 like 'C78.4%'
								  or ds1 like 'C78.6%'
								  or ds1 like 'C78.7%'
								  or ds1 like 'D00.2%'
								  or ds1 like 'D01.5%'
						          )  then 'абдоминальные'					
				          when (ds1   between 'C18' and 'C20.Z'
				                    or ds1 like 'C17.0%'
				                     or ds1 like 'C17.2%'
				                     or ds1 like 'C17.3%'
				                       or ds1 like 'C21%'
				                      or ds1 like 'C78.5%'
				                      or ds1 like 'D01.0%'
				                      or ds1 like 'D01.1%'
				                      or ds1 like 'D01.2%'
				                      or ds1 like 'D01.4%') then 'Колоректальный рак' 							
				 	      when  (ds1  between 'C51' and 'C58.Z' 
				 	                 or ds1 like 'C77.4%' 
				 	                 or ds1 like 'D06%'     
				 	                 or ds1 like 'D07.0%'          
				 	                 or ds1 like 'D07.1%' 
				 	                 or ds1 like 'D07.2%'   )then 'Гинекология'						
					  	  when  (ds1  between 'C60' and 'C68.Z'
					  	         or ds1 LIKE 'C79.0' 
					  	           or ds1 like 'D07.4%'          
				 	                 or ds1 like 'D07.5%' 
				 	                 or ds1 like 'D07.6%'    ) then 'Урология'				
						  when (ds1  between 'C43' and 'C44.Z'
						         or ds1 LIKE 'C76.5'
						         or ds1 LIKE 'C79.2'
						         or ds1 LIKE 'C79.5'
						         or ds1 LIKE 'D04%')   THEN 'дерматологи'					
						  when   ds1  between 'C81' and 'C85.Z' then 'Лимфома'
		                   WHEN (ds1  LIKE 'C90%'
						         or ds1 LIKE 'C91%'
						         or ds1 LIKE 'C92%'
						         or ds1 LIKE 'C93%'
						         or ds1 LIKE 'C94%'
						         or ds1 LIKE 'C95%'
						         or ds1 LIKE 'C96%'	 )	THEN 'лейкоз'				
						  when   ds1  between 'C40' and 'C41.Z' then 'Кости'				
						  when  ds1  between 'C45' and 'C49.Z' then 'Саркомы'	
						  when  ds1  like 'C69%'  then 'офтальмолог'	
						  when  (ds1  like 'C73%'
						         or ds1 like 'C74.0%'
						         or ds1 like 'C74.1%'
						         or ds1 like 'C74.9%') then 'эндокринолог'	
						   WHEN  NOT (ds1  BETWEEN 'C00' AND 'D09.z' OR ds1 between'D45' AND 'D47.z') THEN 'неонкодиагнозы'
										
								else 'все' end 'локализация',				
				--kp.fam+' '+kp.im+' '+kp.ot [врач приема],
				p.fam,p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) npolis, COUNT(DISTINCT zs.id) [количество посещений]
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			join D3_SL_OMS s on s.D3_ZSLID=zs.ID
			--LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(s.iddokt) AND kp.usl_ok=3
		where 
			zs.usl_ok in (3)	
			AND s.IDDOKT NOT IN ('131-645-509 39','162-218-633 46')	
			and idsp in (29,30)
			and os_sluch_region is null
			AND date_z_2 BETWEEN '20220101' AND '20220630'	
			AND isnull(zs.pr_nov,0)=0
			AND sch.id IN (SELECT id 
			               FROM D3_SCHET_OMS AS sch
			                where sch.NSCHET LIKE '%сдан%' OR sch.NSCHET LIKE '%МЭК%' )
		GROUP BY
		-- kp.fam+' '+kp.im+' '+kp.ot,
		  case when (ds1 between 'C00' and 'C14.Z' 
		                           OR ds1 LIKE 'C30%'    
		                           OR ds1 LIKE 'C31%'
		                           OR ds1 LIKE 'C32%' 
		                           or ds1 LIKE 'C70%'
		                          or ds1 LIKE 'C71%'
		                          or ds1 LIKE 'C72%'        
		                          or ds1 LIKE 'C75.2%'   
		                          or ds1 LIKE 'C76.0%'  
		                          or ds1 LIKE 'C77.0%'    
		                           or ds1 LIKE 'C79.3%' 
		                          or ds1 LIKE 'D00.0%'
		                          or ds1 LIKE 'D02.0%'  )     then 'Голова, шея'										
			              when (ds1  like 'C50%' or ds1 LIKE 'C77.3' or ds1 LIKE 'D05.1') then ' маммологи'								
						  when (ds1  like 'C34%'  
						         or ds1 LIKE 'С15%' 
						         or ds1 LIKE 'С33%' 
						         or ds1 LIKE 'С37%' 
						         or ds1 LIKE 'С38%'
						          or ds1 LIKE 'С76.1%'
						          or ds1 LIKE 'С77.1%'
						          or ds1 LIKE 'С78.0%'
						          or ds1 LIKE 'С78.8%')then 'торакальные'					
						  when (ds1  like 'C16%' 
								  or ds1 like 'C17.1%'
								    or ds1 like 'C17.8%'
								      or ds1 like 'C17.9%'
								  or ds1 like 'C22%'
								  or ds1 like 'C23%'
								  or ds1 like 'C24%'
								  or ds1 like 'C25%'
								  or ds1 like 'C76.2%'
								  or ds1 like 'C78.4%'
								  or ds1 like 'C78.6%'
								  or ds1 like 'C78.7%'
								  or ds1 like 'D00.2%'
								  or ds1 like 'D01.5%'
						          )  then 'абдоминальные'					
				          when (ds1   between 'C18' and 'C20.Z'
				                    or ds1 like 'C17.0%'
				                     or ds1 like 'C17.2%'
				                     or ds1 like 'C17.3%'
				                       or ds1 like 'C21%'
				                      or ds1 like 'C78.5%'
				                      or ds1 like 'D01.0%'
				                      or ds1 like 'D01.1%'
				                      or ds1 like 'D01.2%'
				                      or ds1 like 'D01.4%') then 'Колоректальный рак' 							
				 	      when  (ds1  between 'C51' and 'C58.Z' 
				 	                 or ds1 like 'C77.4%' 
				 	                 or ds1 like 'D06%'     
				 	                 or ds1 like 'D07.0%'          
				 	                 or ds1 like 'D07.1%' 
				 	                 or ds1 like 'D07.2%'   )then 'Гинекология'						
					  	  when  (ds1  between 'C60' and 'C68.Z'
					  	         or ds1 LIKE 'C79.0' 
					  	           or ds1 like 'D07.4%'          
				 	                 or ds1 like 'D07.5%' 
				 	                 or ds1 like 'D07.6%'    ) then 'Урология'				
						  when (ds1  between 'C43' and 'C44.Z'
						         or ds1 LIKE 'C76.5'
						         or ds1 LIKE 'C79.2'
						         or ds1 LIKE 'C79.5'
						         or ds1 LIKE 'D04%')   THEN 'дерматологи'					
						  when   ds1  between 'C81' and 'C85.Z' then 'Лимфома'
		                   WHEN (ds1  LIKE 'C90%'
						         or ds1 LIKE 'C91%'
						         or ds1 LIKE 'C92%'
						         or ds1 LIKE 'C93%'
						         or ds1 LIKE 'C94%'
						         or ds1 LIKE 'C95%'
						         or ds1 LIKE 'C96%'	 )	THEN 'лейкоз'				
						  when   ds1  between 'C40' and 'C41.Z' then 'Кости'				
						  when  ds1  between 'C45' and 'C49.Z' then 'Саркомы'	
						  when  ds1  like 'C69%'  then 'офтальмолог'	
						  when  (ds1  like 'C73%'
						         or ds1 like 'C74.0%'
						         or ds1 like 'C74.1%'
						         or ds1 like 'C74.9%') then 'эндокринолог'	
						   WHEN  NOT (ds1 BETWEEN 'C00' AND 'D09.z' OR ds1 between 'D45' AND 'D47.z') THEN 'неонкодиагнозы'
										
								else 'все' end , p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP)
			)					
								
		
		
		
		
		
		
		SELECT distinct t1.*,CASE WHEN t2.fam IS NOT NULL THEN 1 ELSE 0 END pr_pervich
		from vse t1
		LEFT JOIN perv_2022 t2  ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)
		ORDER BY t1.fam, t1.im, t1.ot
								
--		) t1			
--		--					
--		LEFT JOIN 		
--			(select DISTINCT		
--					p.fam, p.im,p.ot,p.dr,p.npolis	
--					FROM [D3_SCHET_OMS] sch			
--						inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
--						inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
--			     	where	 date_z_1 <'20220101' --AND p.npolis='4658040826000302'
--			) t2 
--			ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)		
		
--WHERE t2.npolis is null		
--    --  )	
      
      
--SELECT * 
--FROM perv_160822 
     

