 SELECT				
		DISTINCT	
		zs.zsl_id,p.FAM, p.IM, p.OT, p.DR,p.NPOLIS,p.smo,zs.sumv,sl.NHISTORY, zs.DATE_Z_1,zs.DATE_Z_2
		--sch.id,sch.NSchet,p.npolis,zs.zsl_id	
	--	sl.profil 
			
	  -- 	, ds1--ount(*) kol
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID
	--right JOIN [ElmedKokod2].[dbo].[temp_tap] t ON t.[Префикс-номер]=sl.NHISTORY
 WHERE sl.NHISTORY 
 IN
 
 (SELECT distinct [Префикс-номер]
      
  FROM [ElmedKokod2].[dbo].[temp_tap])
  
  
  
  SELECT t.*, sch.NSCHET,iddokt
  FROM
  [ElmedKokod2].[dbo].[temp_tap] t
  LEFT JOIN  D3_SL_OMS sl on t.[Префикс-номер]=sl.NHISTORY
 LEFT  join D3_ZSL_OMS zs on sl.D3_ZSLID=zs.ID
 LEFT JOIN  [D3_SCHET_OMS] sch ON sch.id=zs.D3_SCID
  WHERE sl.id IS null