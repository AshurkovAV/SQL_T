--42000, 66000,  29000,  70000,  15000, 46000,24000, 82000				
Select DISTINCT				
 sch.YEAR[���]				
--,sch.month as [�����]				
,CASE WHEN f002.tf_okato  in (35000) THEN '����' ELSE [name_tfp]	end			
, s.podr,
k.name,case when zs.vidpom=32 then '���' else '�� ���' end vidpom,s.nhistory,						
	case when  Ksg.N_KSG is not null then   Ksg.N_KSG 										
	else v018.hvidname										
	end namess
		
--,count(zs.id) [����������]				
-- ,sum(sumv) [�����] 				
 -- ,case when p.smo like '46%' then p.smo else '46' end as [����������]				
 --, p.SMO as [��������� ��������]				
 -- , p.fam+' '+p.im+' '+isnull(p.ot,'') as [���]				
 --,p.W as [���]				
 -- ,p.DR as [���� ��������]				
 --  , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'				
 -- when p.DOCTYPE=3 then '��-�� � ��������'				
 -- else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]				
 -- , p.NPOLIS as [�����]				
 -- , p.SNILS as [�����]				
 -- , zs.DATE_Z_1 [���� ������]				
 -- , zs.DATE_Z_2 [���� ���������]				
 --  , zs.VIDPOM as [��� ������]				
 -- , zs.USL_OK as [������� �������� ���. ������]				
				
 -- , zs.SUMV as [��������� ��������� ���. ������]				
 -- ,zs.RSLT AS [���������]				
 -- , rz.RMPNAME as [��������� ��������� �� ��� �������]				
 -- ,zs.PR_NOV [������� ����������]				
				
				
 -- ,zs.d3_scid				
 -- ,p.d3_scid				
  --,idsp				
  -- , s.NHISTORY as [����� �������]				
  --, s.PODR as [�������������]				
  -- , s.DS1 as [������� � ������������ � ���-10]				
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 		
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
    left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
     left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20211231')		
left join f002 on f002.[smocod]=p.smo 				
		left join [dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
	left join v006 on v006.IDUMP=zs.USL_OK			
	left join f001 on f001.tf_okato=f002.tf_okato
	   left join KOKOD_OTD k on k.kod_otd=s.podr	
	 	
	left join[V019] v019 on cast(v019.IDHM as int)=s.metod_hmp  											
				   --------------------------------� 21 ����----------------							
				                              and 							
											cast(case when year(zs.date_z_2)=2020 then v019.IDMODP else  s.MP_HMP end as nvarchar) =cast(v019.IDMODP as nvarchar)
											and s.VID_HMP=HVID
											-- ����� ���-- ����� ���
									   AND zs.DATE_z_2>=v019.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v019.dateend,'21000101')			
									    left join v018 v018 on v019.HVID=V018.idhvid                                 -- ��� ���							
									   AND zs.DATE_z_2>=V018.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v018.dateend,'21000101')					   		
where f002.tf_okato not in (38000)--(42000, 66000,  29000,  70000,  15000, 46000,24000, 82000)				
--and sankk.id is null	
 and sch.id in  (Select 
						--sch.month,nschet,
						id

						FROM [D3_SCHET_OMS] sch  
						WHERE YEAR=2021 AND (nschet LIKE '�������' or nschet LIKE '%����%')
			)			
			AND zs.USL_OK=1