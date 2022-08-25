SELECT pv.MKB, COUNT(*) kol
FROM PacientVisit AS pv
WHERE pv.ConditionHelp = 3
AND pv.ReestrMedOrgID IN (4100, 5101, 5104)
AND pv.Doctor = 756
GROUP BY pv.MKB 

SELECT 
(SELECT v.NameWithID FROM v009 v WHERE v.IDRMP = pv.HelpResult), COUNT(*) kol
FROM PacientVisit AS pv
WHERE pv.ConditionHelp = 3
AND pv.ReestrMedOrgID IN (4100, 5101, 5104)
AND pv.Doctor = 756
GROUP BY pv.HelpResult 