
Select --DISTINCT
-- sch.SchetType as [��� �����]
--,sch.month as [�����]
--  ,sch.YEAR[���]
  case when p.smo like '46%' then p.smo else '46' end as [����������]
 , p.SMO as [��������� ��������]
  , p.fam+' '+p.im+' '+isnull(p.ot,'') as [���]
 ,p.W as [���]
  ,p.DR as [���� ��������]
  -- , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  --when p.DOCTYPE=3 then '��-�� � ��������'
  --else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  , p.NPOLIS as [�����]
 -- , p.SNILS as [�����]
  , zs.DATE_Z_1 [���� ������]
  , zs.DATE_Z_2 [���� ���������]
  -- , zs.VIDPOM as [��� ������]
 -- , zs.USL_OK as [������� �������� ���. ������]

  , zs.SUMV as [��������� ��������� ���. ������]
 -- ,zs.RSLT AS [���������]
--  , rz.RMPNAME as [��������� ��������� �� ��� �������]
  ,zs.PR_NOV [������� ����������]
  ,zs.id


  --,zs.d3_scid
  --,p.d3_scid
  --,idsp
 , s.NHISTORY as [����� �������]
  --, s.PODR as [�������������]
  -- , s.DS1 as [������� � ������������ � ���-10]

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 AND sch.month=5 AND sch.YEAR=2021  --and sch.id in (2227,2230,2231)
and  sch.id in (2427,2428,2429)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   

join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
where zs.pr_nov=1