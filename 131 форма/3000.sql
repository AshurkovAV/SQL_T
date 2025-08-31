Select DISTINCT	
 o.[NameWithID] [��� ����]	
 ,y.namewithid	[����������� ������]

 	
,count(zs.id) [����������]	
	
	
	
FROM [D3_SCHET_OMS] sch                  	
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id	
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 	
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 	
left join d3_usl_oms usl on usl.D3_SLID=s.id	
 	
left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme	
left join [OsobSluchDb] o on o.Id=zs.OS_SLUCH_REGION	
	
where sch.CODE_MO=460026	
	and sch.year=2025 and sch.month=7
	and zs.OS_SLUCH_REGION in(47,49) -- ��� 1 ��
	and isnull(zs.PR_NOV,0)=0 --������ �������
	AND usl.VID_VME IN ('B04.070.002','B04.047.002')
group by  o.[NameWithID] 	
 ,y.namewithid	
ORDER BY 
[��� ����]