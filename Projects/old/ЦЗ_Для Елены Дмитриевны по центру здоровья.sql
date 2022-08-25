
SELECT 
(SELECT v.NameWithID FROM v005 v WHERE v.ID = p.W) 'Пол', 
YEAR(DR) 'Год рождения',
COUNT(*) 'Кол'
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
WHERE s.SCHET_ID IN (2051, 2053)
AND s.OS_SLUCH_REGION IN (4,5)
GROUP BY p.W, YEAR(dr) 
ORDER BY 'Год рождения'



SELECT 
(SELECT v.NameWithID FROM v005 v WHERE v.ID = pv.W) 'Пол', 
YEAR(DR) 'Год рождения',
COUNT(*) 'Кол'
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID IN (5124)
AND pv.OsobSluch IN (4,5)
GROUP BY pv.W, YEAR(pv.dr) 
ORDER BY 'Год рождения'