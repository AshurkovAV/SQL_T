
--UPDATE PacientVisit SET TypeHelp = 13
SELECT pv.TypeHelp, COUNT(*)
From PacientVisit pv
Join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
Where 
pv.ConditionHelp = 3 and 
r.R_MONTH in (11) AND R.R_YEAR = 2014
--AND pv.MSPID IN(22, 27)
 --and OsobSluch = 1 
 --AND TypeHelp = 31
--AND [OsobSluch] IN (1, 2, 9, 11, 17)
--(r.R_MONTH >= @M1 and r.R_YEAR >= @Y1) and (r.R_MONTH <= @M2 and r.R_YEAR <= @Y2)
--ReestrMedOrgID IN (999999999)
GROUP BY pv.TypeHelp

[15:26:10] vasilenko_a.s_gb6: update PacientVisit set TypeHelp = 31

 and Profil in (58,68,97)