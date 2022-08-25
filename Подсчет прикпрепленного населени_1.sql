SELECT COUNT(*)
FROM ATTP_People AS ap
WHERE ap.PrMo = 460006 AND ap.[Active] = 1 AND ap.Ds IS NULL


SELECT *
FROM F003 AS f
WHERE f.mcod LIKE '46%' AND f.nam_mok LIKE '%7%'