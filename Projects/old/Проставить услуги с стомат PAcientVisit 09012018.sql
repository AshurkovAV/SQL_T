--Начало Обновляем данные в услугах, берем данные с лицевой стороны
UPDATE Uslugi
SET	
 PROFIL = CASE WHEN u.PROFIL IS NULL THEN pv.PROFIL ELSE u.PROFIL END,  
 DetProfil = CASE WHEN u.DetProfil IS NULL THEN pv.DetProfil ELSE u.DetProfil END,
 DateStart = CASE WHEN u.DateStart IS NULL THEN pv.HelpStart ELSE u.DateStart END,
 DateEnd = CASE WHEN u.DateEnd IS NULL THEN pv.HelpEnd ELSE u.DateEnd END,
 Diagnoz = CASE WHEN u.Diagnoz IS NULL THEN pv.MKB ELSE u.Diagnoz END,
 MSPUID = CASE WHEN u.MSPUID IS NULL THEN pv.MSPID ELSE u.MSPUID END,
 Doctor = CASE WHEN u.Doctor IS NULL THEN pv.Doctor ELSE u.Doctor END 
FROM PacientVisit AS pv
JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.ReestrMedOrgID = 5124 AND pv.Idsp = 9
--Конец Обновляем данные в услугах, берем данные с лицевой стороны