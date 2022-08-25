DECLARE @ReestrMedOrgID INT = 5126

SELECT id_sl, 'Пустое поле в услуге', OsobSluch
FROM(
SELECT id id_sl, OsobSluch
FROM PacientVisit AS pv
WHERE pv.OsobSluch IN (1,2,22,15,11,9) AND pv.ReestrMedOrgID = @ReestrMedOrgID --AND pv.id = 1512799
) AS t
LEFT JOIN Uslugi AS u ON u.SluchID = t.id_sl
WHERE id IS NULL