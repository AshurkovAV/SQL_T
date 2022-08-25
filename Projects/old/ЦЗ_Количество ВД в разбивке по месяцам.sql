SELECT 
R_MONTH, 
(SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = pv.Doctor),
COUNT(*)
FROM PacientVisit pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
--LEFT JOIN [DoctorBd] AS doc on doc.id = pv.Doctor
LEFT JOIN [V009] v ON v.IDRMP = pv.HelpResult 
WHERE pv.ConditionHelp = 3 
AND pv.ReestrMedOrgID IN (4100, 5101, 5104, 5107, 5110, 5111, 5113, 5116, 5118,5121) 
AND pv.OsobSluch IN (22) 
AND MONTH(pv.HelpEnd) = r.R_MONTH 
GROUP BY R_MONTH, pv.Doctor
ORDER BY r.R_MONTH
