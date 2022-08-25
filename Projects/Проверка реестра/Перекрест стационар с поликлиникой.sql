--После объединения реестров
DECLARE @R_MONTH INT = 12
DECLARE @R_YEAR INT = 2017
DECLARE @ReestrMedOrgID INT = 5124

SELECT pv.id, pv.FAM, pv.IM, pv.OT,  CAST(pv.DR AS DATE) dr, pv.typesluch, (SELECT db.FioWithId
																	FROM DoctorBd AS db WHERE db.id = pv.Doctor) doc, 
CAST(pv.HelpStart AS DATE) HelpStart, CAST(pv.HelpEnd AS DATE) HelpEnd,
CAST(stac.DATE_1 AS DATE) AS [stac.HelpStart], CAST(stac.DATE_2 AS DATE) AS [stac.HelpEnd],
'Перекрест стационар с поликлиникой' AS per
FROM(
SELECT pv.FAM, pv.IM, pv.OT, pv.DR, sl.DATE_1, sl.DATE_2
FROM SLUCH AS sl
JOIN PACIENT AS pv ON pv.ID = sl.PID
INNER JOIN SCHET AS s ON s.ID = sl.SCHET_ID 
WHERE sl.USL_OK IN (1, 2)) AS stac
INNER JOIN PacientVisit AS pv ON 
							pv.FAM = stac.FAM AND pv.IM = stac.IM AND pv.OT = stac.OT AND pv.DR = stac.DR							
WHERE pv.ConditionHelp = 3
AND pv.ReestrMedOrgID = @ReestrMedOrgID 
AND CAST(pv.HelpStart AS DATE) BETWEEN CAST(stac.DATE_1 AS DATE) AND CAST(stac.DATE_2 AS DATE)
ORDER BY  pv.typesluch, pv.FAM, pv.IM, pv.OT, pv.DR