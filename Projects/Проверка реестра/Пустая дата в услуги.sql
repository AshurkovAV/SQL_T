DECLARE @ReestrMedOrgID INT = 5126
SELECT DISTINCT pv.id, pv.FAM, pv.IM, pv.OT, 
(SELECT osd.NameWithID
   FROM OsobSluchDb AS osd WHERE osd.Id = pv.OsobSluch)OsobSluch, 'Пустая дата в услуге' per
FROM PacientVisit pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
JOIN Uslugi AS u ON u.SluchID = pv.id --AND u.IsImplemented = 1
WHERE  
pv.ConditionHelp IN (1, 2, 3) AND pv.OsobSluch IN (9,11)
AND pv.ReestrMedOrgID = @ReestrMedOrgID
AND (u.DateStart is null or u.DateEnd is null) 
AND pv.id <> 1