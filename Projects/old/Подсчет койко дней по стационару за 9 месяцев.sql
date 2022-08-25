SELECT Profil, SUM(k_day)k_day
FROM(
SELECT 
(SELECT v3.NameWithID
   from [V002] AS v3 WHERE v3.ID = pv.Profil) Profil, 
   DATEDIFF(DAY, pv.HelpStart, pv.HelpEnd) k_day
From PacientVisit pv
Join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
LEFT JOIN [DoctorBd] AS doc on doc.id = pv.Doctor 
Where pv.ConditionHelp = 1 and 
--r.R_MONTH BETWEEN 1 AND 9 AND 
R.R_YEAR = 2014) AS t
GROUP BY Profil