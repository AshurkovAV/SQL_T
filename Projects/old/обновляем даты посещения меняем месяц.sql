UPDATE PacientVisit SET HelpStart = CONVERT(DATETIME, '201607' + cast( day(pv.HelpStart) AS NVARCHAR(2) )) , HelpEnd = CONVERT(DATETIME,'201607' + cast(day(pv.HelpEnd) AS NVARCHAR(2))) 
FROM pacientvisit AS pv
WHERE pv.ReestrMedOrgID = 85
AND MONTH(pv.HelpStart) = 8 AND MONTH(pv.HelpEnd) = 8 
AND pv.OsobSluch IS null