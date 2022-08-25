DECLARE @ReestrMedOrgID INT
SET @ReestrMedOrgID = 61

SELECT SUM(CASE WHEN Q LIKE '46%' THEN 1 ELSE 0 END) 'Количество местных',
	   SUM(CASE WHEN Q NOT LIKE '46%' THEN 1 ELSE 0 END) 'Количество иногородних'
	   --SUM(CASE WHEN Q NOT LIKE '46%' THEN ED_COL ELSE 0 END) 'Количество иногородних'
FROM(
SELECT pv.FAM, pv.IM, pv.Ot, pv.DR, pv.Q
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.ConditionHelp = 3
AND pv.Profil IN (86,89,90)
AND pv.UserId IS NOT NULL 
AND (isdeleted IS NULL OR isdeleted = 0)
GROUP BY pv.FAM, pv.IM, pv.Ot, pv.DR, pv.Q) AS t

SELECT sum(pv.ED_COL),COUNT(*)
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND pv.ConditionHelp = 3
AND pv.Profil IN (86,89,90)
AND pv.UserId IS NOT NULL 
AND (isdeleted IS NULL OR isdeleted = 0) 
AND pv.Q NOT LIKE '46%'

