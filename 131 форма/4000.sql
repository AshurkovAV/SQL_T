Select DISTINCT					
 o.[NameWithID] [вид дисп]					
 , ddo.DS	[Диагноз в соответствии с МКБ-10]
				
 , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <56 then 'жен младше 56'					
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >55 then 'жен старше 55' 			
		when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 then 'муж младше 61'			
		when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >60 then 'муж старше 60' end [пол_возраст]			
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
left JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = s.ID					
 					
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme					
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION					
where sch.CODE_MO=460026					
	and sch.year=2022 and sch.month=4
	and zs.OS_SLUCH_REGION in(47,49) -- ДВН 1 эт				
	and isnull(zs.PR_NOV,0)=0 --подано впервые				
	AND ddo.DS IS NOT null				
	group by  o.[NameWithID]				
			, ddo.DS	
					
            , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <56 then 'жен младше 56'					
					when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >55 then 'жен старше 55' 
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 then 'муж младше 61'
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >60 then 'муж старше 60' end 
			order by  o.[NameWithID]		
			, ddo.DS	
            , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <56 then 'жен младше 56'					
					when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >55 then 'жен старше 55' 
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 then 'муж младше 61'
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >60 then 'муж старше 60' end 
