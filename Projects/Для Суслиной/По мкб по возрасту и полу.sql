SELECT 
(SELECT m.NameWithID FROM M001 AS m WHERE m.IDDS = pv.MKB)MKB, pv.W, year(pv.DR) "Воз", COUNT(*) kol
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID IN (45,48,49) AND pv.OsobSluch = 1
GROUP BY pv.MKB, pv.W, year(pv.DR)