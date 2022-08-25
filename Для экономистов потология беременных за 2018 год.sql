SELECT p.FAM [�������], p.IM [���], p.OT [���������], CAST(p.DR AS DATE) [��], 
CAST(sl.DATE_1 AS DATE) [� ���], CAST(sl.DATE_2 AS DATE)[� ����], 
sl.DS1 [���� ����],
sd2.ds [���� �����], 
isnull(sl.TARIF, u.TARIF) [�����],
isnull(sl.SUMV, u.SUMV_USL) [����� ���], u.DIFF_K,
REPLACE((SELECT od.NameWithID FROM OtdelDb AS od WHERE od.Id = u.PODR), '                   ','') [��� ���������],
(SELECT ckt.NameWithID FROM SprKsg AS ckt WHERE ckt.ID = u.IDKSG)[���],
CASE WHEN sl.usl_ok = 1 THEN DATEDIFF(DAY,sl.date_1, sl.date_2) ELSE DATEDIFF(DAY,sl.date_1, sl.date_2) + 1  END
AS ��������--, s.[MONTH]
  FROM [SLUCH] sl
  LEFT JOIN USL AS u ON u.SLID = sl.ID
  INNER JOIN PACIENT AS p ON p.ID = sl.PID
  LEFT JOIN (SELECT SLID, dbo.GROUP_CONCAT_DS(DISTINCT DS, N' , ', 1) DS FROM SLUCH_DS2 GROUP BY SLID)AS sd2  ON sd2.SLID = sl.ID
  JOIN D3_SCHET_oms AS s ON s.ID = sl.SCHET_ID
WHERE 
sl.SCHET_ID in (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119) AND 
--MONTH(sl.DATE_2) = s.[MONTH] 
--������ ������� ���������
CODE_USL = 'TF1.K01.001'
AND u.LPU_1 = 101 
AND u.PODR IN (6)
--��������� ������� ���������

----������ �������������� ��������� �������������
--CODE_USL = 'TF1.K01.001'
--AND u.LPU_1 = 101 AND u.PODR = 8
------��������� �������������� ��������� �������������

------������ �������������� ��������� �������
--CODE_USL = 'TF1.K01.001'
--AND u.LPU_1 = 101 AND u.PODR = 1
----��������� �������������� ��������� �������

--GROUP BY p.FAM, p.IM, p.OT, DR, p.NPOLIS, SMO,DATE_1, DATE_2,sl.DS1,sl.TARIF, sl.SUMV,u.PODR , u.IDKSG --u.LPU_1, sl.KDAY
ORDER BY p.FAM, p.IM, p.OT