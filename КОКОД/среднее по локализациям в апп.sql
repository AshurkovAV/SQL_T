--по врачам
	SELECT				
		DISTINCT
		sl.profil, v002.PRNAME , iddokt	,kp.fam+' '+kp.im+' '+kp.ot [doctor]
	  ,p.npolis, LEFT(ds1,3) ds1,COUNT(DISTINCT sl.NHISTORY)
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
		LEFT JOIN v002 ON v002.IDPr=sl.PROFIL
	where 			
		YEAR(zs.DATE_Z_2)=2023			
		and zs.usl_ok in (3)
		and (os_sluch_region IS NULL OR os_sluch_region<>40)--не консилиумы
		AND idsp<>28 --не услуги
		AND ds1 between 'C18' AND 'C21%'
	GROUP BY sl.profil, v002.PRNAME , iddokt	,kp.fam+' '+kp.im+' '+kp.ot 
	  ,p.npolis, LEFT(ds1,3)
	ORDER BY p.npolis



--пациенты приемы	
	SELECT				
		DISTINCT p.npolis ,COUNT(DISTINCT sl.NHISTORY)
	
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
		LEFT JOIN v002 ON v002.IDPr=sl.PROFIL
		
	where 			
		YEAR(zs.DATE_Z_2)=2023		
		
		and zs.usl_ok in (3)	
	
		and (os_sluch_region IS NULL OR os_sluch_region<>40)--не консилиумы
		AND idsp<>28 --не услуги
		AND ds1 between 'C18' AND 'C21%'
		
	GROUP BY 
	  p.npolis
	ORDER BY p.npolis





--пациенты приемы	по первичным пациентам
	SELECT				
		DISTINCT p.npolis ,COUNT(DISTINCT sl.NHISTORY)
	
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
		LEFT JOIN v002 ON v002.IDPr=sl.PROFIL
		LEFT JOIN (SELECT				
				   DISTINCT p.npolis --,COUNT(DISTINCT sl.NHISTORY)
				   FROM [D3_SCHET_OMS] sch			
				   inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
				   inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
				   inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		           WHERE YEAR(zs.DATE_Z_2)<2023		AND ds1 between 'C18' AND 'C21%'
		) t ON t.npolis=p.npolis
	where 			
		YEAR(zs.DATE_Z_2)=2023		
		
		and zs.usl_ok in (3)	
	
		and (os_sluch_region IS NULL OR os_sluch_region<>40)--не консилиумы
		AND idsp<>28 --не услуги
		AND ds1 between 'C18' AND 'C21%'
		AND t.npolis IS null
	GROUP BY 
	  p.npolis
	ORDER BY p.npolis
	
	
	
	