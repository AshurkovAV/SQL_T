WITH app --были в апп 23 году
AS ( SELECT t.* 
   from
					(SELECT	--у кого была хими€ до окт€бр€ в 23 году			
						DISTINCT		
							p.NPOLIS, sl.ds1,max(sl.DATE_2) max_date_him
			
					FROM [D3_SCHET_OMS] sch			
						inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
						inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
						inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID
						join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id				
						join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 
						join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id  
					where 			
						date_z_2 BETWEEN '20230101' AND '20231031'
						and zs.usl_ok in (1,2)
						AND (ds1 LIKE 'C16%' OR ds1 LIKE 'C18%')
	                    --AND npolis='4648730874000369'
	                GROUP BY 	p.NPOLIS, sl.ds1) t
	LEFT JOIN 
				(SELECT		---у кого была хими€ после окт€бр€		
					DISTINCT		
						p.NPOLIS, sl.ds1,max(sl.DATE_2) max_date_him
			
				FROM [D3_SCHET_OMS] sch			
					inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
					inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
					inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID
					join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id				
					join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 
					join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id  
				where 			
					date_z_2> '20231031'
					and zs.usl_ok in (1,2)
					AND (ds1 LIKE 'C16%' OR ds1 LIKE 'C18%')
	
				GROUP BY 	p.NPOLIS, sl.ds1) t1 ON t.NPOLIS=t1.NPOLIS AND LEFT(t.ds1,3)=LEFT(t1.ds1,3)
	LEFT JOIN 
				(SELECT		---у кого была хими€ после окт€бр€		
					DISTINCT		
						p.NPOLIS, sl.ds1,max(sl.DATE_2) max_date_him
			
				FROM [D3_SCHET_OMS] sch			
					inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
					inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
					inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID
					join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id				
					join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 
					join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id  
				where 			
					date_z_2> '20231031'
					and zs.usl_ok in (3)
					AND (ds1 LIKE 'C16%' OR ds1 LIKE 'C18%')
	                AND sl.IDDOKT LIKE '131-645-509 39'
				GROUP BY 	p.NPOLIS, sl.ds1) t2 ON t.NPOLIS=t1.NPOLIS AND LEFT(t.ds1,3)=LEFT(t2.ds1,3)		
     WHERE t1.NPOLIS IS null AND t2.NPOLIS IS null		
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
LEFT JOIN (SELECT  DISTINCT			p.NPOLIS, MIN(sl.DATE_1) date_1_min_stac, ds1
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
ORDER BY app.npolis
