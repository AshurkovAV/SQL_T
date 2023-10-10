/* ����� �� ������ ������  */
use elmed
go

DECLARE @d DATETIME = GETDATE()

SELECT 3 gr, dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������� ������� ������� �����, ������� ��������, ������� �����-������, ������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D12.6'



UNION 

SELECT 4 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����� ������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D12.8', '�62.1')



UNION 

SELECT 5 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������������� ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D13.4'



UNION 

SELECT 6 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����� �������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D37.6'



UNION 

SELECT 7 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������� ������ ������������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'E11%'



UNION 

SELECT 8 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������������������� (��� ������ ������ ����������� ����� 8,0 �����/�)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'E78%'



UNION 

SELECT 9 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� � ���������� ��' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I10%' OR ds1 LIKE  'I11%' OR ds1 LIKE 'I12%' OR ds1 LIKE 'I13%' OR ds1 LIKE 'I14%' OR ds1 LIKE 'I15%')



UNION 

SELECT 10 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I20%' OR ds1 LIKE  'I21%' OR ds1 LIKE 'I22%' OR ds1 LIKE 'I23%' OR ds1 LIKE 'I24%' OR ds1 LIKE 'I25%')



UNION 

SELECT 11 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������-������������ (�������������������) ������� � ������� ����� ����� ����� ����, ������ ��������� ������������, ��������� ������, ��������������� ����������, ������ ��������� ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I44%' OR ds1 LIKE  'I45%' OR ds1 LIKE 'I46%' OR ds1 LIKE 'I47%' OR ds1 LIKE 'I49%')



UNION 

SELECT 12 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� � (���) ���������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I48%'



UNION 

SELECT 13 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� ��������� ��������������� I - II �� �� NYHA, �� �� ���� ������ 2�' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I50%'



UNION 

SELECT 14 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ���������� ������ ������� �� 40%' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1= 'I65.2' 



UNION 

SELECT 15 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ���������� ��������� ������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'I67.8'



UNION 

SELECT 16 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� ��������������-����, ���������������, ������� ����������������� �������������, �������� �����, ������������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('I69.0','I69.1','I69.2','I69.3','I69.4')



UNION 

SELECT 17 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� ����� ����������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'J12%' OR ds1 LIKE 'J13%' OR ds1 LIKE 'J14%')



UNION 

SELECT 18 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ����������� � ������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('J41.0','J41.1','J41.8')



UNION 

SELECT 19 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���� � ������ ������������� ��������� ������ ����������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J44.0'



UNION 

SELECT 20 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ���������� ����������� ������������� �������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J44.8'



UNION 

SELECT 21 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���� ������������ ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J44.9'



UNION 

SELECT 22 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
     '������������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('J45.0','J45.1','J45.8','J45.9')



UNION 

SELECT 23 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
     '������������������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J47.0' 




UNION 

SELECT 24 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������������� �������� �����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J84.1' 



UNION 

SELECT 25 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K20%' 



UNION 

SELECT 26 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������������������� ������� � ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K21.0' 



UNION 

SELECT 27 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K22.0' 



UNION 

SELECT 28 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������������� �������� ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K22.2' 



UNION 

SELECT 29 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K22.7' 



UNION 

SELECT 30 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������� ������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K25%' 



UNION 

SELECT 31 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������� ������� ������������������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K26%' 



UNION 

SELECT 32 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� ������������ �������, ������������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('K29.4','K29.5')



UNION 

SELECT 33 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ������� � ������������������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K31.7'



UNION

SELECT 35 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K50%'



UNION

SELECT 36 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K51%'



UNION

SELECT 37 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('K70.3','K74.3','K74.4','K74.5','K74.6')



UNION

SELECT 38 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� ���������� � ����������������� ����������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'K86%'



UNION

SELECT 39 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'M81.5'



UNION

SELECT 40 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� ����� ������������ ���, ��������, ���������� ��� (���������� �� �� ������� � ������), � ���������� ��������� � ��� 1 ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N18.1'



UNION

SELECT 41 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��� ������������ ' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N18.9'



UNION

SELECT 42 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN('R73.0','R73.9')



UNION

SELECT 43 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� �������������� �������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.0'



UNION

SELECT 44 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ���������������� ��������� �������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.1'



UNION

SELECT 45 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ����������� ������������������ �������� � �������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.5'



UNION

SELECT 47 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� ������ ������������� � ������ ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'E78%'



UNION

SELECT 48 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� ������������� ������� ������ (��� ������� ������ � ������� �������)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I05%' OR ds1 LIKE 'I06%' OR ds1 LIKE 'I07%' OR ds1 LIKE 'I08%' OR ds1 LIKE 'I09%')



UNION

SELECT 49 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������, ����������������� ���������� �������� ���������, ��� ������������ �����������, ������������ � ��������������� ������� �(���) � ��������� � �������� �������� �(���) ����������� �������� ����� �4 � ���� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I10%' OR ds1 LIKE 'I11%' OR ds1 LIKE 'I12%' OR ds1 LIKE 'I13%' OR ds1 LIKE 'I14%'  OR ds1 LIKE 'I15%')



UNION

SELECT 50 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� ������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I20%' OR ds1 LIKE 'I21%' OR ds1 LIKE 'I22%' OR ds1 LIKE 'I23%' OR ds1 LIKE 'I24%'  OR ds1 LIKE 'I25%')



UNION

SELECT 51 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '�������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I26%'



UNION

SELECT 52 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� �������� �����������, ������ ������� �������� �������, ������ ��������� �������� �����������, ������ ���������� ����� �������-��������� ���������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 = 'I27.0' OR ds1 LIKE 'I28%' OR ds1 = 'I27.2' OR ds1 = 'I27.8')



UNION

SELECT 53 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ � ��������� ����������. ����������, ������ �� �������, ���������� � ��������� �������� ������ ��� ��������,  ������������������ � ������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I33%' OR ds1 LIKE 'I38%' OR ds1 LIKE 'I39%')



UNION

SELECT 54 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������������� ��������� ����������� �������, ����������� �������, ��������������� �������, ��������� ������� �������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I34%' OR ds1 LIKE 'I35%' OR ds1 LIKE 'I36%' OR ds1 LIKE 'I37%')



UNION

SELECT 55 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ���������. ��������� ��� ��������, ������������������ � ������ ��������. ��������� ������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I40%' OR ds1 LIKE 'I41%' OR ds1 = 'I51.4')



UNION

SELECT 56 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I42%'



UNION

SELECT 57 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������-������������ (�������������������) ������� � ������� ����� ����� ����� ����, ������ ��������� ������������, ��������� ������, ��������������� ����������, ������ ��������� ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'I44%' OR ds1 LIKE 'I45%' OR ds1 LIKE 'I46%' OR ds1 LIKE 'I47%' OR ds1 LIKE 'I49%')



UNION

SELECT 58 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� � (���) ���������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I48%'



UNION

SELECT 59 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� ���������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I50%'



UNION

SELECT 60 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ����������� ������ �������������, ������ ��������� �����, �� ������������������ � ������ ��������, ������ ���������� �����, �� ������������������ � ������ ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN('I51.0','I51.1','I51.2')



UNION 

SELECT 61 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� � ������ ������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'I65.2'



UNION 

SELECT 62 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� � ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'I71%'



UNION 

SELECT 63 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������� �������� (������ ��������) ������� �������������� (��������� ����� ������������ �������)  ���������� �������� (������� ��������) ������� ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'Q20%' OR ds1 LIKE 'Q21%' OR ds1 LIKE 'Q22%' OR ds1 LIKE 'Q23%' OR ds1 LIKE 'Q24%' OR ds1 LIKE 'Q25%' OR ds1 LIKE 'Q26%' OR ds1 LIKE 'Q27%' OR ds1 LIKE 'Q28%')



UNION 

SELECT 64 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� �������������� �������� ���������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Z95.0'



UNION 

SELECT 65 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� �����-����������� ��������� ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Z95.1'



UNION

SELECT 66 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ������� ���������� �������, ������� ������������ ���������� �������, ������� ������� ���������� ���������� �������, ������� ������ ��������� � ���������� ��������� � ��������������, ������� ���������� � ����������� �������� � ������������� ������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN('Z95.2','Z95.3','Z95.4','Z95.8','Z95.9')



UNION

SELECT 67 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ����������� ���������������� �������� �������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 ='Z95.5'



UNION

SELECT 69 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '����������� �������� ������� � � (���) ����������� �������� ������� �' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('B18.0','B18.1','B18.2')



UNION

SELECT 70 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '�������, ��������� ������� �������������� �������� (���)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'B20%' OR ds1 LIKE 'B21%' OR ds1 LIKE 'B22%' OR ds1 LIKE 'B23%' OR ds1 LIKE 'B24%')


UNION

SELECT 72 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������� ������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D35.0'


UNION

SELECT 73 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������� �������������� ������. ��������� ���������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D35.1','E21.0')


UNION

SELECT 74 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������������� ����������� ���������: ��� 2� (������� ������); ��� 2� (������� �������)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D44.8','D35.0','D35.1','D35.8')


UNION

SELECT 75 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������������� �����������  ���, ������������� ������������ ���, ������������� � ����������� ����������� �����, ������������� � ����������� ������������ �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('E04.1','E04.2','E05.1','E05.2')


UNION

SELECT 76 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '�����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'E22.0'


UNION

SELECT 77 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������ ����������� � ���������� ������������ ���� (�������� ���������� ����� � ��������� �������������� � ����������)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'E34.5'


UNION

SELECT 78 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������������� ����������� ����������, ��� I (���-1, ������� �������)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 IN ('E34.8','D13.7','D35.0','D35.1','D35.2','D35.8')


UNION

SELECT 80 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '���������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q85.1'


UNION

SELECT 82 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '����������������� ��������������� ������� ������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D11%'


UNION

SELECT 83 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������������ ��������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q78.1'


UNION

SELECT 85 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '�������������� ������������������ ��������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D29.1'


UNION

SELECT 86 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '�������������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D30.0'


UNION

SELECT 87 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '���������, ������ �������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D30.3'


UNION

SELECT 88 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '���������, ������ ������������������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D30.4'


UNION

SELECT 89 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������� ����� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'D41.0'


UNION

SELECT 90 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '����������� �������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'N48.0'


UNION

SELECT 92 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '���������� � ������������� �������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D16%'


UNION

SELECT 93 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������������� (���������������, ������� �����)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q78.4'


UNION

SELECT 94 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '��������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'M85%'


UNION

SELECT 95 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '������� ������� (������) ������������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'M88%'


UNION

SELECT 96 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '��������� ������-�������� ������� ����� ����������� �������� �� �����-������������ �������� � ����� � ���������� � ��������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'M96%'


UNION

SELECT 98 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],     
      '����������������� ��������������� ����� � ��� ������������ ��������. ����������������� ��������������� ���� ����, ������� ������ ���' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND dso.P_CEL25 = '3.0'
AND (ds1 LIKE 'D31%' OR ds1 = 'D23.1')


UNION

SELECT 100 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������������� ��������������� ���������, ����������������� ��������������� ������ ������ ����������, ����������������� ��������������� ����������, ����������������� ��������������� �������������,����������������� ��������������� ������ ������������ �����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D10.4','D10.5','D10.6','D10.7','D10.9')


UNION

SELECT 101 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������������� �������� ���' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D14%'


UNION

SELECT 102 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������������� ��������� ������� ����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D14.0'


UNION

SELECT 103 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������������, ���������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D14.1'


UNION

SELECT 104 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������������� ��������������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D14.2'


UNION

SELECT 105 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� �����, ������������, ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'J31%'


UNION

SELECT 106 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����� ����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'J33%'


UNION

SELECT 107 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� �������� � ��������������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'J37%'


UNION

SELECT 108 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����� ��������� ������� � �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'J38.1'


UNION

SELECT 110 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������������� ��������������� ����, ����������������� ��������������� �����, ����������������� ��������������� ��� ��-����� ���, ����������������� ����������-����� ������ ������������ ������ ���' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 IN ('D10.0','D10.1','D10.2','D10.3')


UNION

SELECT 111 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������� ������ ����������, ���������-��� ������������, ������������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K13.0'


UNION

SELECT 112 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� � ������ ��������� �������� ������� ���, ������� ����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K13.2'


UNION

SELECT 113 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ������� ���' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'K13.7'


UNION

SELECT 114 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ������� ����� (������� ����� ��������� ������� ���)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'L43%'


UNION

SELECT 115 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������������ ��������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q78.1'


UNION

SELECT 117 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ��������������� �������, ������� FAMM (�������� ������� ����������� ������������� �������), ������� FAMM (�������� ������� ����������� ������������� ������� � ���������)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D22%'


UNION

SELECT 118 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����� ��������, ������� �������-������, ������� �������, ������� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D23%'


UNION

SELECT 119 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������������ �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'L57.1'


UNION

SELECT 120 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������� ���������� ������� (��� ���������� ��������������� ����)' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'L82%'


UNION

SELECT 121 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������� ���������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q82.1'


UNION

SELECT 122 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������� ���������� � ������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'Q82.5'


UNION

SELECT 124 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������������� ��������������� ��� ������������ ��������� �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'D39.1'


UNION

SELECT 125 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������ ����� ����� � ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'N84%'


UNION

SELECT 126 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '���������� ����������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N85.0'


UNION

SELECT 127 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������������� ����������� ����������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N85.1'


UNION

SELECT 128 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '��������� ��������� ����� �����, ������������ ������������������ ��������� (CIN) II �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N87.1'


UNION

SELECT 129 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����� ���������� ��������� ����� �����, �� ������������������ � ������ ��������, ������������ ������������������ ��������� (CIN) III �������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N87.2'


UNION

SELECT 130 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������� ����� �����' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'N88.0'


UNION

SELECT 131 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '������� ����������� ��������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 = 'E28.2'


UNION

SELECT 133 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������������� ��������������� �������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'D24%'


UNION

SELECT 134 gr,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN '��������'
ELSE '����' END [������],
CASE  WHEN (dpo.W = 2 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 55) OR (dpo.W = 1 AND (DATEDIFF(dd, DR, @d)/365.2524) >= 60) THEN '������ �����������-���� �������� '
      ELSE '�����������-���� ��������' END [������],
       
      '����������������� ��������� �������� ������' [diagnoz]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dz ON dz.D3_PID = dpo.ID
JOIN (SELECT s.D3_ZSLID , s.DS1, s.P_CEL25 FROM D3_SL_OMS s GROUP BY s.D3_ZSLID , s.DS1, s.P_CEL25) AS dso ON dso.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dz.D3_SCID
WHERE dso2.[YEAR] = 2022 AND dso2.NSCHET LIKE '%+%'   AND dso.P_CEL25 = '3.0'
AND ds1 LIKE 'N60%'






















