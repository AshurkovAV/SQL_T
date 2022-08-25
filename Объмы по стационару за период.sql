SELECT t.uslok, t.smo, SUM(t.Количество)Количество, SUM(t.sumv)sumv, 
(SELECT v.NameWithID FROM v002 v WHERE v.Id = t.PROFIL) profil, 
(SELECT mos.IDDS + '   ' + mos.DS_NAME
   FROM M001_oplata_status AS mos WHERE mos.IDDS =  t.DS1)
FROM(
SELECT 
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = USL_OK)uslok,  

CASE WHEN smo LIKE '46%' THEN (SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = smo) ELSE 'ТФОМС' END smo, 
COUNT(*) [Количество], SUM(Койкодни)Койкодни, SUM(sumv)sumv, t.PROFIL, t.DS1
FROM(
SELECT sl.USL_OK, p.SMO, CASE WHEN sl.usl_ok = 1 THEN DATEDIFF(DAY,sl.date_1, sl.date_2) ELSE DATEDIFF(DAY,sl.date_1, sl.date_2) + 1  END
AS Койкодни, sl.SUMV, sl.PROFIL, sl.DS1
FROM SLUCH AS sl
JOIN D3_SCHET_OMS AS dso ON sl.SCHET_ID = dso.ID
JOIN PACIENT AS p ON p.ID = sl.PID 
WHERE sl.SCHET_ID IN (2127,2129,2136,2137,2141,2142,2146,2147,2152,2153,2155,2156,2159,2160,2162,2168, 2170, 2174, 2176, 2177, 2186, 2187)
AND dso.[MONTH] = MONTH(sl.DATE_2)
) AS t
 
GROUP BY USL_OK, t.PROFIL, t.SMO, t.DS1
UNION

SELECT 
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = USL_OK)uslok, 
CASE WHEN smo LIKE '46%' THEN (SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = smo) ELSE 'ТФОМС' END smo, 
COUNT(*) [Количество], SUM(Койкодни)Койкодни, SUM(sumv)sumv, t.PROFIL, t.DS1
FROM(
SELECT dzo.USL_OK, dpo.SMO, CASE WHEN dzo.usl_ok = 1 THEN DATEDIFF(DAY,dzo.DATE_Z_1, dzo.DATE_Z_2) ELSE DATEDIFF(DAY,dzo.DATE_Z_1, dzo.DATE_Z_2) + 1  END
AS Койкодни, dzo.SUMV, dso1.PROFIL, dso1.DS1
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN (SELECT dso2.D3_ZSLID, dso2.PROFIL, dso2.DS1 FROM D3_SL_OMS AS dso2 GROUP BY dso2.D3_ZSLID, dso2.PROFIL, dso2.DS1) dso1 ON dzo.ID = dso1.D3_ZSLID 
JOIN D3_SCHET_OMS AS dso ON dso.ID = dzo.D3_SCID
WHERE dzo.D3_SCID IN (2127,2129,2136,2137,2141,2142,2146,2147,2152,2153,2155,2156,2159,2160,2162,2168, 2170, 2174, 2176, 2177, 2186, 2187)
AND dso.[MONTH] = MONTH(dzo.DATE_Z_2) AND dzo.USL_OK IN (1,2) AND dzo.PR_NOV = 0
) AS t
 
GROUP BY USL_OK, t.SMO, t.PROFIL, t.DS1) AS t

GROUP BY t.uslok, t.smo, t.PROFIL, t.DS1