--42000, 66000,  29000,  70000,  15000, 46000,24000, 82000				
Select DISTINCT				
 sch.YEAR[���],
 zs.ID				
--,sch.month as [�����]				
--,CASE WHEN f002.tf_okato  in (35000) THEN '����' ELSE [name_tfp]	end			
, v006.UMPNAME	
, f003.nam_mok	[�� ���� �� �������]		
 				
 -- ,case when p.smo like '46%' then p.smo else '46' end as [����������]				
 --, p.SMO as [��������� ��������]				
 , p.fam+' '+p.im+' '+isnull(p.ot,'') as [���]				
 --,p.W as [���]				
  ,p.DR as [���� ��������]				
 --  , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'				
 -- when p.DOCTYPE=3 then '��-�� � ��������'				
 -- else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]				
 , p.NPOLIS as [�����]				
 -- , p.SNILS as [�����]				
 , zs.DATE_Z_1 [���� ������]				
  , zs.DATE_Z_2 [���� ���������]				
 --  , zs.VIDPOM as [��� ������]				
 -- , zs.USL_OK as [������� �������� ���. ������]				
				
, zs.SUMV as [��������� ��������� ���. ������]				
 -- ,zs.RSLT AS [���������]				
 -- , rz.RMPNAME as [��������� ��������� �� ��� �������]				
 -- ,zs.PR_NOV [������� ����������]				
				
				
 -- ,zs.d3_scid				
 -- ,p.d3_scid				
  --,idsp				
  , s.NHISTORY as [����� �������]				
  --, s.PODR as [�������������]				
 , s.DS1 as [������� � ������������ � ���-10]
 , CASE WHEN (s.p_cel25 LIKE '1.0' ) AND zs.OS_SLUCH_REGION IS NULL THEN '���������'
         when    s.p_cel25 LIKE '3.0' AND zs.OS_SLUCH_REGION IS NULL THEN '���������'
          when    s.p_cel25 LIKE '2.3' AND zs.OS_SLUCH_REGION IS NULL THEN '�����������'
           when   zs.OS_SLUCH_REGION=40 THEN '���������'  
           ELSE '&' END [��� ������]
           
 	, 	v002.PRNAME, ms.name		
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 	
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  left JOIN D3_USL_OMS u ON u.D3_SLID=s.id

LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231')			
left join f002 on f002.[smocod]=p.smo 				
		left join [dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
	left join v006 on v006.IDUMP=zs.USL_OK			
	left join f001 on f001.tf_okato=f002.tf_okato	
	LEFT JOIN v002 ON v002.IDPR=s.profil		
where f002.tf_okato  in (14000)
 and sch.id in  (Select 
						--sch.month,nschet,
						id

						FROM [D3_SCHET_OMS] sch  
						WHERE YEAR=2021 AND (nschet LIKE '�������' or nschet LIKE '%����%')
			)			
			
			AND zs.USL_OK=3
           AND zs.PR_nov=0