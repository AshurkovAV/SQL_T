	SELECT t1.*
	FROM
	(select	DISTINCT		
	p.fam, p.im,p.ot,p.dr,p.npolis		
		
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		--inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		--LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
				
		--left join [D3_SANK_OMS] sank 		
		--		on sank.[D3_ZSLID]=zs.id
		--		and sank.s_tip=1
		--left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		--LEFT JOIN v002 ON v002.IDPR=sl.PROFIL		
		--left join f003 f3 on f3.mcod=sch.code_mo		
	where 			
		sch.[YEAR]=2021		
		and sch.month =7 AND sch.id IN (2732,2733)		
		----		
		and zs.usl_ok in (3)	
	
		AND date_z_1 BETWEEN '20210701' AND '20210725'
	) t1
		
		
		LEFT JOIN 
		(select DISTINCT		
	p.fam, p.im,p.ot,p.dr,p.npolis	
		
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		--inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		--LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
				
		--left join [D3_SANK_OMS] sank 		
		--		on sank.[D3_ZSLID]=zs.id
		--		and sank.s_tip=1
		--left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		--LEFT JOIN v002 ON v002.IDPR=sl.PROFIL		
		--left join f003 f3 on f3.mcod=sch.code_mo		
	where 			
		--sch.[YEAR]=2021		
		--and sch.month =7		
		----		
		-- zs.usl_ok in (3)	
	
		 date_z_1 <'20210701' ) t2 ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)
	WHERE t2.npolis is null