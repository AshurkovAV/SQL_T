--������, ������. �������������������� ��������� �1 ��������� ������� ���������� ��������� � 01.04-30.06  
--� ���������� C81.1-C88.4 � ����� �� �� ��������� �� ������ � ������ � �� 50 ���/����� 50 ���.
-- ������ �������� 2211, 2230,2430,2429,2578, 2580.

select sch.id,sch.nschet,month(date_z_2) [����� �������],
k.name
,zs.id,p.fam,p.im,p.ot,p.dr
,case when p.w=1 then '���' else '���' end [���]
,ds1
, case when [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)<50 then '������� �� ������ ������ ������ 50 ���' else '������� �� ������ ������ ������ ��� ����� 50 ���' end [�������]
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and  sch.id IN (2211, 2230,2430,2429,2581)-- or sch.id  IN (1291))
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 left join KOKOD_OTD k on k.kod_otd=s.podr
 where (ds1 between 'C81.1%' and  'C88.4') and s.podr like '460061106006'
 order by p.fam,p.im,p.ot,p.dr