SELECT 
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = USL_OK)uslok, 
(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = smo) vidpom, 
CASE WHEN extr = 1 OR extr IS null THEN 'Плановая' ELSE 'Экстренная' END,
COUNT(*) [Количество], SUM(Койкодни)Койкодни, SUM(sumv)sumv
FROM(
SELECT sl.USL_OK, p.SMO, CASE WHEN sl.usl_ok = 1 THEN DATEDIFF(DAY,sl.date_1, sl.date_2) ELSE DATEDIFF(DAY,sl.date_1, sl.date_2) + 1  END
AS Койкодни, isnull(sl.EXTR, 1)EXTR, sl.SUMV
FROM SLUCH AS sl
JOIN D3_SCHET_OMS AS dso ON sl.SCHET_ID = dso.ID
JOIN PACIENT AS p ON p.ID = sl.PID 
WHERE sl.SCHET_ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)
AND dso.[MONTH] = MONTH(sl.DATE_2)
) AS t
 
GROUP BY USL_OK, t.EXTR, t.SMO