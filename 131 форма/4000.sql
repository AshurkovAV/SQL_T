Select DISTINCT					
 o.[NameWithID] [��� ����]					
 , ddo.DS	[������� � ������������ � ���-10]
				
 , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <56 then '��� ������ 56'					
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >55 then '��� ������ 55' 			
		when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 then '��� ������ 61'			
		when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >60 then '��� ������ 60' end [���_�������]			
 --,zs.id					
 --,p.W as [���]					
  ,count(zs.id) [����������]					
  --,[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) [�������]					
	--, s.ds1	[������� � ������������ � ���-10]			
 --, usl.code_usl					
 --,y.namewithid	[����������� ������]				
					
					
FROM [D3_SCHET_OMS] sch                  					
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id					
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 					
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 					
left JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = s.ID					
 					
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme					
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION					
where sch.CODE_MO=460026					
	and sch.year=2022 and sch.month=4
	and zs.OS_SLUCH_REGION in(47,49) -- ��� 1 ��				
	and isnull(zs.PR_NOV,0)=0 --������ �������				
	AND ddo.DS IS NOT null				
	group by  o.[NameWithID]				
			, ddo.DS	
					
            , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <56 then '��� ������ 56'					
					when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >55 then '��� ������ 55' 
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 then '��� ������ 61'
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >60 then '��� ������ 60' end 
			order by  o.[NameWithID]		
			, ddo.DS	
            , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <56 then '��� ������ 56'					
					when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >55 then '��� ������ 55' 
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 then '��� ������ 61'
					when p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >60 then '��� ������ 60' end 
