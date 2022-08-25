SELECT year(dr) as god, COUNT(*) kol

From PacientVisit pv
Join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
--Where pv.ReestID = @p and pv.ConditionHelp = 3
Where 
pv.ConditionHelp = 3 and 
r.R_MONTH in (10) AND R.R_YEAR = 2091
AND [OsobSluch] IN (11,12)
GROUP BY year(dr)