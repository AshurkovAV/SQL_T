--UPDATE zs SET sump=NULL

Select zs.NPR_MO, f003.nam_mok,  
case when p.smo like '46%' then p.smo else '46' end as [����������]
 , p.SMO as [��������� ��������],
 p.fam+' '+p.im+' '+isnull(p.ot,'') as [���]
,case when p.W=1 THEN  '�' else '�' end as [���]
  ,p.DR as [���� ��������]
  , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  when p.DOCTYPE=3 then '��-�� � ��������'
  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  , p.SNILS as [�����]
    , p.NPOLIS as [�����]
    , zs.VIDPOM as [��� ������]
    , zs.USL_OK as [������� �������� ���. ������]
    , s.DS1 as [������� � ������������ � ���-10]
     , zs.DATE_Z_1 [���� ������]
  , zs.DATE_Z_2 [���� ���������]
      , v002.NameWithID [������� ��� ������]
      ,v021.NameWithID [������������� �����]
      , rz.NameWithID as [��������� ��������� �� ��� �������]
       , s.tarif [����� �� ������ ��� ������]
      , zs.SUMV as [��������� ��������� ���. ������]
      
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.month=2
 AND sch.YEAR=2023  and   sch.id in (9572,9456)

join V009 rz on rz.IDRMP=zs.RSLt
LEFT JOIN D3_SL_OMS AS s ON s.D3_ZSLID=zs.ID
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN v002 ON v002.IDPR=s.profil
LEFT JOIN v021 ON v021.IDSPEC=s.PRVS
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
