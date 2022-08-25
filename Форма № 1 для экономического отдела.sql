SELECT DISTINCT p.FAM, p.IM, p.OT, p.DR, 
CASE WHEN zs.VIDPOM IN (11,12) THEN '��������� ������-���������� ������' ELSE '������������������ ����������� ������' END [��� ������],
CASE WHEN s.PROFIL NOT IN (63,85,86,87,88,89,90) THEN '������������ ������' ELSE '�����������������' END [������],
CASE WHEN smo LIKE '46%' THEN '������� �������' ELSE '�����' END [��������]
FROM [D3_SCHET_OMS] sch                  
JOIN D3_PACIENT_OMS p ON p.d3_scid=sch.id --
       AND sch.id IN (2152, 2153) 
JOIN D3_ZSL_OMS zs ON zs.D3_PID = p.id AND ISNULL(zs.MEK_COUNT,0)=0
JOIN D3_SL_OMS s ON s.D3_ZSLID = zs.ID --AND zs.zs.usl_ok IN (1,2)
WHERE (zs.OS_SLUCH_REGION IS NULL OR zs.OS_SLUCH_REGION NOT IN (4,5,7,11,17,9,22,37,38,47,48))
GROUP BY p.FAM, p.IM, p.OT, p.DR, zs.VIDPOM, s.PROFIL, p.SMO

UNION

SELECT DISTINCT p.FAM, p.IM, p.OT, p.DR, 
CASE WHEN zs.VIDPOM IN (11,12) THEN '��������� ������-���������� ������' ELSE '������������������ ����������� ������' END [��� ������],
'������������ ������' [������] ,
CASE WHEN smo LIKE '46%' THEN '������� �������' ELSE '�����' END [��������]
FROM [D3_SCHET_OMS] sch                  
JOIN D3_PACIENT_OMS p ON p.d3_scid=sch.id --
       AND sch.id IN (2152, 2153) 
JOIN D3_ZSL_OMS zs ON zs.D3_PID = p.id AND ISNULL(zs.MEK_COUNT,0)=0
WHERE zs.OS_SLUCH_REGION IN (7,11,17,9,22,37,38,47,48)
GROUP BY p.FAM, p.IM, p.OT, p.DR, zs.VIDPOM, p.SMO

UNION

SELECT p.FAM, p.IM, p.OT, p.DR, 
CASE WHEN s.VIDPOM IN (11,12) THEN '��������� ������-���������� ������' ELSE '������������������ ����������� ������' END [��� ������],
CASE WHEN s.USL_OK = 1 THEN '������������ ������' ELSE '������, ��������� � �������� ������� ����������� ���� �����' END [������],
CASE WHEN smo LIKE '46%' THEN '������� �������' ELSE '�����' END [��������]
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
WHERE s.SCHET_ID IN (2152, 2153)
GROUP BY p.FAM, p.IM, p.OT, p.DR, s.VIDPOM, s.USL_OK, p.SMO





--C ������ ����
DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(2127)
INSERT INTO @schetTab(id)VALUES(2129)
INSERT INTO @schetTab(id)VALUES(2136)
INSERT INTO @schetTab(id)VALUES(2137)
INSERT INTO @schetTab(id)VALUES(2141)
INSERT INTO @schetTab(id)VALUES(2142)
INSERT INTO @schetTab(id)VALUES(2146)
INSERT INTO @schetTab(id)VALUES(2147)
INSERT INTO @schetTab(id)VALUES(2152)
INSERT INTO @schetTab(id)VALUES(2153)

SELECT DISTINCT p.FAM, p.IM, p.OT, p.DR, 
CASE WHEN zs.VIDPOM IN (11,12) THEN '��������� ������-���������� ������' ELSE '������������������ ����������� ������' END [��� ������],
CASE WHEN s.PROFIL NOT IN (63,85,86,87,88,89,90) THEN '������������ ������' ELSE '�����������������' END [������], sch.[MONTH],
CASE WHEN smo LIKE '46%' THEN '������� �������' ELSE '�����' END [��������]
FROM [D3_SCHET_OMS] sch                  
JOIN D3_PACIENT_OMS p ON p.d3_scid=sch.id --
       AND sch.id IN (SELECT id FROM @schetTab) 
JOIN D3_ZSL_OMS zs ON zs.D3_PID = p.id AND ISNULL(zs.MEK_COUNT,0)=0
JOIN D3_SL_OMS s ON s.D3_ZSLID = zs.ID --AND zs.zs.usl_ok IN (1,2)
WHERE (zs.OS_SLUCH_REGION IS NULL OR zs.OS_SLUCH_REGION NOT IN (4,5,7,11,17,9,22,37,38,47,48))
GROUP BY p.FAM, p.IM, p.OT, p.DR, zs.VIDPOM, s.PROFIL, sch.[MONTH], p.SMO

UNION

SELECT DISTINCT p.FAM, p.IM, p.OT, p.DR, 
CASE WHEN zs.VIDPOM IN (11,12) THEN '��������� ������-���������� ������' ELSE '������������������ ����������� ������' END [��� ������],
'������������ ������' [������] , sch.[MONTH],
CASE WHEN smo LIKE '46%' THEN '������� �������' ELSE '�����' END [��������]
FROM [D3_SCHET_OMS] sch                  
JOIN D3_PACIENT_OMS p ON p.d3_scid=sch.id --
       AND sch.id IN (SELECT id FROM @schetTab) 
JOIN D3_ZSL_OMS zs ON zs.D3_PID = p.id AND ISNULL(zs.MEK_COUNT,0)=0
WHERE zs.OS_SLUCH_REGION IN (7,11,17,9,22,37,38,47,48)
GROUP BY p.FAM, p.IM, p.OT, p.DR, zs.VIDPOM, sch.[MONTH], p.SMO

UNION

SELECT p.FAM, p.IM, p.OT, p.DR, 
CASE WHEN s.VIDPOM IN (11,12) THEN '��������� ������-���������� ������' ELSE '������������������ ����������� ������' END [��� ������],
CASE WHEN s.USL_OK = 1 THEN '������������ ������' ELSE '������, ��������� � �������� ������� ����������� ���� �����' END [������] , dso.[MONTH],
CASE WHEN smo LIKE '46%' THEN '������� �������' ELSE '�����' END [��������]
FROM SLUCH AS s
JOIN D3_SCHET_OMS AS dso ON s.SCHET_ID = dso.ID
JOIN PACIENT AS p ON p.ID = s.PID
WHERE s.SCHET_ID IN (SELECT id FROM @schetTab)
GROUP BY p.FAM, p.IM, p.OT, p.DR, s.VIDPOM, s.USL_OK, dso.[MONTH], p.SMO

