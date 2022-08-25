SELECT f.nam_smok, t.*
FROM(
SELECT 
isnull(Q, 46001)q, 
COUNT(*)k
--, R_MONTH
--pv.FAM, pv.IM, pv.OT, '46002   ”–— »… ‘»À»¿À Œ¿Œ "–Œ—ÕŒ-Ã—"', p.CITY, p.UL, p.dom, p.KV
From PacientVisit pv
Join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID <> 42
LEFT JOIN [DoctorBd] AS doc on doc.id = pv.Doctor 
--LEFT JOIN PEOPLE AS p ON p.FAM = pv.FAM AND pv.IM = p.IM AND p.OT = pv.OT AND p.DR = pv.DR
Where pv.ConditionHelp = 1 and 
--r.R_MONTH BETWEEN 11 AND 11 AND 
R.R_YEAR = 2014 
--AND pv.OsobSluch in (11)
GROUP BY pv.Q) AS t
--, R_MONTH
LEFT JOIN f002 f on f.smocod = t.Q
