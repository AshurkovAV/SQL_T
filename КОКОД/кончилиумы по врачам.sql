 SELECT				
		DISTINCT		
			
		sl.profil, v002.PRNAME --, iddokt
			,kp.fam+' '+kp.im+' '+kp.ot
	 ,count(*) kol
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		--LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
				
		--left join [D3_SANK_OMS] sank 		
		--		on sank.[D3_ZSLID]=zs.id
		--		and sank.s_tip=1
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		
		left join f003 f3 on f3.mcod=sch.code_mo	
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
		LEFT JOIN v002 ON v002.IDPr=sl.PROFIL
	where 			
		sch.[YEAR]=2023		
		and sch.month =3 --and sch.id in (2738,2742)		
		----		
		and zs.usl_ok in (3)	
	
		and os_sluch_region=40
		--AND sch.id in (select sch.id from D3_SCHET_OMS sch where sch.NSCHET LIKE '%сдан%' AND sch.year=2021)
--AND kp.fam IS null
 
 
 GROUP BY 		
		sl.profil, v002.PRNAME  
			,kp.fam+' '+kp.im+' '+kp.ot