DECLARE @OsobSluch INT  = 11
DECLARE @ReestrMedOrgID INT = 5126

SELECT t1.*, 'Неверно выставлен диагноз' AS per
FROM(
SELECT pv.id, pv.FAM, pv.IM, pv.OT, pv.MKB, u.Diagnoz, CAST(pv.DR AS DATE) dr, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
                                                     FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS doc	
FROM PacientVisit AS pv
INNER JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.OsobSluch = @OsobSluch AND pv.ReestrMedOrgID = @ReestrMedOrgID
AND pv.MKB LIKE 'Z%'
AND u.Diagnoz NOT LIKE 'Z%') AS t1
