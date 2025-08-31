-- DROP TABLE ZreestrEkonom092023_sank
 DECLARE @schetTab TABLE (id INT) 

INSERT INTO @schetTab(id)
SELECT id
FROM D3_SCHET_OMS AS dso
WHERE dso.[YEAR] = 2025 AND dso.[MONTH] = 6-- AND dso.NSCHET LIKE '%+%'

 
 DECLARE @d DATETIME = GETDATE()
 DECLARE @uet numeric(10,2)
 SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')
 
 --SELECT *
 --FROM ztemp_sankdop2025
	-- DROP TABLE ztemp_sankdop2025
										 --SELECT *
										 --INTO ztemp_sankdop2025
											--				FROM D3_SANK_OMS AS dso
											--				WHERE s_tip in (10,12) AND dso.S_DATE = '20250814' 
											--				AND  dso.ID IN (
											--								SELECT MAX(s.ID)
											--								FROM D3_SANK_OMS s 
											--								GROUP BY s.D3_ZSLGID)
 
-- DROP TABLE ztemp_sankdop2025
 
 SELECT *
 INTO ZreestrEkonom_sank06025_27
 FROM (
 

 SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV , sc.[YEAR] [���], 
 CASE WHEN sc.[MONTH] IN (1,2,3) THEN '������'
      WHEN sc.[MONTH] IN (4,5,6) THEN '������'
      WHEN sc.[MONTH] IN (7,8,9) THEN '������'
      WHEN sc.[MONTH] IN (10,11,12) THEN '���������' ELSE '���-�� ����� �� ���' END [�������],
 sc.ID[����� �����], zsl.ID [����� ������������ ������],  sl.ID[����� ������], 
 --pa.FAM + ' ' + im + ' ' + ot [�������], 
 pa.FAM, im, ot, 
 CASE WHEN pa.W = 1 THEN '�������' ELSE '�������' END [���],
 CASE 
 	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN '��� 65+'
 	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN '��� 60+'
 ELSE '��� ���������' END [����������],
 CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
 ELSE '����' END [������],	
 (SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [��� ���], 
 pa.NPOLIS [����� ������], pa.DR [���� ���.], DATEDIFF(dd, DR, @d)/365.2524 [������� �� ������ �������], CAST(zsl.DATE_Z_1 AS DATE)[���� �����������], CAST(zsl.DATE_Z_2 AS DATE)[���� �������], CAST(sc.DSCHET AS DATE) [���� �����],
 NULL ksg, NULL [��� ������������������� ����������� ������], '���' [��� ������],
 (SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [��� ������],
 (SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [����� ������],
 (SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [���� ��������� ������],
 NULL [���� ��������� ���������],
 NULL [� ������ ������ ������� �������� �������],	
 NULL [���������������� �� ������ ������� ����������� � ������� ����],	
 NULL [���� �����������],
 NULL [������ ��������������� �����],
 (SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [������� ����������� ��������������], 
 NULL [������� ������������ ����������],
 NULL [������� ��������-�������������],	
 NULL [������� ��������� ���������],	
 NULL [��������� � ��������� ���������],	
NULL [��������� � ��������� �� ������ �����������],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [�������],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [�����],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [��������� ������������],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[��� ���������],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[���� ���������],
NULL [��� ������������],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[��� ������� ������],
CAST(zsl.id AS NVARCHAR(10)) [����� ������� �������],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[���������],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[������������ ������� ������� ������], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [������� �������� ������], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [���������� ��], 
1 [����������], sl.TARIF [�����],
 
zsl.SUMV [����� ������������], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS ��������, 2 OPLATA,
dso.S_SUM [���������], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' ') [������],-- CASE WHEN dso.S_COM LIKE '�������� <18 � ���. ��� <16 � ����%' THEN '�������� <18 � ���. ��� <16 � ����. ������������ ����������� �������' ELSE dso.S_COM END AS [�����������], 
MONTH(zsl.DATE_Z_2) [����� �������], dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
	JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
		JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
				INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
               FROM D3_ZSL_OMS zsl 
					JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
						JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
							JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --� and pa.SMO = @smo
               WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.P_CEL25 != '2.3'
               GROUP by zsl.id)
UNION 

 SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV , sc.[YEAR] [���], 
 CASE WHEN sc.[MONTH] IN (1,2,3) THEN '������'
      WHEN sc.[MONTH] IN (4,5,6) THEN '������'
      WHEN sc.[MONTH] IN (7,8,9) THEN '������'
      WHEN sc.[MONTH] IN (10,11,12) THEN '���������' ELSE '���-�� ����� �� ���' END [�������],
 sc.ID[����� �����], zsl.ID [����� ������������ ������],  sl.ID[����� ������], 
 --pa.FAM + ' ' + im + ' ' + ot [�������], 
 pa.FAM, im, ot, 
 CASE WHEN pa.W = 1 THEN '�������' ELSE '�������' END [���],
 CASE 
 	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN '��� 65+'
 	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN '��� 60+'
 ELSE '��� ���������' END [����������],
 CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
 ELSE '����' END [������],	
 (SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [��� ���], 
 pa.NPOLIS [����� ������], pa.DR [���� ���.], DATEDIFF(dd, DR, @d)/365.2524 [������� �� ������ �������], CAST(zsl.DATE_Z_1 AS DATE)[���� �����������], CAST(zsl.DATE_Z_2 AS DATE)[���� �������], CAST(sc.DSCHET AS DATE) [���� �����],
 NULL ksg, NULL [��� ������������������� ����������� ������], '���' [��� ������],
 (SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [��� ������],
 (SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [����� ������],
 (SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [���� ��������� ������],
 NULL [���� ��������� ���������],
 NULL [� ������ ������ ������� �������� �������],	
 NULL [���������������� �� ������ ������� ����������� � ������� ����],	
 NULL [���� �����������],
 NULL [������ ��������������� �����],
 (SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [������� ����������� ��������������], 
 NULL [������� ������������ ����������],
 NULL [������� ��������-�������������],	
 NULL [������� ��������� ���������],	
 NULL [��������� � ��������� ���������],	
 NULL [��������� � ��������� �� ������ �����������],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [�������],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [�����],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [��������� ������������],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[��� ���������],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[���� ���������],
(SELECT TOP 1 ms.name FROM medicalServices AS ms  WHERE ms.code_usl = duo.CODE_USL AND ms.dataEnd = '20241231')[��� ������������],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[��� ������� ������],
CAST(zsl.id AS NVARCHAR(10)) [����� ������� �������],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[���������],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[������������ ������� ������� ������], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [������� �������� ������], 
CASE WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [���������� ��], 
1 [����������], sl.TARIF [�����],
 
zsl.SUMV [����� ������������], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS ��������, 2 OPLATA,
dso.S_SUM [���������], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' ') [������],-- CASE WHEN dso.S_COM LIKE '�������� <18 � ���. ��� <16 � ����%' THEN '�������� <18 � ���. ��� <16 � ����. ������������ ����������� �������' ELSE dso.S_COM END AS [�����������], 
MONTH(zsl.DATE_Z_2) [����� �������] , dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
	JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
		JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
				JOIN D3_USL_OMS AS duo ON duo.D3_SLID = sl.ID
					INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
               FROM D3_ZSL_OMS zsl 
					JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
						JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
							JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --� and pa.SMO = @smo
               WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.P_CEL25 = '2.3'
               GROUP by zsl.id)

UNION 

SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV, sc.[YEAR] [���], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN '������'
     WHEN sc.[MONTH] IN (4,5,6) THEN '������'
     WHEN sc.[MONTH] IN (7,8,9) THEN '������'
     WHEN sc.[MONTH] IN (10,11,12) THEN '���������' ELSE '���-�� ����� �� ���' END [�������],
sc.ID[����� �����],  zsl.ID [����� ������������ ������], sl.ID[����� ������], 
--pa.FAM + ' ' + im + ' ' + ot [�������], 
pa.FAM, im, ot,
CASE WHEN pa.W = 1 THEN '�������' ELSE '�������' END [���],
CASE 
	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN '��� 65+'
	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN '��� 60+'
ELSE '��� ���������' END [����������],
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],	
(SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [��� ���], 
pa.NPOLIS [����� ������], pa.DR [���� ���.], DATEDIFF(dd, DR, @d)/365.2524 [������� �� ������ �������], CAST(zsl.DATE_Z_1 AS DATE)[���� �����������], CAST(zsl.DATE_Z_2 AS DATE)[���� �������], CAST(sc.DSCHET AS DATE) [���� �����],
NULL ksg, NULL [��� ������������������� ����������� ������], '���' [��� ������],
(SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [��� ������],
(SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [����� ������],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [���� ��������� ������],
NULL [���� ��������� ���������],
NULL [� ������ ������ ������� �������� �������],	
NULL [���������������� �� ������ ������� ����������� � ������� ����],	
NULL [���� �����������],
NULL [������ ��������������� �����],
(SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [������� ����������� ��������������], 
NULL [������� ������������ ����������],
NULL [������� ��������-�������������],	
NULL [������� ��������� ���������],	
NULL [��������� � ��������� ���������],	
NULL [��������� � ��������� �� ������ �����������],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [�������],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [�����],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [��������� ������������],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[��� ���������],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[���� ���������],
NULL [��� ������������],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[��� ������� ������],
CAST(zsl.id AS NVARCHAR(10)) [����� ������� �������],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[���������],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[������������ ������� ������� ������], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [������� �������� ������], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [���������� ��], 
1 [����������],
sl.TARIF [�����], 

CASE WHEN zsl.OS_SLUCH_REGION NOT IN (11, 17, 7) THEN zsl.SUMV
	ELSE CASE WHEN zsl.OS_SLUCH_REGION IN (11,17,7) AND sl.PROFIL IN (68) THEN zsl.SUMV ELSE 0 END
	END [����� ������������], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS ��������, 2 OPLATA,
dso.S_SUM [���������],replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' '),-- CASE WHEN dso.S_COM LIKE '�������� <18 � ���. ��� <16 � ����%' THEN '�������� <18 � ���. ��� <16 � ����. ������������ ����������� �������' ELSE dso.S_COM END AS [�����������],
MONTH(zsl.DATE_Z_2) [����� �������] , dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
JOIN ( SELECT * FROM D3_SL_OMS WHERE id IN (SELECT MAX(dso.id)id
											FROM D3_ZSL_OMS AS dzo
												JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
											WHERE dzo.OS_SLUCH_REGION IS NOT NULL AND dzo.D3_SCID IN (SELECT id FROM @schetTab)
                                            GROUP BY dso.D3_ZSLID, dso.PROFIL
											)) sl ON zsl.ID = sl.D3_ZSLID
	JOIN D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
		JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID 
			INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NOT NULL

UNION


/*******************************************
 * �������� ��������� � ���������
 *******************************************/
 
 SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV, sc.[YEAR] [���], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN '������'
     WHEN sc.[MONTH] IN (4,5,6) THEN '������'
     WHEN sc.[MONTH] IN (7,8,9) THEN '������'
     WHEN sc.[MONTH] IN (10,11,12) THEN '���������' ELSE '���-�� ����� �� ���' END [�������],
sc.ID[����� �����],  zsl.ID [����� ������������ ������], sl.ID[����� ������], 
--pa.FAM + ' ' + im + ' ' + ot [�������], 
pa.FAM, im, ot,
CASE WHEN pa.W = 1 THEN '�������' ELSE '�������' END [���],
CASE 
	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN '��� 65+'
	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN '��� 60+'
ELSE '��� ���������' END [����������],
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],	
(SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [��� ���], 
pa.NPOLIS [����� ������], pa.DR [���� ���.], DATEDIFF(dd, DR, @d)/365.2524 [������� �� ������ �������], CAST(zsl.DATE_Z_1 AS DATE)[���� �����������], CAST(zsl.DATE_Z_2 AS DATE)[���� �������], CAST(sc.DSCHET AS DATE) [���� �����],
NULL ksg, NULL [��� ������������������� ����������� ������], '���' [��� ������],
(SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [��� ������],
(SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [����� ������],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [���� ��������� ������],
NULL [���� ��������� ���������],
NULL [� ������ ������ ������� �������� �������],	
NULL [���������������� �� ������ ������� ����������� � ������� ����],	
NULL [���� �����������],
NULL [������ ��������������� �����],
(SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [������� ����������� ��������������], 
NULL [������� ������������ ����������],
NULL [������� ��������-�������������],	
NULL [������� ��������� ���������],	
NULL [��������� � ��������� ���������],	
NULL [��������� � ��������� �� ������ �����������],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [�������],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [�����],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [��������� ������������],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[��� ���������],
('4.0 ��������� � ���������')[���� ���������],
NULL [��� ������������],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[��� ������� ������],
CAST(zsl.id AS NVARCHAR(10)) [����� ������� �������],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[���������],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[������������ ������� ������� ������], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [������� �������� ������], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [���������� ��], 
1 [����������],
sl.TARIF [�����], zsl.SUMV[����� ������������], 
DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS ��������, 2 OPLATA,
dso.S_SUM [���������], replace(replace(dso.S_COM,char(13),' '), CHAR(10), ' '),--CASE WHEN replace(dso.S_COM,char(13),' ') LIKE '�������� <18 � ���. ��� <16 � ����%' THEN '�������� <18 � ���. ��� <16 � ����. ������������ ����������� �������' ELSE dso.S_COM END AS [�����������],
MONTH(zsl.DATE_Z_2) [����� �������] , dso.S_TIP, dso.S_DATE
from D3_ZSL_OMS zsl 
	join D3_SL_OMS sl on zsl.ID = sl.D3_ZSLID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			join D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID 
				INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.P_CEL25 = '3.0'

UNION ALL

----��������� � ������� ���������
SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV, sc.[YEAR] [���], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN '������'
     WHEN sc.[MONTH] IN (4,5,6) THEN '������'
     WHEN sc.[MONTH] IN (7,8,9) THEN '������'
     WHEN sc.[MONTH] IN (10,11,12) THEN '���������' ELSE '���-�� ����� �� ���' END [�������],
sc.ID[����� �����], zsl.ID [����� ������������ ������],  sl.ID[����� ������], 
--pa.FAM + ' ' + im + ' ' + ot [�������], 
pa.FAM, im, ot,
CASE WHEN pa.W = 1 THEN '�������' ELSE '�������' END [���],
CASE 
	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN '��� 65+'
	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN '��� 60+'
ELSE '��� ���������' END [����������],
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],	
(SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [��� ���], 
pa.NPOLIS [����� ������], pa.DR [���� ���.], DATEDIFF(dd, DR, @d)/365.2524 [������� �� ������ �������], CAST(zsl.DATE_Z_1 AS DATE)[���� �����������], CAST(zsl.DATE_Z_2 AS DATE)[���� �������], CAST(sc.DSCHET AS DATE) [���� �����],
isnull((SELECT TOP 1 sk.NameWithID FROM v023 AS sk WHERE sk.K_KSG = dkko.N_KSG AND sl.DATE_1 >=sk.DATEBEG AND sl.DATE_2<=ISNULL(sk.DATEEND,'20991231')   ), dkko.N_KSG) IDKSG,  
NULL [��� ������������������� ����������� ������], '���' [��� ������],
(SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [��� ������],
(SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [����� ������],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [���� ��������� ������],
NULL [���� ��������� ���������],
NULL [� ������ ������ ������� �������� �������],	
NULL [���������������� �� ������ ������� ����������� � ������� ����],	
NULL [���� �����������],
NULL [������ ��������������� �����],
(SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [������� ����������� ��������������], 
NULL [������� ������������ ����������],
NULL [������� ��������-�������������],	
NULL [������� ��������� ���������],	
NULL [��������� � ��������� ���������],	
NULL [��������� � ��������� �� ������ �����������],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [�������],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [�����],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [��������� ������������],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[��� ���������],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[���� ���������],
NULL [��� ������������],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[��� ������� ������],
CAST(zsl.id AS NVARCHAR(10)) [����� ������� �������],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[���������],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[������������ ������� ������� ������], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [������� �������� ������], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [���������� ��], 
1 [����������], sl.TARIF [�����],
  
zsl.SUMV [����� ������������], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS ��������, 2 OPLATA,
dso.S_SUM [���������], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' '),-- CASE WHEN dso.S_COM LIKE '�������� <18 � ���. ��� <16 � ����%' THEN '�������� <18 � ���. ��� <16 � ����. ������������ ����������� �������' ELSE dso.S_COM END AS [�����������], 
MONTH(zsl.DATE_Z_2) [����� �������] , dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
	JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
		JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
				LEFT JOIN D3_KSG_KPG_OMS AS dkko ON dkko.D3_SLID = sl.ID
					INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
					WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
								   FROM D3_ZSL_OMS zsl 
							  JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
							  JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
							  JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --� and pa.SMO = @smo
								   WHERE zsl.usl_ok IN (1,2)
								   GROUP by zsl.id)


) AS t