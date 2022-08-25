--9   Профилактический осмотр взрослых (пр. №1011н)
DECLARE @OsobSluch INT = 9
DECLARE @ReestrMedOrgID INT = 5126

SELECT t1.*, t.HelpStart, 'Дубликат (ГОД) ПО' AS per
FROM(
SELECT pv.FAM, pv.IM, pv.OT, pv.DR, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
																	FROM DoctorBd AS db WHERE db.id = pv.Doctor) doc                                                     
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID 
WHERE pv.OsobSluch = @OsobSluch 
AND ((r.R_MONTH BETWEEN 2 AND 12 AND r.R_YEAR = 2016) OR (r.R_YEAR = 2017))-- OR (r.R_MONTH BETWEEN 1 AND 11 AND r.R_YEAR = 2017)) 
AND r.ID NOT IN (42, 51)) AS t
INNER JOIN (
SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, 
CAST(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
									  FROM DoctorBd AS db WHERE db.id = pv.Doctor) doc                                                     
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
WHERE pv.OsobSluch = @OsobSluch 
) AS t1 
	ON t.FAM = t1.FAM AND t.im = t1.IM AND t.OT = t1.ot AND t.DR = t1.dr	
 	
UNION

SELECT t1.*,  t2.HelpStart, 'Дубликат (В ТЕКУЩЕМ РЕЕСТРЕ) ПО' AS per
FROM(
	 SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
                                                     FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS doc	
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
WHERE pv.OsobSluch = @OsobSluch) AS t1
INNER JOIN(
	SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
                                                     FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS doc
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
WHERE pv.OsobSluch = @OsobSluch) AS t2 
ON t1.id <> t2.id AND t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND t2.DR = t1.DR
ORDER BY  t1.FAM, t1.IM, t1.OT, t1.DR