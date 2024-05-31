Select DISTINCT		
 o.[NameWithID] [вид дисп]		
		
 , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <66 then 'трудоспособные'		
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=66 then 'старше трудоспособного' 
	 end [признак трудоспособности]	
	, left(s.ds1,3)	[ƒиагноз]
	, case when dn =1 THEN '1 состоит'
	when dn =2 THEN '2 - вз€т'
	when dn =3 THEN '3  Ќе подлежит диспансерному наблюдению'
	when dn =4 THEN '4 - сн€т по причине выздоровлени€'
	when dn =6 THEN '6- сн€т по другим причинам'
	end [днаблюдение]	
	 
		
  ,count(zs.id) [количество]		
		
		
		
FROM [D3_SCHET_OMS] sch                  		
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 		
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 		
left join v017 on v017.IDDR=zs.RSLT_D		
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION		
where sch.CODE_MO=460026					
	and sch.year=2024 and sch.month=4
	and zs.OS_SLUCH_REGION in(47,49) -- ƒ¬Ќ 1 эт	
	and isnull(zs.PR_NOV,0)=0 --подано впервые	
		
	group by   o.[NameWithID] 	
		
 , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <66 then 'трудоспособные'		
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=66 then 'старше трудоспособного' 
	 end	
	, left(s.ds1,3)	
	, dn	
		
	order by  o.[NameWithID] 	
		

