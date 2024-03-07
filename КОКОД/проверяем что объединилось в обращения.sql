 
  SELECT				
		DISTINCT		
		sch.id [idschet],zs.id,p.fam,p.im,p.ot,p.npolis,date_z_1,date_z_2,	date_1, date_2,	
		sl.profil 
			
	   	,sl.ds1,iddokt
	   	,kp.fam+' '+kp.im+' '+kp.ot
 from
[D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 
		left join v009 on v009.IDRMP=zs.rslt
		left join v012 on v012.Id=zs.ishod
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
		where zs.usl_ok in (3)	
		AND zs.id IN (
 
 
 SELECT				
		DISTINCT	zs.id	
		--sch.id,p.npolis,zs.id,p.fam, 		
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
		sch.[YEAR]=2022		
		and sch.month =8
		--AND sch.id IN (3921,3933)	
		--AND zs.PR_NOV=0	
		----		
		and zs.usl_ok in (3)	
	
		--
	and os_sluch_region is null
	
		and idsp=30--
		--AND p_cel25 NOT LIKE '3.0'
		
		) 
  ORDER BY npolis, date_1