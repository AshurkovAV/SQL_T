
SELECT nam_mok,[����� ������ ���������],name, COUNT(*) [���������� �����]
FROM
(
Select --sum(sumv)

--s.iddokt,u.CODE_MD
distinct
 sch.NSchet as [��� �����], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,MONTH(zs.date_z_2) as [����� ������ ���������], sch.[MONTH][����� ������ � �����]
 -- ,sch.YEAR[���]
  ,case when p.smo like '46%' then p.smo else '46' end as [����������]   
 , p.SMO as [��������� ��������]
  , p.fam,p.im,isnull(p.ot,'') ot
 ,p.W as [���]
  ,p.DR as [���� ��������]
  -- , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  --when p.DOCTYPE=3 then '��-�� � ��������'
  --else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  , p.NPOLIS as [�����]
  --, p.SNILS as [�����]
  , zs.DATE_Z_1 [���� ������]
  , zs.DATE_Z_2 [���� ���������]
 --  , zs.VIDPOM as [��� ������]
  --, zs.USL_OK as [������� �������� ���. ������],

 --p.fam,  zs.DATE_Z_1 [���� ������]
 -- , zs.DATE_Z_2 [���� ���������],
  ,zs.id-- zs.SUMV as [��������� ��������� ���. ������]
  --,zs.RSLT AS [���������]
 -- , zs.ISHOD
 -- ,zs.PR_NOV [������� ����������]

-- , s.iddokt, u.CODE_MD
--,zs.ishod
-- , u.id
 ,u.code_usl
 ,ms.name
 ,u.VID_VME
 , y.name [fed_kod]

  ,zs.OPLATA, zs.SUMV--, zs.SUMP

 --,	replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') [����������� ���]

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2022  
 --and sch.id in (4137,7074,7075,8235,8236,4357,5379,5380,5513,5596,5602,6855,6856)
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
--WHERE zs.EXP_COMENT LIKE '%code_md%'-- OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%��������� �����%' 
--ms.code_usl IS NULL --AND vid_vme LIKE 'A09.28.009%' 
--OR sumv IS NULL
--ORDER BY vid_vme
--zs.NPR_MO=460026
--u.CODE_MD IS null
WHERE sch.NSCHET NOT LIKE '������ �����' --AND MONTH(zs.DATE_Z_2)=8
--sch.id IN (4137,7074,7075,8235,8236,4357,5379,5380,5513,5596,5602,6855,6856)
AND zs.npr_mo in (460030,460023,460017,460055,460006,460066,460026,460013,460008,460036,460042)
) t
GROUP BY  nam_mok,[����� ������ ���������],NAME
ORDER BY nam_mok,[����� ������ ���������],NAME