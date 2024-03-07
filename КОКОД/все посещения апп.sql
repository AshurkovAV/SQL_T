SELECT				
		DISTINCT		
			p.NPOLIS, zs.id,sl.date_2,
		sl.profil, v002.PRNAME , iddokt
			,kp.fam+' '+kp.im+' '+kp.ot [doctor]
	--  ,count(*) kol
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
		LEFT JOIN v002 ON v002.IDPr=sl.PROFIL
	where 			
		sch.[YEAR]=2022		
		and sch.code_mo ='460061'
		----		
		and zs.usl_ok in (3)	
	    AND ISNULL(zs.PR_NOV,0)=0
		and (os_sluch_region IS NULL)
		AND idsp<>28 --не услуги