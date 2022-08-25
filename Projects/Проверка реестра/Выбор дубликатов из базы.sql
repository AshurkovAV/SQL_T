--Дубликаты по 11  Профилактический осмотр детей I-этап (пр. №1346н)
DECLARE @OsobSluch INT  = 11
DECLARE @ReestrMedOrgID INT = 5124

SELECT t1.*,  t2.HelpStart, 'Дубликат (В ТЕКУЩЕМ РЕЕСТРЕ) ПО детсво' AS per
FROM(
	 SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
                                                     FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS doc	
FROM PacientVisit AS pv
WHERE pv.OsobSluch = @OsobSluch AND pv.ReestrMedOrgID = @ReestrMedOrgID) AS t1
INNER JOIN(
	SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, cast(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
                                                     FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS doc
FROM PacientVisit AS pv
WHERE pv.OsobSluch = @OsobSluch AND pv.ReestrMedOrgID = @ReestrMedOrgID) AS t2 
ON t1.id <> t2.id AND t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND t2.DR = t1.DR
--ORDER BY  t1.FAM, t1.IM, t1.OT, t1.DR

UNION ALL

SELECT t1.*,  t2.HelpStart, 'Дубликат (ПРЕДЫДУЩИЙ МЕСЯЦ) ПО детсво' AS per
FROM(
	 SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, CAST(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
                                                     FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS doc	
FROM PacientVisit AS pv
WHERE pv.OsobSluch = @OsobSluch AND pv.ReestrMedOrgID = @ReestrMedOrgID) AS t1
INNER JOIN(
	SELECT pv.id, pv.FAM, pv.IM, pv.OT, CAST(pv.DR AS DATE) dr, pv.Q, CAST(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
                                                     FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS doc
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
WHERE pv.OsobSluch = @OsobSluch 
AND (r.R_MONTH IN (1, 2, 3, 4, 5, 6,7,8,9,10) AND r.R_YEAR = 2017) 
AND YEAR(pv.dr) NOT IN (2015, 2016, 2017)) AS t2 
ON t1.id <> t2.id AND t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND t2.DR = t1.DR
ORDER BY  t1.FAM, t1.IM, t1.OT, t1.DR