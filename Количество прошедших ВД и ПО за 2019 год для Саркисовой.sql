SELECT 
CASE 
	WHEN dso2.[MONTH] = 1 THEN '������'
	WHEN dso2.[MONTH] = 2 THEN '�������'
	WHEN dso2.[MONTH] = 3 THEN '����'
	WHEN dso2.[MONTH] = 4 THEN '������'
	WHEN dso2.[MONTH] = 5 THEN '���'
	WHEN dso2.[MONTH] = 6 THEN '����'
	WHEN dso2.[MONTH] = 7 THEN '����'
	WHEN dso2.[MONTH] = 8 THEN '������'
	WHEN dso2.[MONTH] = 9 THEN '��������'
	WHEN dso2.[MONTH] = 10 THEN '�������'
	WHEN dso2.[MONTH] = 11 THEN '������'
	WHEN dso2.[MONTH] = 12 THEN '�������'
	ELSE '���-�� ����� �� ���' End
, 
COUNT(*), SUM(SUMV)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dzo.D3_SCID IN (2127,2136,2141,2146,2152,2155,2159,2162,2170,2176)
AND dzo.OS_SLUCH_REGION IN (22, 47) AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)
GROUP BY dso2.[MONTH]