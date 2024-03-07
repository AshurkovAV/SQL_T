SELECT DISTINCT --ZSL.D3_SCID
zsl_id,zsl.id, zsl.D3_SCID, duo.id,duo.CODE_USL
FROM
D3_ZSL_OMS zsl  
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = zsl.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE zsl_id IN (
SELECT dzo.zsl_id
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SCHET_OMS AS sch ON sch.ID=dzo.D3_SCID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
LEFT JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE
 --dzo.D3_SCID = 8685--но€брь
-- 9267 --мур
  dzo.IDSP = 28
 AND sch.year=2023 --AND sch.month IN (10,11)
GROUP BY dzo.zsl_id, dso.ID
HAVING COUNT(*) > 1
)
--AND code_USL LIKE 'R01.001.001.001'
ORDER BY zsl_id, ZSL.D3_SCID