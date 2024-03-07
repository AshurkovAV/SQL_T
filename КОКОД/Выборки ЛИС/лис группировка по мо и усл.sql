--BEGIN TRAN  --commit tran
--UPDATE s SET iddokt='029-796-491 19'
--UPDATE u SET code_md='029-796-491 19'
--UPDATE u SET u.code_usl='R01.001.030' --u.VID_VME LIKE 'A08.09.011'--1
--UPDATE u SET u.code_usl='R01.001.020' --u.VID_VME LIKE 'A12.05.123'--3
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A12.20.001'--719
--UPDATE u SET u.code_usl='R01.001.010' --u.VID_VME LIKE 'A26.06.033'--13
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A26.19.011'--67
--UPDATE s SET s.ds1 ='Z01.7'
--UPDATE zs SET ISHOD = 304
--UPDATE p SET p.smo='46007'
--UPDATE zs SET sump=NULL

Select --sum(sumv)

--s.iddokt,u.CODE_MD
DISTINCT  sch.NSchet as [��� �����]
          ,sch.month as [�����]
         
,case when p.smo like '46%' then p.smo else '46' end as [����������]
 , p.SMO as [��������� ��������],f003.nam_mok ,ms.name,	u.VID_VME
 , y.name, count(*),SUM(sumv),zs.PR_NOV
 /*
-- sch.NSchet as [��� �����], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok

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
 -- ,zs.PR_NOV [������� ����������]

 , s.iddokt, u.CODE_MD
,zs.ishod
 , u.id
 ,u.code_usl
 ,u.VID_VME
 , y.name
--,replace(zs.EXP_COMENT,'\t','')
--distinct zs.EXP_COMENT
--,ms.tarif [tarif �� �����������],u.tarif [tarif � ������], ms.profil, ms.prvs, ms.for_pom, ms.ishod, ms.rslt--, ms.p_cel25
-- ms.idsp
  --,zs.d3_scid
  --,p.d3_scid
  --,idsp
 -- , sump, oplata, u.*
  -- , s.NHISTORY as [����� �������]
  --, s.PODR as [�������������]
  ,zs.OPLATA, zs.SUMV, zs.SUMP
 --, zs.EXP_COMENT
 */
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2023  
 and sch.id in (11837,12861,13878,14906)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
 JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
--CalcRegUslLis
--WHERE npr_date<>date_2
--WHERE zs.ISHOD<>304
--WHERE zs.ishod<>304 
------ms.ishod<> zs.ishod
--s.IDDOKT IS null
--WHERE p.npolis LIKE '4670050885000154
--WHERE zs.sumv IS NULL --AND u.VID_VME LIKE 'A26.19.011'

--ORDER BY p.npolis,vid_vme, date_in


--SELECT * from medicalServices
			--WHERE zs.EXP_COMENT IS NOT null
				--zs.EXP_COMENT LIKE '% � �����. �������� COVID19 ����������� ��������������� ������%'
				--
				--zs.EXP_COMENT LIKE '%������� � ������ ������ ���� ������ �� ����������, ���� ���������� ������������� ���-10%'
				--OR zs.EXP_COMENT LIKE '%��� - ������������ ���������� ���� DS_ONK ��� �������� �������� Z03.1%'
				--OR zs.EXP_COMENT LIKE '%��������� ��� ���10 �� ���������� ����� � ������ %'*/
--WHERE isnull(sumv,0)=0
--WHERE zs.id=4739311
-- zs.EXP_COMENT LIKE '%����� ������%' OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%��������� �����%'
----ds1 LIKE 'U07%'
--WHERE --oplata=2  
--zs.ishod<>304
--WHERE zs.EXP_COMENT like '��� - ������ �� � ���%'
--WHERE ms.code_usl IS null
GROUP BY sch.NSchet ,sch.month ,p.SMO,f003.nam_mok ,ms.name,	u.VID_VME,zs.PR_NOV
 , y.name