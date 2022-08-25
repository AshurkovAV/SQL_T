DECLARE @OsobSluch INT = 22
DECLARE @ReestrMedOrgID INT = 5124

SELECT t1.id, t1.FAM, t1.IM, t1.OT, t1.dr, 
(SELECT db.FAM + ' ' + im + ' ' + ot FROM DoctorBd AS db WHERE db.id = t1.Doctor) doc, t.HelpStart, t1.HelpStart, 'ƒÛ·ÎËÍ‡Ú ¬ƒ (√Œƒ)' AS per
FROM(
SELECT  pv.FAM, pv.IM, pv.OT, pv.DR, pv.Q, CAST(pv.HelpStart AS DATE)HelpStart                                                    
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r ON pv.ReestrMedOrgID = r.ID 
WHERE pv.OsobSluch = @OsobSluch  AND pv.Veteran IS NULL
AND (r.R_YEAR BETWEEN 2014 AND 2017) AND pv.ReestrMedOrgID <> @ReestrMedOrgID) AS t
INNER JOIN (
SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, CAST(pv.HelpStart AS DATE)HelpStart, pv.Doctor                                                    
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
WHERE pv.OsobSluch = @OsobSluch AND pv.Veteran IS NULL) AS t1 
	ON t.FAM = t1.FAM AND t.im = t1.IM AND t.OT = t1.ot AND CAST(t.DR AS DATE) = CAST(t1.dr AS DATE)
LEFT JOIN DoctorBd AS db ON db.id = t1.Doctor
	
UNION

SELECT t1.id, t1.FAM, t1.IM, t1.OT, t1.dr, 
(SELECT db.FAM + ' ' + im + ' ' + ot FROM DoctorBd AS db WHERE db.id = t1.Doctor) doc, t1.HelpStart, t2.HelpStart, 'ƒÛ·ÎËÍ‡Ú ¬ƒ (¬ “≈ ”Ÿ≈Ã –≈≈—“–≈)' AS per
FROM(
	 SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, CAST(pv.HelpStart AS DATE)HelpStart, pv.Doctor	
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID 
WHERE pv.OsobSluch = @OsobSluch AND r.ID = @ReestrMedOrgID) AS t1
INNER JOIN(
	SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, pv.Doctor
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
WHERE pv.OsobSluch = @OsobSluch AND pv.Veteran IS NULL) AS t2 
ON t1.id <> t2.id AND t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND CAST(t2.DR AS DATE) = CAST(t1.DR AS DATE)
ORDER BY  t1.FAM, t1.IM, t1.OT, t1.DR