Select DISTINCT			
 o.[NameWithID] [вид дисп]			
 , case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 18 and 34 then '18-34'			
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 35 and 39 then '35-39' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 40 and 54 then '40-54'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 55 and 59 then '55-59'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 60 and 64 then '60-64'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 65 and 74 then '65-74'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)>=75 then '75 и старше' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=55 and p.w=2 then '55 жен'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=60 and p.w=1 then '60 муж'  
   else cast(P.DR AS VARCHAR) END [возраст]
 --,zs.id			
  ,p.W as [Пол]			
  ,count(zs.id) [количество]			
  --,[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) [возраст]			
	--, s.ds1	[Диагноз в соответствии с МКБ-10]	
 --, usl.code_usl			
 --,y.namewithid	[наимеование услуги]		
			
			
FROM [D3_SCHET_OMS] sch                  			
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id			
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 			
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 			
--left join d3_usl_oms usl on usl.D3_SLID=s.id			
 			
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme			
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION			
where sch.CODE_MO=460026			
	 and sch.year=2022 and sch.month=04
	and zs.OS_SLUCH_REGION in(47,49) -- ДВН 1 эт		
	and isnull(zs.PR_NOV,0)=0 --подано впервые		
	group by o.[NameWithID],  case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 18 and 34 then '18-34'			
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 35 and 39 then '35-39' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 40 and 54 then '40-54'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 55 and 59 then '55-59'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 60 and 64 then '60-64'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 65 and 74 then '65-74'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)>=75 then '75 и старше' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=55 and p.w=2 then '55 жен'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=60 and p.w=1 then '60 муж' 
			  else cast(P.DR AS VARCHAR) END , p.w
			order by o.[NameWithID], case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 18 and 34 then '18-34'			
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 35 and 39 then '35-39' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 40 and 54 then '40-54'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 55 and 59 then '55-59'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 60 and 64 then '60-64'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 65 and 74 then '65-74'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)>=75 then '75 и старше' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=55 and p.w=2 then '55 жен'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=60 and p.w=1 then '60 муж' 
			 ELSE cast(P.DR AS VARCHAR) END , p.w
