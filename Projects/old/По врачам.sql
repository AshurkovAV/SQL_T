SELECT
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = MKB)MKB,
-- (SELECT v.NameWithID FROM v009 v WHERE v.IDRMP = pv.HelpResult), 
COUNT(*) kol 
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE rmod.R_YEAR IN (2014,2015,2016)
AND pv.Doctor = 107
GROUP BY pv.MKB