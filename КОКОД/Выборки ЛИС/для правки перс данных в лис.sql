--BEGIN TRAN  --commit tran  --rollback tran
--UPDATE s SdET iddokt='029-796-491 19'
--UPDATE u SET code_md='029-796-491 19'
--UPDATE u SET u.VID_VME= 'A26.01.017'--1
--UPDATE u SET u.code_usl='R01.001.030' --u.VID_VME LIKE 'A08.09.011'--1
--UPDATE u SET u.code_usl='R01.001.020' --u.VID_VME LIKE 'A12.05.123'--3
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A12.20.001'--719
--UPDATE u SET u.code_usl='R01.001.010' --u.VID_VME LIKE 'A26.06.033'--13
--UPDATE u SET /*u.code_usl='R01.001.029'*/ u.VID_VME = 'A26.19.001'--67

---UPDATE s SET s.ds1 ='Z01.7'
--UPDATE zs SET ISHOD = 304
--UPDATE p SET p.smo='46007'
--UPDATE zs SET sump=NULL
--UPDATE p SET p.fam='�������'
--UPDATE p SET p.w = 2
--UPDATE p SET p.ot = null  --'����������'
--UPDATE p SET p.im = '����������'
--UPDATE zs SET zs.OS_SLUCH = 2
--UPDATE p SET p.dr = CONVERT(datetime, '1986-03-17T00:00:00.00', 126)      --  17.03.1986


/*
UPDATE p SET  p.npolis='4657200893000129',   --��� - � ���/�� ������ ���� ����:  �4691699770000177, ���: 46007 - ������� ������ �� "��������� �������� "�����-���";
		     p.enp = '4657200893000129'
			 ,p.vpolis = 3
			-- ,p.spolis = '7700000'
			 --,p.dr = CONVERT(datetime, '1951-07-02T00:00:00.00', 126)     -- 


			 --,p.SMO = '46007'
			-- ,p.fam = '���������'
			-- ,p.im = '�������'
			 --,p.ot = '������������'
			--, zs.OS_SLUCH = 2
	*/
			--,p.w = 2
			 --/*
			 --,p.SNILS = '037-846-405-81',
			-- p.DOCTYPE = 14,
			-- p.DOCSER = '42 05',
			-- p.DOCNUM = '254755',
			-- p.DOCDATE = CONVERT(datetime, '2005-12-30T00:00:00.00', 126),       --   30.12.2005			
			-- p.DOCORG = '��� ���������� ������ �. �������'
			 --*/
			--p.dr = CONVERT(datetime, '1955-01-20T00:00:00.00', 126)		 --,p.smo = '46007'
--UPDATE p SET p.im='�������'
--UPDATE p SET p.smo = NULL --'46007' --59734
--UPDATE p SET p.enp = p.npolis    --220
--UPDATE p SET   p.npolis = null,
				--p.enp = null
--UPDATE p SET p.SNILS = '172-507-311 48'
/*UPDATE u set u.VID_VME = 'A12.09.010'
		     ,u.code_usl = 'R01.001.029'*/
/*		     
UPDATE p SET p.vpolis = 3,
			 p.npolis = tmp1.enp
			 ,p.enp = tmp1.enp
			 ,p.smo = tmp1.smo
			 --,p.ot = tmp1.[��������]
			 --,p.fam = tmp1.[�������]
			 --,p.im = tmp1.[���]
*/
--UPDATE p SET p.DOCDATE = NULL

--/*
Select --sum(sumv)

--s.iddokt,u.CODE_MD
DISTINCT
sch.id,
 sch.NSchet as [��� �����], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,sch.month as [�����]
  ,sch.YEAR[���]
  ,case when p.smo like '46%' then p.smo else '46' end as [����������]   
 --, p.SMO as [��������� ��������]
 ,p.VPOLIS, p.SPOLIS, p.NPOLIS, p.enp  --, p.SMO
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W as [���]
       --,tmp1.enp, /*tmp1.smo,*/ tmp1.[��������], tmp1.[�������], tmp1.[���]
  ,p.DR as [���� ��������]
  -- , convert(nvarchar(150),(case when p.DOCTYPE=14  then '������� ��'
  --when p.DOCTYPE=3 then '��-�� � ��������'
  --else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [������ ��������� ��������������� ��������]
  --, p.NPOLIS as [�����]
  --, p.SNILS as [�����]
 -- , zs.DATE_Z_1 [���� ������]
 -- , zs.DATE_Z_2 [���� ���������]
 --  , zs.VIDPOM as [��� ������]
  --, zs.USL_OK as [������� �������� ���. ������],

 --,  zs.DATE_Z_1 [���� ������]
 -- , zs.DATE_Z_2 [���� ���������],
--  zs.id, zs.SUMV as [��������� ��������� ���. ������]
 -- ,zs.RSLT AS [���������]
 -- , zs.ISHOD
 -- ,zs.PR_NOV [������� ����������]

-- , s.iddokt, u.CODE_MD
--,zs.ishod
-- , u.id
,u.code_usl
 ,u.VID_VME
-- , y.name

 -- ,zs.OPLATA, zs.SUMV, zs.SUMP
  ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.OKATOG, p.OKATOP, p.DOCDATE, p.DOCORG
  --,p.VPOLIS 
  --,p.ID
 --, zs.EXP_COMENT
 --,zs.OS_SLUCH
 --,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
 
 --,zs.EXP_COMENT
 
 --,tmp1.enp, tmp1.smo, tmp1.[��������], tmp1.[�������], tmp1.[���]
 --,tmp2.NPOLIS, tmp2.smo, tmp2.[��������], tmp2.�������
--*/
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2023 
 and sch.id in ( /*9591*/  10759  )
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
LEFT  JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	

--inner JOIN tmp_9556_1  tmp1    ON /*tmp1.[�������] = p.FAM AND*/ tmp1.[���] = p.IM  AND  tmp1.[��������] = p.OT /*AND  tmp1.[���� ��������] = p.DR*/ AND  tmp1.[����������� ��] = f003.nam_mok
--inner JOIN tmp_9556_2  tmp2    ON tmp2.[�������] = p.FAM AND tmp2.[���] = p.IM  /*ND  tmp2.[��������] = p.OT*/ /*AND  tmp2.[���� ��������] = p.DR*/ AND  tmp2.[����������� ��] = f003.nam_mok
--inner JOIN tmp_10740  tmp1   ON tmp1.[�������] = p.FAM AND tmp1.[���] = p.IM  AND  tmp1.[��������] = p.OT    --AND tmp1.[����������� ��] = f003.nam_mok 
--INNER JOIN tmp_9591_newENP tmp1   ON tmp1.[�������] = p.FAM  AND tmp1.[���] = p.IM  AND  tmp1.[��������] = p.OT AND tmp1.[����������� ��] = f003.nam_mok
                                                          
									

--CalcRegUslLis
--WHERE npr_date<>date_2
--WHERE zs.ISHOD<>304
--WHERE --zs.ishod<>304 
------ms.ishod<> zs.ishod
--s.IDDOKT IS null
--WHERE  /*p.VPOLIS =3 */ p.enp IS null   --= '4653140891000099'
--WHERE zs.sumv IS NULL --AND u.VID_VME LIKE 'A26.19.011'
--AND p.fam = '�������'
--ORDER BY p.npolis,vid_vme, date_in


--SELECT * from medicalServices
			--WHERE zs.EXP_COMENT IS NOT null
				--zs.EXP_COMENT LIKE '% � �����. �������� COVID19 ����������� ��������������� ������%'
				--
				--zs.EXP_COMENT LIKE '%������� � ������ ������ ���� ������ �� ����������, ���� ���������� ������������� ���-10%'
				--OR zs.EXP_COMENT LIKE '%��� - ������������ ���������� ���� DS_ONK ��� �������� �������� Z03.1%'
				--OR zs.EXP_COMENT LIKE '%��������� ��� ���10 �� ���������� ����� � ������ %'*/
--WHERE isnull(sumv,0)=0
--WHERE --p.fam = '��������'    --, '��������', '�����', '������', '��������' )  
--OR p.fam = '�������� ')
--AND p.w = 1
--p.SMO = ' ' OR p.smo IS null
WHERE --p.fam = '��������'    --OR p.fam = '��������')
  --p.enp IS null
--p.enp = '4655420873000129'
p.npolis IS NULL OR p.npolis = ''		--= '4655420873000129'
 --p.ENP = '0000000000000000'
 --p.ENP is null
--p.enp <> p.NPOLIS
-- AND p.VPOLIS = 3
  --p.ot IS NULL
 --and zs.OS_SLUCH IS null
/*
 p.enp IS NULL
 AND   p.vpolis = 3
  AND p.npolis <> ''
  AND p.npolis IS NOT NULL
   */ 
--and  p.im LIKE '�����%'  
--AND u.VID_VME = 'A11.19.011.001.1'
--AND  p.ot = '����������  '   OR p.ot = '��������  ')
--and p.dr = CONVERT(datetime, '1940-12-03T00:00:00.00', 126) 
--zs.EXP_COMENT LIKE '% ����������� ������ ���; %'
--AND p.w = 2
 --and p.fam IN ('�������������')
 --and  p.im LIKE '����%' --or p.ot = '�����')
 --AND p.w = 1
--and p.ot IN ('����������')     
--AND p.SMO = '46007'
 --AND p.id in (15712062)
 --AND u.VID_VME = 'A26.30.004.001' 
 
--p.npolis = '4689289730000030'
--p.ENP = '4689289730000030'

 --and p.npolis = ''
--zs.EXP_COMENT LIKE ' �� ��������� ������������ ���� ��� ������ VPOLIS � ��������;  ������������ ��� ���%'
--AND p.VPOLIS = 2
--p.fam = '��������'
--AND  p.SNILS IS null
--AND p.ENP IS null
--AND p.smo = ''
--and p.NPOLIS = ''
 -- p.im LIKE '��������'
--and p.ot LIKE '�������'
 --AND u.VID_VME LIKE 'A08.20.012.992'
----ds1 LIKE 'U07%'
----WHERE oplata=2  
--zs.ishod<>304
--and p.w = 1
 --p.NPOLIS IN ('469549972200027',
--'465844087900083',
--'464700848000035',
--'465673836000308',
--'465464088700024')
/*p.npolis IS NOT NULL
AND p.enp IS NULL
AND p.vpolis = 3
AND f003.nam_mok = '���� "������� ����������� �2"'*/
--3552

--rollback tran