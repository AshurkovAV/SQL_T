Select DISTINCT		
 o.[NameWithID] [��� ����]		
		
 , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <66 then '��������������'		
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=66 then '������ ���������������' 
	 end [������� ����������������]	
	, left(s.ds1,3)	[�������]
	, case when dn =1 THEN '1 �������'
	when dn =2 THEN '2 - ����'
	when dn =3 THEN '3  �� �������� ������������� ����������'
	when dn =4 THEN '4 - ���� �� ������� �������������'
	when dn =6 THEN '6- ���� �� ������ ��������'
	end [�����������]	
	 
		
  ,count(zs.id) [����������]		
		
		
		
FROM [D3_SCHET_OMS] sch                  		
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 		
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 		
left join v017 on v017.IDDR=zs.RSLT_D		
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION		
where sch.CODE_MO=460026					
	and sch.year=2024 and sch.month=4
	and zs.OS_SLUCH_REGION in(47,49) -- ��� 1 ��	
	and isnull(zs.PR_NOV,0)=0 --������ �������	
		
	group by   o.[NameWithID] 	
		
 , case when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) <66 then '��������������'		
		when p.w=2 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=61 or p.w=1 and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) >=66 then '������ ���������������' 
	 end	
	, left(s.ds1,3)	
	, dn	
		
	order by  o.[NameWithID] 	
		

