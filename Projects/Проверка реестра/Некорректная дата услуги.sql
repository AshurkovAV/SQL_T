DECLARE @ReestrMedOrgID INT = 5126

SELECT distinct  pv.id, pv.FAM, pv.IM, pv.OT, cast(u.DateStart AS DATE) DateStart, --pv.ConditionHelp,
CAST(u.DateEnd AS DATE) DateEnd, 'Некорректная дата услуги, дата оканчания раньше чем дата начала' AS com
FROM PacientVisit pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.ConditionHelp IN (1,3) 
AND pv.ReestrMedOrgID = @ReestrMedOrgID
AND (cast(u.DateStart AS date) < cast(pv.HelpStart AS DATE) or cast(u.DateEnd AS DATE) < cast(pv.HelpStart AS DATE)) AND u.UslProv <> 1
--AND (cast(u.DateStart AS date) > cast(u.DateEnd AS DATE)) 
AND pv.id <> 1