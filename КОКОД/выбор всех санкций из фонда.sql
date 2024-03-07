SELECT * 
INTO sank_2020_1_11
FROM [D3_SCHET_OMS] sch   				
 inner join D3_ZSL_OMS zs on zs.D3_SCID=sch.id					
 join [D3_SANK_OMS] sank 			
				on sank.[D3_ZSLID]=zs.id
			
where  sch.code_mo=460061 				
       -- AND sch.month=8 				
		AND sch.YEAR=2020		
		