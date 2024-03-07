Select --DISTINCT
 sch.SchetType as [��� �����]
,sch.month as [�����]
  ,sch.YEAR[���]
  ,case when p.smo like '46%' then p.smo else '46' end as [����������]
 , p.SMO as [��������� ��������]
  , p.fam+' '+p.im+' '+isnull(p.ot,'') as [���]
 ,p.W as [���]
  ,p.DR as [���� ��������]
   , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  when p.DOCTYPE=3 then '��-�� � ��������'
  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  , p.NPOLIS as [�����]
  , p.SNILS as [�����]
  , zs.DATE_Z_1 [���� ������]
  , zs.DATE_Z_2 [���� ���������]
   , zs.VIDPOM as [��� ������]
  , zs.USL_OK as [������� �������� ���. ������]
  , zs.SUMV as [��������� ��������� ���. ������]
  ,zs.RSLT AS [���������]
  , rz.RMPNAME as [��������� ��������� �� ��� �������]
  ,zs.PR_NOV [������� ����������]


  ,zs.d3_scid
  ,p.d3_scid
  -- , s.NHISTORY as [����� �������]
  --, s.PODR as [�������������]
  -- , s.DS1 as [������� � ������������ � ���-10]

from d3_zsl_oms zs
join D3_PACIENT_OMS p on zs.d3_pid = p.id 
join  [D3_SCHET_OMS] sch on sch.id = zs.d3_scid 

--AND sch.ID IN (686, 688, 682)

join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
--WHERE date_z_2<='20200926'
where zs.d3_scid IN (1247,1248,1258) AND sch.code_mo=460061 AND sch.month=11 AND sch.YEAR=2020
----and zs.RSLT<>105 and 
--(zs.sumv<15150 and zs.usl_ok=1 or zs.sumv<34000 and zs.usl_ok=2)