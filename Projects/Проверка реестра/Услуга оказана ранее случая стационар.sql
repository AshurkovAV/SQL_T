DECLARE @ReestrMedOrgID INT = 69

SELECT t.OsobSluch, T.id, T.FAM, T.IM, T.OT, CAST(T.DR AS DATE)DR, T.HelpStart, T.HelpEnd, DateStart,DateEnd, 
'Услуга оказана ранее случая стационар' AS com
FROM(
SELECT pv.OsobSluch, pv.id, pv.FAM, pv.IM, pv.OT, pv.DR, CAST(pv.HelpStart AS DATE)HelpStart, CAST(pv.HelpEnd AS DATE)HelpEnd
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rr on pv.ReestrMedOrgID = rr.ID 
WHERE pv.ConditionHelp = 1 AND rr.ID = @ReestrMedOrgID) AS T
INNER JOIN (
SELECT pv.id, pv.FAM, pv.IM, pv.OT, pv.DR, CAST(MIN(u.DateStart)AS DATE)DateStart, CAST(MAX(u.DateEnd)AS DATE)DateEnd
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rr on pv.ReestrMedOrgID = rr.ID 
INNER JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.ConditionHelp = 1 AND rr.ID = @ReestrMedOrgID
GROUP BY pv.id, pv.FAM, pv.IM, pv.OT, pv.DR) AS T1 ON T.id = T1.id
WHERE (T.HelpStart > T1.DateStart OR T.HelpEnd < T1.DateEnd)