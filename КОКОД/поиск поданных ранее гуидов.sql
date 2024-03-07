SELECT				
		DISTINCT	
		zs.zsl_id,p.FAM, p.IM, p.OT, p.DR,p.NPOLIS,p.smo,zs.sumv,sl.NHISTORY, zs.DATE_Z_1,zs.DATE_Z_2, t.*
		--sch.id,sch.NSchet,p.npolis,zs.zsl_id	
	--	sl.profil 
			
	  -- 	, ds1--ount(*) kol
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID
	 JOIN  (select	
		DISTINCT	
		zs.zsl_id,
		sch.id,sch.NSchet,p.npolis	
	--	sl.profil 
			
	  -- 	, ds1--ount(*) kol
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID
  		WHERE sch.year=2023 AND sch.month<5
	) t ON t.zsl_id=zs.ZSL_ID
 WHERE sch.id IN (14895,14894,14892,11837)
 