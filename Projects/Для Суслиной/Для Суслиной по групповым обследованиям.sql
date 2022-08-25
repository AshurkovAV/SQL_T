SELECT u.CodUslugi, COUNT(*)kol
FROM PacientVisit pv 
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
JOIN Uslugi AS u ON u.SluchID = pv.id
where pv.ReestrMedOrgID = 48 and pv.OsobSluch = 2 AND u.CodUslugi IN ('B04.015.001', 'B04.026.002')
GROUP BY u.codUslugi