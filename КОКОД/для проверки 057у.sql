
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
  ,idsp
  -- , s.NHISTORY as [����� �������]
  --, s.PODR as [�������������]
  -- , s.DS1 as [������� � ������������ � ���-10]

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.month=9
 AND sch.YEAR=2023
--and   sch.id in (3744,3755,3756)
--AND sch.ID IN (686, 688, 682)

join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
--order by schettype
WHERE p.SMO NOT LIKE '46%' AND  (zs.USL_OK IN (1,2) OR idsp = 28)
--where --zs.usl_ok=1 and sumv=33376.23
--(zs.sumv=32548.3 and zs.usl_ok=2)


and usl_ok=1
--order by sumv
--where zs.pr_nov=1 --and p.smo not like '46%'