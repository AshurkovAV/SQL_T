select	DISTINCT		
		p.w,p.fam, p.im,p.ot,p.dr,case when dbo.[f_getage](p.dr, zs.date_z_1)>=18 THEN 'взрослые' else 'дети' END [vozrast], nhistory, p.okatog
					 
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
		
				
		where 			
			
		 zs.usl_ok=3 AND idsp<>28	
			--and (dbo.[f_getage](p.dr, zs.date_z_1)>=55 AND p.w=2 OR dbo.[f_getage](p.dr, zs.date_z_1)>=60 AND p.w=1) 
			and year(date_z_2)=2021