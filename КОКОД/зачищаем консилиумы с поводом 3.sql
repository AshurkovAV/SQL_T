UPDATE c SET c.pr_cons=0, c.dt_cons=NULL
SELECT				
		DISTINCT		
			
		sl.profil, v002.PRNAME --, iddokt
			,kp.fam+' '+kp.im+' '+kp.ot
	,c.*, zs.DATE_Z_1, p.FAM,p.im, p.ot,p.dr, sl.p_cel25
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		JOIN D3_CONS_OMS AS c ON c.D3_SLID=sl.id
		--LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
		JOIN D3_ONK_SL_OMS onk ON onk.D3_SLID=sl.id		
		--left join [D3_SANK_OMS] sank 		
		--		on sank.[D3_ZSLID]=zs.id
		--		and sank.s_tip=1
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		
		left join f003 f3 on f3.mcod=sch.code_mo	
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
		LEFT JOIN v002 ON v002.IDPr=sl.PROFIL
	where 			
		sch.[YEAR]=2023		
		and sch.month =1 --and sch.id in (2738,2742)		
		----		
		and zs.usl_ok in (3)	
	
		and onk.ds1_t=3 AND c.PR_CONS IN (2,3)
		--AND sch.id in (select sch.id from D3_SCHET_OMS sch where sch.NSCHET LIKE '%сдан%' AND sch.year=2021)
--AND kp.fam IS null
 
 