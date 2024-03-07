					
		SELECT t1.*	
		INTO temp_pervich_app_2021
		FROM			
		(select	DISTINCT		
		p.fam, p.im,p.ot,p.dr,p.NPOLIS, profil, MIN(date_z_1) date_min--, CASE WHEN OKATOG IN ('38401000000') THEN 'Курск' ELSE 'Курчатов'	 END rayon	
					 
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
			--LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
					
			--left join [D3_SANK_OMS] sank 		
			--		on sank.[D3_ZSLID]=zs.id
			--		and sank.s_tip=1
			--left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
				
		where 			
			sch.[YEAR]=2021		
			--and sch.month =7 AND sch.id IN (2782,2783,2784)		
			----		
			and zs.usl_ok in (3)		
			and idsp in (29,30)
			and os_sluch_region is null
					
			AND date_z_2 BETWEEN '20210101' AND '20211231'	
		 GROUP BY p.fam, p.im,p.ot,p.dr,p.NPOLIS, profil
			
		) t1			
					
					
			LEFT JOIN 		
			(select DISTINCT		
		p.fam, p.im,p.ot,p.dr,p.npolis			
					
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			
		where 			
							
			 date_z_1 <'20210101' 
			-- and year(date_z_2)=2021 
			) t2 ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)		
		WHERE t2.npolis is null			
