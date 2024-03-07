WITH app AS (
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
		sch.[YEAR]=2023		
		and sch.month BETWEEN 1 AND 3 
		----		
		and zs.usl_ok in (3)	
	
		and (os_sluch_region IS NULL OR os_sluch_region<>40)--не консилиумы
		AND idsp<>28 --не услуги
		AND sch.id in (select sch.id from D3_SCHET_OMS sch where sch.NSCHET LIKE '%сдан%' AND sch.year=2023) --обязательно реестр дек тоже подписать сдан
)

SELECT profil,prname,iddokt,doctor,pr,COUNT(ID) kol_vo
FROM      (
			SELECT t1.*, CASE WHEN t2.fam IS NOT NULL THEN 'первично' else 'повторно' END pr
			FROM app t1
			LEFT JOIN temp_pervich_app_2023_1_3 t2  ON t2.npolis = t1.npolis AND t1.date_2=t2.date_min
) t
GROUP BY profil,prname,iddokt,doctor,pr