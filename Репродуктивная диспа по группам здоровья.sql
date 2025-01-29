Select DISTINCT					
 zs.RSLT_D			
 ,v017.[DRNAME] [результат дисп] , p.W , sch.[MONTH]   
  ,count(zs.id) [количество]					

					
					
FROM [D3_SCHET_OMS] sch                  					
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id					
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 					
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left join v017 on v017.IDDR=zs.RSLT_D		
				
where sch.CODE_MO=460026					
	and sch.year=2024 and sch.month in (1,2,3,4,5,6)
	AND sch.SchetType = 'DD'			
	and isnull(zs.PR_NOV,0)=0 --подано впервые	
	                          --	
GROUP BY zs.RSLT_D, v017.[DRNAME], p.W , sch.[MONTH]           


Select DISTINCT					
 zs.RSLT_D			
 ,v017.[DRNAME] [результат дисп] , p.W , sch.[MONTH]   
  ,count(zs.id) [количество]					

					
					
FROM [D3_SCHET_OMS] sch                  					
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id					
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 					
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left join v017 on v017.IDDR=zs.RSLT_D		
				
where sch.CODE_MO=460026					
	and sch.year=2024 and sch.month in (1,2,3,4,5,6)
	AND sch.SchetType = 'DE'			
	and isnull(zs.PR_NOV,0)=0 --подано впервые	
	                          --	
GROUP BY zs.RSLT_D, v017.[DRNAME], p.W , sch.[MONTH]           

