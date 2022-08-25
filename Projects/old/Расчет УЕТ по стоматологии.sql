DECLARE @schetid INT = 1044
DECLARE @tab TABLE (
id INT,
ed_col NUMERIC(5,2)    
)
 
INSERT INTO @tab(Id, ed_col)
SELECT s.Id, SUM(ISNULL(mus.uet, 0) * CASE WHEN u.KOL_USL IS NULL OR u.KOL_USL = 0 THEN 1 ELSE u.KOL_USL END)
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
INNER JOIN USL AS u ON u.SLID = s.ID
LEFT JOIN MappingUslStomat mus ON mus.kod_usl = u.CODE_USL
WHERE s.IDSP = 9 --AND mus.uet IS null
AND s.SCHET_ID = @schetid
AND s.DATE_2>='20170215'
GROUP BY s.id
 
UPDATE SLUCH SET ED_COL = t.ed_col
FROM SLUCH AS pv
JOIN @tab t ON t.id = pv.id
WHERE pv.Idsp = 9 AND SCHET_ID = @schetid

DECLARE @tab1 TABLE (
id INT,
ed_col NUMERIC(5,2)    
)
 
INSERT INTO @tab1(Id, ed_col)
SELECT s.Id, SUM(ISNULL(mus.uet, 0) * CASE WHEN u.KOL_USL IS NULL OR u.KOL_USL = 0 THEN 1 ELSE u.KOL_USL END)
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
INNER JOIN USL AS u ON u.SLID = s.ID
LEFT JOIN MappingUslStomat_old mus ON mus.kod_usl = u.CODE_USL
WHERE s.IDSP = 9 --AND mus.uet IS null
AND s.DATE_2<'20170215' AND s.SCHET_ID = @schetid
GROUP BY s.id
 
UPDATE SLUCH SET ED_COL = t.ed_col
FROM SLUCH AS pv
JOIN @tab1 t ON t.id = pv.id
WHERE pv.Idsp = 9 AND SCHET_ID = @schetid