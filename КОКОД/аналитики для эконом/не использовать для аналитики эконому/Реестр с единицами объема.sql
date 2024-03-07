--UPDATE zs SET sump=NULL
SELECT [��� �����],  [��������� ��������],[��. �����],COUNT(zslid) [���������� ��� ��], SUM([������� ����������]) [�� ��� ����������],SUM([��������� ��������� ���. ������]) [��������� ��������� ���. ������]
,SUM(CASE WHEN [������� ����������]=1 THEN  [��������� ��������� ���. ������] end) [��������� ����������]
FROM
(
Select --sum(sumv)

DISTINCT sch.id, sch.nschet, zs.id zslid,
 sch.SchetType as [��� �����]
,sch.month as [�����]
  ,sch.YEAR[���]
  ,case when p.smo like '46%' then p.smo else '46' end as [����������]
 , p.SMO as [��������� ��������]
  , p.fam+' '+p.im+' '+isnull(p.ot,'') as [���]
 ,p.W as [���]
  , CAST(dr AS DATE) [���� ��������]
  --,p.DR as [���� ��������]
   , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  when p.DOCTYPE=3 then '��-�� � ��������'
  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  , p.NPOLIS as [�����]
  , p.SNILS as [�����]
  ,CAST (date_z_1 AS DATE) [���� ������]
  --, zs.DATE_Z_1 [���� ������]
  ,CAST(date_z_2 AS DATE) [���� ���������]
  --, zs.DATE_Z_2 [���� ���������]
   , zs.VIDPOM as [��� ������]
  , zs.USL_OK as [������� �������� ���. ������]

  , zs.SUMV as [��������� ��������� ���. ������]
  ,zs.RSLT AS [���������]
  , rz.RMPNAME as [��������� ��������� �� ��� �������]
  ,zs.PR_NOV [������� ����������]
  ,case when (idsp=29 and os_sluch_region is NULL) or os_sluch_region in (56,59,63) then '���������������� ���������' 
        when (idsp=30 and os_sluch_region is NULL) or os_sluch_region in (40,57) then 'o�������� �� �����������' 
        when idsp=28 then ms.name 
        else '�� ���' end '��. �����'


 -- ,zs.d3_scid
  --,p.d3_scid
  ,idsp
  , sump, oplata, isnull(osd.NameWithID,'') os_schuch_name, zs.OS_SLUCH_REGION
   , s.NHISTORY as [����� �������]
  --, s.PODR as [�������������]
  -- , s.DS1 as [������� � ������������ � ���-10]
  ,zs.EXP_COMENT
  ,s.P_CEL25
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.month=5
 AND sch.YEAR=2023  and   sch.id in    (11837--H
                                        ,14895--C
                                        ,14918--���
                                        ,14892--T
                                              )
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 				
        left join d3_usl_oms usl on usl.D3_SLID=s.id
        left join ( select distinct code_usl,name from [medicalServices] WHERE year(dataBegin) = 2022		
--and code_usl in ('R01.001.001','R01.001.001.001','R01.001.002','R01.001.002.001')				
) ms on ms.[code_usl]=usl.code_usl 
join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN OsobSluchDb AS osd ON osd.Id = zs.OS_SLUCH_REGION
LEFT JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND dso.s_tip=1
WHERE dso.id IS NULL
) t 
GROUP BY [��� �����],  [��������� ��������],[��. �����]