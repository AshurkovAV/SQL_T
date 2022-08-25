DECLARE @OsobSluch11 INT  = 11
DECLARE @OsobSluch15 INT  = 15
DECLARE @ReestrMedOrgID INT = 5124

SELECT tper.* , 'Перекрест ПО с пер.'
FROM(
SELECT pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE)DR, pv.Q, CAST(pv.HelpStart AS DATE)HelpStart, CAST(pv.HelpEnd AS DATE)HelpEnd, (SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = pv.Doctor) doc                                                     
FROM PacientVisit AS pv
WHERE pv.OsobSluch = @OsobSluch15
AND pv.ReestrMedOrgID = @ReestrMedOrgID) AS tper
INNER JOIN 
(SELECT pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE)DR, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, CAST(pv.HelpEnd AS DATE)HelpEnd, (SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = pv.Doctor) doc                                                     
FROM PacientVisit AS pv
WHERE pv.OsobSluch = @OsobSluch11
AND pv.ReestrMedOrgID IN(@ReestrMedOrgID)) AS tpo  ON tpo.FAM = tper.FAM
AND tpo.IM = tper.IM AND tpo.OT = tper.OT AND CAST(tpo.DR AS DATE) = CAST(tper.DR AS DATE) --AND CAST(tpo.HelpStart AS DATE) = CAST(tper.HelpStart AS DATE)
AND CAST(tpo.HelpEnd AS DATE) = CAST(tper.HelpEnd AS DATE)