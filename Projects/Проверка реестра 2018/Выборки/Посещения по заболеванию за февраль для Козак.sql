DECLARE @p INT = 2092
DECLARE @countPos INT = 0;
DECLARE @countObr INT = 0;
DECLARE @countPosObr INT = 0;

SELECT
CASE WHEN (SELECT v.NameWithID FROM V025 AS v WHERE v.IDPC = P_CEL25) = '3.0  Обращение по заболеванию'
THEN 'Посещений в обращении' ELSE (SELECT v.NameWithID FROM V025 AS v WHERE v.IDPC = P_CEL25) end
, COUNT(*)  
FROM D3_ZSL_OMS AS dz
JOIN D3_SL_OMS AS ds ON ds.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS sc ON sc.ID = dz.D3_SCID 
WHERE dz.USL_OK = 3 AND dz.D3_SCID = @p AND ds.DET = 1 --AND ds.P_CEL25 IN ('1.0', '1.2') 
GROUP BY P_CEL25 
UNION
SELECT '3.0  Обращение по заболеванию', COUNT(*) 
FROM(
SELECT dz.ID
FROM D3_ZSL_OMS AS dz
JOIN D3_SL_OMS AS ds ON ds.D3_ZSLID = dz.ID
JOIN D3_SCHET_OMS sc ON sc.ID = dz.D3_SCID 
WHERE dz.USL_OK = 3 AND dz.D3_SCID = @p AND ds.P_CEL25 IN ('3.0') AND ds.DET = 1 
GROUP BY dz.ID) AS t

--SELECT @countPos, @countObr, @countPosObr
