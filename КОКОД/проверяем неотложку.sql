Select --sum(sumv)

--s.iddokt,u.CODE_MD
distinct
 sch.NSchet as [��� �����], zs.NPR_DATE, zs.NPR_MO
,sch.month as [�����]
  ,sch.YEAR[���]
  ,case when p.smo like '46%' then p.smo else '46' end as [����������]   
 , p.SMO as [��������� ��������]
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W as [���]
  ,p.DR as [���� ��������]
  -- , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  --when p.DOCTYPE=3 then '��-�� � ��������'
  --else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  , p.NPOLIS as [�����]
  , p.SNILS as [�����]
  , zs.DATE_Z_1 [���� ������]
  , zs.DATE_Z_2 [���� ���������]
   , zs.VIDPOM as [��� ������]
  , zs.USL_OK as [������� �������� ���. ������],

 p.fam,  zs.DATE_Z_1 [���� ������]
  , zs.DATE_Z_2 [���� ���������],
  zs.id, zs.SUMV as [��������� ��������� ���. ������]
  ,zs.RSLT AS [���������]
  , zs.ISHOD

 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=11
 AND sch.YEAR=2024  
 and sch.MONTH=2
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
WHERE s.P_CEL LIKE '1.1'
--OR s.PROFIL=18
  


