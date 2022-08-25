SELECT fam, im, ot, dr, pv.MKB,
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = pv.MKB)
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE rmod.R_YEAR = 2017 AND pv.PODR = 2
AND pv.MKB BETWEEN 'A15' AND 'A99.9' --AND pv.id = 3565360

SELECT fam, im, ot, dr, 
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = pv.MKB)
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE rmod.R_YEAR = 2017 AND pv.PODR = 2
AND pv.MKB BETWEEN 'c00' AND 'c99.9' --AND pv.id = 3565360

SELECT fam, im, ot, dr, pv.MKB,
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = pv.MKB)
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE rmod.R_YEAR = 2017 AND pv.PODR = 2
AND (pv.MKB BETWEEN 'I24.8' AND 'I24.9' OR pv.MKB BETWEEN 'I21' AND 'I21.9') --AND pv.id = 3565360

SELECT fam, im, ot, dr, pv.MKB,
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = pv.MKB)
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE rmod.R_YEAR = 2017 AND pv.PODR = 2
AND (pv.MKB BETWEEN 'I61' AND 'I61.9' OR pv.MKB BETWEEN 'I63' AND 'I63.9' OR pv.MKB BETWEEN 'I64' AND 'I64.9') --AND pv.id = 3565360