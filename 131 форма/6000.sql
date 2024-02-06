Select DISTINCT					
 o.[NameWithID] [вид дисп]		
 ,zs.RSLT_D			
 ,v017.[DRNAME] [результат дисп]
  , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <66 then 'трудоспособные'		
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=66 then 'старше трудоспособного' 
		end [признак трудоспособности]	
 --,zs.id					
 --,p.W as [Пол]					
  ,count(zs.id) [количество]					
  --,[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) [возраст]					
	--, s.ds1	[Диагноз в соответствии с МКБ-10]			
 --, usl.code_usl					
 --,y.namewithid	[наимеование услуги]				
					
					
FROM [D3_SCHET_OMS] sch                  					
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id					
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 					
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left join v017 on v017.IDDR=zs.RSLT_D		
			
 					
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme					
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION					
where sch.CODE_MO=460026					
	and sch.year=2024 and sch.month=1
	and zs.OS_SLUCH_REGION in(47,49) -- ДВН 1 эт				
	and isnull(zs.PR_NOV,0)=0 --подано впервые	
	                          --	
GROUP BY o.[NameWithID] 
 , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <66 then 'трудоспособные'		
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=66 then 'старше трудоспособного' 
		end
,zs.RSLT_D, v017.[DRNAME]  , s.DN          
ORDER BY        		
	o.[NameWithID]
	
	Select DISTINCT					
 o.[NameWithID] [вид дисп]		
 ,zs.RSLT_D			
 ,v017.[DRNAME] [результат дисп]

 --,zs.id					
 --,p.W as [Пол]					
  ,count(zs.id) [количество]					
  --,[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) [возраст]					
	--, s.ds1	[Диагноз в соответствии с МКБ-10]			
 --, usl.code_usl					
 --,y.namewithid	[наимеование услуги]				
					
					
FROM [D3_SCHET_OMS] sch                  					
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id					
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 					
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left join v017 on v017.IDDR=zs.RSLT_D		
			
 					
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme					
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION					
where sch.CODE_MO=460026					
	and sch.year=2023 and sch.month=3
	and zs.OS_SLUCH_REGION in(47,49) -- ДВН 1 эт				
	and isnull(zs.PR_NOV,0)=0 --подано впервые	
	    AND s.DS1_PR = 1                     --	
GROUP BY o.[NameWithID], zs.RSLT_D, v017.[DRNAME]  , s.DN          
ORDER BY        		
	o.[NameWithID]