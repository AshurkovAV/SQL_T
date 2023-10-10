/* ����� �� ������ ������  */
use elmed
go

DECLARE @d DATETIME = GETDATE()

SELECT 3 gr, dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������� ������� ������� �����, ������� ��������, ������� �����-������, ������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D12.6'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 4 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����� ������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('D12.8', '�62.1')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 5 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������������� ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D13.4'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 6 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����� �������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D37.6'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 7 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������� ������ ������������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'E11%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 8 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������������������� (��� ������ ������ ����������� ����� 8,0 �����/�)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'E78%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 9 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� � ���������� ��' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I10%' OR ds1 LIKE  'I11%' OR ds1 LIKE 'I12%' OR ds1 LIKE 'I13%' OR ds1 LIKE 'I14%' OR ds1 LIKE 'I15%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 10 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I20%' OR ds1 LIKE  'I21%' OR ds1 LIKE 'I22%' OR ds1 LIKE 'I23%' OR ds1 LIKE 'I24%' OR ds1 LIKE 'I25%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 11 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������-������������ (�������������������) ������� � ������� ����� ����� ����� ����, ������ ��������� ������������, ��������� ������, ��������������� ����������, ������ ��������� ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I44%' OR ds1 LIKE  'I45%' OR ds1 LIKE 'I46%' OR ds1 LIKE 'I47%' OR ds1 LIKE 'I49%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 12 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� � (���) ���������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I48%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 13 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� ��������� ��������������� I - II �� �� NYHA, �� �� ���� ������ 2�' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I50%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 14 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ���������� ������ ������� �� 40%' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1= 'I65.2' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 15 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ���������� ��������� ������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'I67.8'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 16 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� ��������������-����, ���������������, ������� ����������������� �������������, �������� �����, ������������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('I69.0','I69.1','I69.2','I69.3','I69.4')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 17 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� ����� ����������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'J12%' OR ds1 LIKE 'J13%' OR ds1 LIKE 'J14%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 18 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� ����������� � ������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('J41.0','J41.1','J41.8')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 19 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���� � ������ ������������� ��������� ������ ����������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J44.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 20 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ���������� ����������� ������������� �������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J44.8'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 21 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���� ������������ ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J44.9'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 22 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
     '������������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('J45.0','J45.1','J45.8','J45.9')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 23 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
     '������������������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J47.0' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR


UNION 

SELECT 24 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���������������� �������� �����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J84.1' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 25 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K20%' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 26 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������������������� ������� � ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K21.0' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 27 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K22.0' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 28 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������������� �������� ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K22.2' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 29 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K22.7' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 30 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������� ������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K25%' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 31 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������� ������� ������������������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K26%' 
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 32 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� ������������ �������, ������������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('K29.4','K29.5')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 33 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ������� � ������������������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'K31.7'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 35 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K50%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 36 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K51%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 37 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('K70.3','K74.3','K74.4','K74.5','K74.6')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 38 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� ���������� � ����������������� ����������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'K86%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 39 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'M81.5'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 40 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� ����� ������������ ���, ��������, ���������� ��� (���������� �� �� ������� � ������), � ���������� ��������� � ��� 1 ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N18.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 41 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��� ������������ ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N18.9'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 42 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN('R73.0','R73.9')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 43 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� �������������� �������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 ='Z95.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 44 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� ���������������� ��������� �������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 ='Z95.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 45 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� ����������� ������������������ �������� � �������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 ='Z95.5'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 100 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������������� ��������������� ���������, ����������������� ��������������� ������ ������ ����������, ����������������� ��������������� ����������,
	  ����������������� ��������������� �������������,����������������� ��������������� ������ ������������ �����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN ('D10.4','D10.5','D10.6','D10.7','D10.9')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 101 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������������� �������� ���' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'D14%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 102 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������������� ��������� ������� ����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D14.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 103 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������������, ���������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D14.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 104 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������������� ��������������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D14.2'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 105 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� �����, ������������, ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'J31%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 106 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����� ����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'J33%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 107 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� �������� � ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'J37%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 108 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����� ��������� ������� � �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'J38.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 47 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� ������ ������������� � ������ ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'E78%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 48 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� ������������� ������� ������ (��� ������� ������ � ������� �������)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I05%' OR ds1 LIKE 'I06%' OR ds1 LIKE 'I07%' OR ds1 LIKE 'I08%' OR ds1 LIKE 'I09%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 49 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������, ����������������� ���������� �������� ���������, ��� ������������ �����������, ������������ � ���������������
	  ������� �(���) � ��������� � �������� �������� �(���) ����������� �������� ����� �4 � ���� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I10%' OR ds1 LIKE 'I11%' OR ds1 LIKE 'I12%' OR ds1 LIKE 'I13%' OR ds1 LIKE 'I14%'  OR ds1 LIKE 'I15%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 50 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� ������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I20%' OR ds1 LIKE 'I21%' OR ds1 LIKE 'I22%' OR ds1 LIKE 'I23%' OR ds1 LIKE 'I24%'  OR ds1 LIKE 'I25%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 51 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '�������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I26%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 52 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� �������� �����������, ������ ������� �������� �������, ������ ��������� �������� �����������, ������ ���������� �����
	  �������-��������� ���������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 = 'I27.0' OR ds1 LIKE 'I28%' OR ds1 = 'I27.2' OR ds1 = 'I27.8')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 53 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ � ��������� ����������. ����������, ������ �� �������, ���������� � ��������� �������� ������ ��� ��������, 
	  ������������������ � ������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I33%' OR ds1 LIKE 'I38%' OR ds1 LIKE 'I39%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 54 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������������� ��������� ����������� �������, ����������� �������, ��������������� �������, ��������� ������� �������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I34%' OR ds1 LIKE 'I35%' OR ds1 LIKE 'I36%' OR ds1 LIKE 'I37%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 55 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ���������. ��������� ��� ��������, ������������������ � ������ ��������. ��������� ������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I40%' OR ds1 LIKE 'I41%' OR ds1 = 'I51.4')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 56 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I42%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 57 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������-������������ (�������������������) ������� � ������� ����� ����� ����� ����, ������ ��������� ������������, ��������� ������,
	  ��������������� ����������, ������ ��������� ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'I44%' OR ds1 LIKE 'I45%' OR ds1 LIKE 'I46%' OR ds1 LIKE 'I47%' OR ds1 LIKE 'I49%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 58 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� � (���) ���������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I48%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 59 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� ���������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I50%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 60 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ����������� ������ �������������, ������ ��������� �����, �� ������������������ � ������ ��������,
	  ������ ���������� �����, �� ������������������ � ������ ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN('I51.0','I51.1','I51.2')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 61 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� � ������ ������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'I65.2'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 62 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� � ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'I71%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 63 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���������� �������� (������ ��������) ������� �������������� (��������� ����� ������������ �������)
	  ���������� �������� (������� ��������) ������� ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND (ds1 LIKE 'Q20%' OR ds1 LIKE 'Q21%' OR ds1 LIKE 'Q22%' OR ds1 LIKE 'Q23%' OR ds1 LIKE 'Q24%' OR ds1 LIKE 'Q25%' OR ds1 LIKE 'Q26%' OR ds1 LIKE 'Q27%' OR ds1 LIKE 'Q28%')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 64 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� �������������� �������� ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'Z95.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION 

SELECT 65 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� �����-����������� ��������� ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'Z95.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 66 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� ������� ���������� �������, ������� ������������ ���������� �������, ������� ������� ����������
	  ���������� �������, ������� ������ ��������� � ���������� ��������� � ��������������, �������
	  ���������� � ����������� �������� � ������������� ������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 IN('Z95.2','Z95.3','Z95.4','Z95.8','Z95.9')
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 67 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� ����������� ���������������� �������� �������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 ='Z95.5'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 124 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������������� ��������������� ��� ������������ ��������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'D39.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 125 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������ ����� ����� � ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 LIKE 'N84%'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 126 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '���������� ����������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N85.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 127 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������������� ����������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N85.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 128 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '��������� ��������� ����� �����, ������������ ������������������ ��������� (CIN) II �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N87.1'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 129 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����� ���������� ��������� ����� �����, �� ������������������ � ������ ��������, ������������ ������������������ ��������� (CIN) III �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N87.2'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 130 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '����������� ����� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'N88.0'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR

UNION

SELECT 131 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
      DS1_PR [� ������� � ����� ������������� ���������], 
      '������� ����������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'
AND ds1 = 'E28.2'
--AND DS1_PR
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, w, dso.DS1_PR




















