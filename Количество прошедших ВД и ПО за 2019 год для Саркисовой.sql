SELECT 
CASE 
	WHEN dso2.[MONTH] = 1 THEN 'Январь'
	WHEN dso2.[MONTH] = 2 THEN 'Февраль'
	WHEN dso2.[MONTH] = 3 THEN 'Март'
	WHEN dso2.[MONTH] = 4 THEN 'Апрель'
	WHEN dso2.[MONTH] = 5 THEN 'Май'
	WHEN dso2.[MONTH] = 6 THEN 'Июнь'
	WHEN dso2.[MONTH] = 7 THEN 'Июль'
	WHEN dso2.[MONTH] = 8 THEN 'Август'
	WHEN dso2.[MONTH] = 9 THEN 'Сентябрь'
	WHEN dso2.[MONTH] = 10 THEN 'Октябрь'
	WHEN dso2.[MONTH] = 11 THEN 'Ноябрь'
	WHEN dso2.[MONTH] = 12 THEN 'Декабрь'
	ELSE 'Что-ло пошло не так' End
, 
COUNT(*), SUM(SUMV)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dzo.D3_SCID IN (2127,2136,2141,2146,2152,2155,2159,2162,2170,2176)
AND dzo.OS_SLUCH_REGION IN (22, 47) AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)
GROUP BY dso2.[MONTH]