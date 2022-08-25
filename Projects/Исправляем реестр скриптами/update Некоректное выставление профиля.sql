declare @p1 int = 5124

--UPDATE pv SET pv.Profil = 68, pv.MSPID = 22
--FROM PacientVisit AS pv
--WHERE pv.ReestrMedOrgID = @p1 AND ((datediff(DAY, DR, pv.HelpEnd)/365.2524 < 18 AND pv.PROFIL = 97 AND pv.ConditionHelp =3))

UPDATE pv SET PROFIL = 97, MSPID = 27
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @p1 AND datediff(DAY, DR, pv.HelpEnd)/365.2524 >= 18 AND pv.Profil = 68 AND pv.ConditionHelp = 3