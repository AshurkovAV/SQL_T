BEGIN TRAN --commit tran
DELETE  FROM  u
FROM D3_USL_OMS u
WHERE u.id IN (


SELECT-- DISTINCT sch.id
MAX(DUO.ID)
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SCHET_OMS AS sch ON sch.ID=dzo.D3_SCID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE
 --dzo.D3_SCID = 8684
-- 9267 --мур
 dzo.IDSP = 28
 --AND sch.year=2022 AND sch.month IN (11,12) AND sch.id IN (9114,8909,9113,9260,9260,9257)
 AND sch.year=2023 AND sch.month IN (3) AND sch.id IN (9597)
GROUP BY sch.id,dzo.zsl_id, dso.ID
HAVING COUNT(*) > 1
)
--3225
