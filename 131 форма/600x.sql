Select DISTINCT					
case when p.WORK_STAT = 1 THEN '1   ����������'
when p.WORK_STAT = 2 THEN '2   ������������'
when p.WORK_STAT = 3 THEN '3   ������� ������ ���������'
ELSE '������'
END
  ,count(zs.id) [����������]					
  --,[dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1) [�������]					
	--, s.ds1	[������� � ������������ � ���-10]			
 --, usl.code_usl					
 --,y.namewithid	[����������� ������]				
					
					
FROM [D3_SCHET_OMS] sch                  					
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id					
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 					
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left join v017 on v017.IDDR=zs.RSLT_D		
			
 					
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme					
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION					
where sch.CODE_MO=460026					
	and sch.year=2024 and sch.month=1
	and zs.OS_SLUCH_REGION in(47,49) -- ��� 1 ��				
	and isnull(zs.PR_NOV,0)=0 --������ �������	
GROUP BY p.WORK_STAT