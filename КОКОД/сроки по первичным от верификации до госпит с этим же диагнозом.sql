--�� ������������

WITH app --���� � ��� 23 ���� c ������������� �������������
AS ( SELECT				
		DISTINCT p.NPOLIS, left(ds1,3) ds1,MIN(sl.DATE_1) date_1_min_app
			
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID
		
	where 			
		YEAR(date_z_2)=2023
		and zs.usl_ok in (3)
		and (os_sluch_region IS NULL OR os_sluch_region<>40)--�� ����������
		AND idsp<>28 --�� ������
		AND ds1 between 'C00' AND 'D09.z'
		AND ds_onk=0
	GROUP BY 	p.NPOLIS,left(ds1,3)
	 )


SELECT app.*,case when (app.ds1 between 'C00' and 'C14.Z') OR (app.ds1 between 'C30' and 'C32.Z') then '������, ��� C00-14, C30-32'						
			      when app.ds1  like 'C50%' then '��� C50'						
			      when app.ds1 between 'C33' and 'C38.Z' then '��� ������� � ������ C33-�38'			
				  when app.ds1  between 'C15' and 'C17.Z' then '��� �������, �������� C15-C17'			
				  when app.ds1   between 'C18' and 'C21.z' then '�������������� ��� C18-21' 					
				  when  app.ds1  between 'C51' and 'C58.Z' then '����������� C51-58'				
			      when  app.ds1  between 'C60' and 'C68.Z' then '�������� C60-68'		
				  when app.ds1  between 'C43' and 'C44.Z' then '�������� � ���� C43-44'			
				  when   app.ds1  between 'C81' and 'C85.Z' then '������� C81-85'			
				  when  app.ds1  between 'C40' and 'C41.Z' then '����� C40-41'		
				  when  app.ds1  between 'C45' and 'C49.Z' then '������� C45-49'	
				  else app.ds1 end '����������� ���',
							
							 t1.date_1_min_stac,t1.ds1,
							
							 case when (t1.ds1 between 'C00' and 'C14.Z') OR (t1.ds1 between 'C30' and 'C32.Z') then '������, ��� C00-14, C30-32'						
			                      when t1.ds1  like 'C50%' then '��� C50'						
						          when t1.ds1 between 'C33' and 'C38.Z' then '��� ������� � ������ C33-�38'			
						          when t1.ds1  between 'C15' and 'C17.Z' then '��� �������, �������� C15-C17'			
				                  when t1.ds1   between 'C18' and 'C21.z' then '�������������� ��� C18-21' 					
				 	              when  t1.ds1  between 'C51' and 'C58.Z' then '����������� C51-58'				
					  	          when  t1.ds1  between 'C60' and 'C68.Z' then '�������� C60-68'		
						          when t1.ds1  between 'C43' and 'C44.Z' then '�������� � ���� C43-44'			
						          when   t1.ds1  between 'C81' and 'C85.Z' then '������� C81-85'			
							      when  t1.ds1  between 'C40' and 'C41.Z' then '����� C40-41'		
								  when  t1.ds1  between 'C45' and 'C49.Z' then '������� C45-49'	
								  else t1.ds1 end '����������� ����',							 
	                                    DATEDIFF(
	                                      dd,
	                                      app.date_1_min_app,
	                                      case when t1.date_1_min_stac IS NULL THEN GETDATE()  ELSE t1.date_1_min_stac END 
	                                      ) 
FROM app
LEFT JOIN (--���� �� 23 ���� � ������������� � ����������
	       SELECT  DISTINCT			p.NPOLIS
	      FROM [D3_SCHET_OMS] sch			
		  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		  inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		  where 			
		YEAR(date_z_2)<2023
		AND ds1 between 'C00' AND 'D09.z'
		AND ds_onk=0) t ON t.NPOLIS=app.npolis
LEFT JOIN (SELECT  DISTINCT			p.NPOLIS, MIN(sl.DATE_1) date_1_min_stac,LEFT(ds1,3) ds1
	      FROM [D3_SCHET_OMS] sch			
		  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		  inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		  where 			
		YEAR(date_z_2)=2023
		AND ds1 LIKE 'C%'
        AND zs.USL_OK IN (1,2)
           GROUP BY p.npolis, ds1) t1 ON t1.NPOLIS=app.npolis	--AND 	t1.ds1=app.ds1
WHERE t.NPOLIS IS null		
ORDER BY app.npolis
