DECLARE @schetID INT = 2061
DECLARE @tab TABLE (
	id_enp NVARCHAR(16),
	lpu INT
)

SELECT s.ID, p.FAM, p.IM, p.OT, p.DR, 'Отсутствует услуги в стоматологии'
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
LEFT JOIN USL AS u ON u.SLID = s.ID
WHERE s.SCHET_ID = @schetID
AND s.USL_OK = 3 AND s.IDSP = 9 AND u.ID IS NULL

--DELETE FROM SLUCH WHERE id = 3880397


SELECT pv.ID, pv.FAM, pv.IM, pv.OT, pv.DR, 'Отсутствует услуги в стоматологии'
FROM PacientVisit AS pv
LEFT JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.ReestrMedOrgID = 5126
AND pv.ConditionHelp = 3 AND pv.IDSP = 9 AND u.ID IS NULL