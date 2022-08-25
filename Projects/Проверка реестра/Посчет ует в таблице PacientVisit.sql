--SELECT *--pv.Id, SUM(ISNULL(mus.uet ,1) * ISNULL(u.KolUslugi, 1))
--, mus.uet, u.KolUslugi--SUM(ISNULL(mus.uet, 1))
--UPDATE PacientVisit SET ED_COL = SUM(ISNULL(mus.uet ,1) * ISNULL(u.KolUslugi, 1))
DECLARE @ReestrMedOrgID INT = 5104
DECLARE @tab TABLE (
id INT,
ed_col NUMERIC(5,2)	
)

INSERT INTO @tab(Id, ed_col)
SELECT pv.Id, SUM(ISNULL(mus.uet, 0) * CASE WHEN u.KolUslugi IS NULL OR u.KolUslugi = 0 THEN 1 ELSE u.KolUslugi END)
FROM PacientVisit AS pv
LEFT JOIN Uslugi AS u ON u.SluchID = pv.id
LEFT JOIN MappingUslStomat mus ON mus.kod_usl = u.CodUslugi
WHERE pv.ReestrMedOrgID=@ReestrMedOrgID
AND pv.Idsp = 9-- AND pv.id = 2946191
GROUP BY pv.id

--SELECT *FROM @tab

UPDATE PacientVisit SET ED_COL = t.ed_col
FROM PacientVisit AS pv
JOIN @tab t ON t.id = pv.id
WHERE pv.ReestrMedOrgID=@ReestrMedOrgID
AND pv.Idsp = 9

 