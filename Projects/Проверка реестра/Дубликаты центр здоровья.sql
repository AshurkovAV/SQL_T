DECLARE @reestr INT = 5124

SELECT tab1.id, tab.FAM, tab.IM, tab.OT, tab.DR, tab.HelpStart, tab1.HelpStart
FROM 
(SELECT pv.*
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE rmod.R_YEAR = 2017 AND pv.ReestrMedOrgID != @reestr AND pv.OsobSluch = 4) AS tab
JOIN (SELECT pv.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @reestr AND pv.OsobSluch = 4) AS tab1 
ON tab1.FAM = tab.FAM AND tab1.IM = tab.IM
AND tab1.OT = tab.OT AND tab1.DR = tab.DR

--Только по текущему реестру
SELECT MAX(pv.Id), COUNT(*)
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ReestrMedOrgID = @reestr AND (pv.OsobSluch = 4 )
GROUP BY pv.FAM, pv.IM, pv.OT, pv.DR
HAVING COUNT(*) > 1