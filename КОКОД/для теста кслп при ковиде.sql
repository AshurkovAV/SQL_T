Select --sum(sumv)

--DISTINCT
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
 -- ,p.d3_scid
  ,idsp
  , sump, oplata
  ,dsko.IDSL, dsko.Z_SL--, case when zs.FOR_POM=1 THEN 'covid' end
  -- , s.NHISTORY as [����� �������]
  --, s.PODR as [�������������]
  -- , s.DS1 as [������� � ������������ � ���-10]
  , s.NHISTORY, s.DATE_1,u.CODE_USL
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
   join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left JOIN D3_USL_OMS u ON u.D3_SLID=s.id
 LEFT JOIN D3_CONS_OMS AS c ON c.D3_SLID=s.id
 JOIN D3_KSG_KPG_OMS ksg ON ksg.D3_SLID=s.ID
 LEFT JOIN D3_SL_KOEF_OMS AS dsko
          ON dsko.D3_KSGID = ksg.ID
-- and   sch.id in  (10676)
join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
WHERE   sch.month=4
 AND sch.YEAR=2023 
 AND zs.USL_OK=1
 AND (ksg.SL_K=1 OR u.CODE_USL LIKE 'A26.08.008.001')
 --and zs.OS_SLUCH_REGION=40 
 --AND s.DATE_1>='07.04.2023' 
 --AND NOT (c.PR_CONS IS NULL OR c.PR_CONS=0 )
 
ORDER BY s.DATE_1 desc