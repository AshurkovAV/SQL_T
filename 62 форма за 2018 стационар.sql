SELECT 
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = USL_OK)uslok, 
(SELECT v.NameWithID FROM V008 AS v WHERE v.Id = VIDPOM) vidpom, 
CASE WHEN extr = 1 OR extr IS null THEN 'Плановая' ELSE 'Экстренная' END,
COUNT(*) [Количество], SUM(Койкодни)Койкодни, SUM(sumv)sumv
FROM(
SELECT sl.USL_OK, sl.VIDPOM, CASE WHEN sl.usl_ok = 1 THEN DATEDIFF(DAY,sl.date_1, sl.date_2) ELSE DATEDIFF(DAY,sl.date_1, sl.date_2) + 1  END
AS Койкодни, isnull(sl.EXTR, 1)EXTR, sl.SUMV
FROM SLUCH AS sl
WHERE sl.SCHET_ID IN (2057,2059,2060,2061,2071,2077,2083,2092,2095,2111,2115,2119)) AS t
 
GROUP BY USL_OK, VIDPOM, t.EXTR 


--SELECT *, sl.USL_OK, sl.VIDPOM, CASE WHEN sl.usl_ok = 1 THEN DATEDIFF(DAY,sl.date_1, sl.date_2) ELSE DATEDIFF(DAY,sl.date_1, sl.date_2) + 1  END
--AS Койкодни, sl.NNAPR, sl.SUMV
--FROM SLUCH AS sl
--WHERE sl.ID = 6474156