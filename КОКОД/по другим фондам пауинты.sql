--42000, 66000,  29000,  70000,  15000, 46000,24000, 82000				
Select DISTINCT				
 sch.YEAR[���]				
,sch.month as [�����]				
,[name_tfp]				
, v006.UMPNAME			
--,count(zs.id) [����������]				
-- ,sum(sumv) [�����] 				
 -- ,case when p.smo like '46%' then p.smo else '46' end as [����������]				
 , p.SMO as [��������� ��������]				
  , p.fam+' '+p.im+' '+isnull(p.ot,'') as [���]				
 --,p.W as [���]				
 -- ,p.DR as [���� ��������]				
 --  , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'				
 -- when p.DOCTYPE=3 then '��-�� � ��������'				
 -- else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]				
 -- , p.NPOLIS as [�����]				
 -- , p.SNILS as [�����]				
  , zs.DATE_Z_1 [���� ������]				
  , zs.DATE_Z_2 [���� ���������]				
   , zs.VIDPOM as [��� ������]				
  , zs.USL_OK as [������� �������� ���. ������]				
				
  , zs.SUMV as [��������� ��������� ���. ������]				
  ,zs.RSLT AS [���������]				
--  , rz.RMPNAME as [��������� ��������� �� ��� �������]				
  ,zs.PR_NOV [������� ����������]				
				
				
 -- ,zs.d3_scid				
 -- ,p.d3_scid				
  --,idsp				
   , s.NHISTORY as [����� �������]				
  , s.PODR as [�������������]				
   , s.DS1 as [������� � ������������ � ���-10]				
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 	
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 			
left join f002 on f002.[smocod]=p.smo 				
		left join [dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
	left join v006 on v006.IDUMP=zs.USL_OK			
	left join f001 on f001.tf_okato=f002.tf_okato			
where f002.tf_okato in (42000, 66000,  29000,  70000,  15000, 46000,24000, 82000)				
and sank.id is null				
and sch.year=2021				
				
order by [name_tfp]	,sch.YEAR			
,sch.month 				
, v006.UMPNAME				
