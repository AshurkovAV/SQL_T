Select distinct

--s.iddokt,u.CODE_MD
 sch.SchetType as [��� �����],sch.month, zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,sch.month as [�����]
  ,sch.YEAR[���]
  ,case when p.smo like '46%' then p.smo else '46' end as [����������]
 , p.SMO as [��������� ��������]
  , p.fam,p.im,isnull(p.ot,'') ot
 ,p.W as [���]
  ,p.DR 
   , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  when p.DOCTYPE=3 then '��-�� � ��������'
  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  , p.NPOLIS as [�����]
  , p.SNILS as [�����]
  , zs.DATE_Z_1 [���� ������]
  , zs.DATE_Z_2 [���� ���������]
  -- , zs.VIDPOM as [��� ������]
  --, zs.USL_OK as [������� �������� ���. ������],

  --zs.id, zs.SUMV as [��������� ��������� ���. ������]
  --,zs.RSLT AS [���������]
  --, zs.ISHOD
 -- ,zs.PR_NOV [������� ����������]
 --, count (u.id)
 --, cast(u.id as varchar) + ','
,u.code_usl
-- , s.iddokt, u.CODE_MD
--,zs.ishod
 ,u.VID_VME
--,ms.tarif [tarif �� �����������],u.tarif [tarif � ������], ms.profil, ms.prvs, ms.for_pom, ms.ishod, ms.rslt--, ms.p_cel25
-- ms.idsp
  --,zs.d3_scid
  --,p.d3_scid
  --,idsp
 -- , sump, oplata, u.*
  -- , s.NHISTORY as [����� �������]
  --, s.PODR as [�������������]
, t.schet_id,t.month
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.month=3
 AND sch.YEAR=2022  
 --and sch.id in (4175,4176)
    join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
							left join (Select distinct

							--s.iddokt,u.CODE_MD
							 sch.SchetType as [��� �����],sch.id as schet_id,sch.month, zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
							,sch.month as [�����]
							  ,sch.YEAR[���]
							  ,case when p.smo like '46%' then p.smo else '46' end as [����������]
							 , p.SMO as [��������� ��������]
							  , p.fam,p.im,isnull(p.ot,'') ot
							 ,p.W as [���]
							  ,p.DR 
							   , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
							  when p.DOCTYPE=3 then '��-�� � ��������'
							  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
							  , p.NPOLIS as [�����]
							  , p.SNILS as [�����]
							  , zs.DATE_Z_1 [���� ������]
							  , zs.DATE_Z_2 
							  -- , zs.VIDPOM as [��� ������]
							  --, zs.USL_OK as [������� �������� ���. ������],

							  --zs.id, zs.SUMV as [��������� ��������� ���. ������]
							  --,zs.RSLT AS [���������]
							  --, zs.ISHOD
							 -- ,zs.PR_NOV [������� ����������]
							 --, count (u.id)
							-- , cast(u.id as varchar) + ','
							,u.code_usl
							-- , s.iddokt, u.CODE_MD
							--,zs.ishod
							 ,u.VID_VME
							--,ms.tarif [tarif �� �����������],u.tarif [tarif � ������], ms.profil, ms.prvs, ms.for_pom, ms.ishod, ms.rslt--, ms.p_cel25
							-- ms.idsp
							  --,zs.d3_scid
							  --,p.d3_scid
							  --,idsp
							 -- , sump, oplata, u.*
							  -- , s.NHISTORY as [����� �������]
							  --, s.PODR as [�������������]

							FROM [D3_SCHET_OMS] sch                  
							 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
							 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
							 AND sch.month<3
							 AND sch.YEAR=2022  
							 --and sch.id in (4175,4176)
								join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
							  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


							join V009 rz on rz.IDRMP=zs.RSLT
							left join F011 doc on doc.Id=p.DOCTYPE
							LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
							--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
							--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
							JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036') t
							on t.fam = p.fam AND t.im = p.im AND t.ot = p.ot AND p.dr=t.dr AND t.DATE_z_2=zs.date_z_2	