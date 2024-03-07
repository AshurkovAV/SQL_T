Select DISTINCT			
 o.[NameWithID] [��� ����]			
 , case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 18 and 34 then '18-34'			
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 35 and 39 then '35-39' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 40 and 55 then '40-55'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 56 and 60 then '56-60'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 61 and 65 then '61-65'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 66 and 75 then '66-75'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)>=76 then '76 � ������' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=56 and p.w=2 then '56 �������'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=61 and p.w=1 then '61 �������'  
   else cast(P.DR AS VARCHAR) END [�������]
 --,zs.id			
  ,p.W as [���]			
  ,count(zs.id) [����������]			
  --,[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) [�������]			
	--, s.ds1	[������� � ������������ � ���-10]	
 --, usl.code_usl			
 --,y.namewithid	[����������� ������]		
			
			
FROM [D3_SCHET_OMS] sch                  			
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id			
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 			
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 			
--left join d3_usl_oms usl on usl.D3_SLID=s.id			
 			
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme			
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION			
where sch.CODE_MO=460026			
	 and sch.year=2024 and sch.month=2
	and zs.OS_SLUCH_REGION in(47,49) -- ��� 1 ��		
	and isnull(zs.PR_NOV,0)=0 --������ �������		
	group by o.[NameWithID],  case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 18 and 34 then '18-34'			
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 35 and 39 then '35-39' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 40 and 55 then '40-55'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 56 and 60 then '56-60'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 61 and 65 then '61-65'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 66 and 75 then '66-75'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)>=76 then '76 � ������' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=56 and p.w=2 then '56 �������'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=61 and p.w=1 then '61 �������' 
			  else cast(P.DR AS VARCHAR) END , p.w
			order by o.[NameWithID], case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 18 and 34 then '18-34'			
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 35 and 39 then '35-39' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 40 and 55 then '40-55'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 56 and 60 then '56-60'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 61 and 65 then '61-65'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) between 66 and 75 then '66-75'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)>=76 then '76 � ������' 
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=56 and p.w=2 then '56 �������'
			when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)=61 and p.w=1 then '61 �������' 
			 ELSE cast(P.DR AS VARCHAR) END , p.w
