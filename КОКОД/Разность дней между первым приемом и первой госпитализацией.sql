WITH app --были в апп 23 году
AS (
	SELECT				
		DISTINCT		
			p.NPOLIS, MIN(sl.DATE_1) date_1_min_app
			
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		
	where 			
		YEAR(date_z_2)=2023
		and zs.usl_ok in (3)
		and (os_sluch_region IS NULL OR os_sluch_region<>40)--не консилиумы
		AND idsp<>28 --не услуги
		--AND ds1 LIKE 'C%'
	GROUP BY 	p.NPOLIS
)


SELECT app.*, t1.date_1_min_stac,t1.ds1,
	                                    DATEDIFF(
	                                      dd,
	                                      app.date_1_min_app,
	                                      case when t1.date_1_min_stac IS NULL THEN GETDATE()  ELSE t1.date_1_min_stac END 
	                                      ) 
FROM app
LEFT JOIN (SELECT  DISTINCT			p.NPOLIS
	      FROM [D3_SCHET_OMS] sch			
		  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		  inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		  where 			
		YEAR(date_z_2)<2023
	--	AND ds1 LIKE 'C%'
) t ON t.NPOLIS=app.npolis
LEFT JOIN (SELECT  DISTINCT			p.NPOLIS, ds1,MIN(sl.DATE_1) date_1_min_stac
	      FROM [D3_SCHET_OMS] sch			
		  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		  inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		  where 			
		YEAR(date_z_2)=2023
		AND ds1 LIKE 'C%'
        AND zs.USL_OK IN (1,2)
           GROUP BY p.npolis, ds1) t1 ON t1.NPOLIS=app.npolis		
WHERE t.NPOLIS IS null		
