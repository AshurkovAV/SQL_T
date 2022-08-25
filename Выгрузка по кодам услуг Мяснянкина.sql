--DECLARE @sc INT = 2057
DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(2898)
INSERT INTO @schetTab(id)VALUES(2899)
INSERT INTO @schetTab(id)VALUES(3036)
INSERT INTO @schetTab(id)VALUES(3037)
INSERT INTO @schetTab(id)VALUES(3038)
INSERT INTO @schetTab(id)VALUES(3039)
INSERT INTO @schetTab(id)VALUES(3040)


DECLARE @d DATETIME = GETDATE()
DECLARE @uet numeric(10,2)
SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')

SELECT zsl.PR_NOV, sc.[YEAR] [���], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN '������'
     WHEN sc.[MONTH] IN (4,5,6) THEN '������'
     WHEN sc.[MONTH] IN (7,8,9) THEN '������'
     WHEN sc.[MONTH] IN (10,11,12) THEN '���������' ELSE '���-�� ����� �� ���' END [�������],
sc.ID[����� �����], zsl.ID [����� ������������ ������],  sl.ID[����� ������], 
--pa.FAM + ' ' + im + ' ' + ot [�������], 
pa.FAM, im, ot,
(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [��� ���], 
pa.NPOLIS [����� ������], pa.DR [���� ���.], DATEDIFF(dd, DR, @d)/365.2524 [������� �� ������ �������], CAST(zsl.DATE_Z_1 AS DATE)[���� �����������], CAST(zsl.DATE_Z_2 AS DATE)[���� �������], CAST(sc.DSCHET AS DATE) [���� �����],
NULL ksg, NULL [��� ������������������� ����������� ������], '���' [��� ������],
(SELECT v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [��� ������],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [���� ��������� ������],
NULL [���� ��������� ���������],
NULL [� ������ ������ ������� �������� �������],	
NULL [���������������� �� ������ ������� ����������� � ������� ����],	
NULL [���� �����������],
NULL [������ ��������������� �����],
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [������� ����������� ��������������], 
NULL [������� ������������ ����������],
NULL [������� ��������-�������������],	
NULL [������� ��������� ���������],	
NULL [��������� � ��������� ���������],	
NULL [��������� � ��������� �� ������ �����������],
(SELECT v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [�������],
(SELECT v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [�����],
(SELECT v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [��������� ������������],
(SELECT f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[��� ���������],
(SELECT v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[���� ���������],
(SELECT v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[��� ������� ������],
CAST(zsl.id AS NVARCHAR(10)) [����� ������� �������],
(SELECT od.NameWithID FROM OtdelDb AS od WHERE od.Id = sl.PODR)[���������],
(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[������������ ������� ������� ������], 
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [������� �������� ������], 
CASE WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12,2)
	 WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4,2) ELSE 1.00 END [���������� ��], 
1 [����������], sl.TARIF [�����],
 
zsl.SUMV [����� ������������], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS ��������,
dso.S_SUM [���������], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' '),-- CASE WHEN dso.S_COM LIKE '�������� <18 � ���. ��� <16 � ����%' THEN '�������� <18 � ���. ��� <16 � ����. ������������ ����������� �������' ELSE dso.S_COM END AS [�����������], 
MONTH(zsl.DATE_Z_2) [����� �������],
(SELECT code_usl + '    ' + m.name FROM medicalServices m WHERE m.code_usl = duo.CODE_USL) 
FROM D3_ZSL_OMS zsl 
JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = sl.ID
LEFT JOIN (
	SELECT *
	FROM D3_SANK_OMS AS dso
	WHERE dso.ID IN (
	SELECT MAX(s.ID)
             FROM D3_SANK_OMS s GROUP BY s.D3_ZSLGID)) AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID AND dso.D3_SCID = zsl.D3_SCID
WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
               FROM D3_ZSL_OMS zsl 
          JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
          JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
          JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --� and pa.SMO = @smo
               WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL 
               GROUP by zsl.id) AND zsl.IDSP = 28






