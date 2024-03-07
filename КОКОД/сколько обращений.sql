 SELECT				
		DISTINCT		
		sch.id,sch.NSchet,p.npolis,zs.id --,p.DR		
	--	sl.profil 
			
	  -- 	, ds1--ount(*) kol
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		--LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
				
		--left join [D3_SANK_OMS] sank 		
		--		on sank.[D3_ZSLID]=zs.id
		--		and sank.s_tip=1
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN v002 ON v002.IDPR=sl.PROFIL		
		left join f003 f3 on f3.mcod=sch.code_mo		
	where 			
		sch.[YEAR]=2023	
		--and sch.month =6
		AND sch.id IN (12850,12852,14942,14941,11837,10759,14952,14950)	
		--AND zs.PR_NOV=0	
		----		
		and zs.usl_ok in (3)	
	
		--
	--and os_sluch_region is null
	 
	--and os_sluch_region = 56
		and idsp=29--
		--AND  dbo.[f_getage](p.dr, zs.date_z_1)<=17