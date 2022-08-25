--ALTER TABLE pacientvisit ALTER COLUMN PODR NVARCHAR(20)
--SELECT * FROM ReestrMedOrgDb AS rmod

DECLARE @ReestrMedOrgID INT = 2123
DECLARE @tabSpes TABLE (
	Doctor INT, 
	MSPID INT, 
	Profil INT
	)
INSERT INTO @tabSpes (Doctor, MSPID, Profil)
SELECT pv.Doctor, pv.MSPID, pv.Profil
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = 79
GROUP BY pv.Doctor, pv.MSPID, pv.Profil
ORDER BY Doctor

UPDATE PacientVisit SET MSPID = ISNULL(t.MSPID, pv.MSPID), Profil = ISNULL(t.Profil, pv.Profil)
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
LEFT JOIN @tabSpes t ON pv.Doctor = t.Doctor
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID


UPDATE PacientVisit SET MSPID = 177, Profil = 90
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND Doctor = 33

UPDATE PacientVisit SET MSPID = 174, Profil = 86
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND Doctor = 9

UPDATE PacientVisit SET MSPID = 174, Profil = 86
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND Doctor = 34

UPDATE PacientVisit SET MSPID = 173, Profil = 63
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND Doctor = 35

UPDATE PacientVisit SET MSPID = 177, Profil = 90
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND Doctor = 37

UPDATE PacientVisit SET MSPID = 177, Profil = 90
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND Doctor = 38

UPDATE PacientVisit SET MSPID = 173, Profil = 63
--SELECT pv.Doctor, pv.MSPID, pv.Profil, t.*
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND Doctor = 39



UPDATE PacientVisit SET TypeSluch = 2 
--SELECT *--pv.Doctor, pv.MSPID, pv.Profil
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND pv.MKB = 'Z01.2'

UPDATE PacientVisit SET Idsp = 9
WHERE ReestrMedOrgID = @ReestrMedOrgID

UPDATE PacientVisit SET ConditionHelp = 3
WHERE ReestrMedOrgID = @ReestrMedOrgID

UPDATE PacientVisit SET TypeHelp = 13
WHERE ReestrMedOrgID = @ReestrMedOrgID

--Только для детской стоматологии
DECLARE @MedicalOrganization DECIMAL(16,2)  
SELECT @MedicalOrganization = s.Parametr FROM Settings AS s WHERE s.Name = 'MedicalOrganization'
IF (@MedicalOrganization =  460025)
BEGIN
	UPDATE PacientVisit SET MSPID = 174, Profil = 86
	FROM PacientVisit AS pv
	WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND Doctor = 36
END

update u SET MSPUID = pv.MSPID 
FROM PacientVisit AS pv
JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND  MSPUID != pv.MSPID

update u SET Profil = pv.Profil
FROM PacientVisit AS pv
JOIN Uslugi AS u ON u.SluchID = pv.id
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND u.Profil != pv.Profil

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
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Idsp = 9
--Конец Обновляем данные в услугах, берем данные с лицевой стороны



--
--DECLARE @ReestrMedOrgID INT = 98
DECLARE @tab TABLE (
id INT,
ed_col NUMERIC(5,2)	
)

INSERT INTO @tab(Id, ed_col)
SELECT pv.Id, SUM(ISNULL(mus.uet, 0) * CASE WHEN u.KolUslugi IS NULL OR u.KolUslugi = 0 THEN 1 ELSE u.KolUslugi END)
FROM PacientVisit AS pv
LEFT JOIN Uslugi AS u ON u.SluchID = pv.id
LEFT JOIN MappingUslStomat mus ON mus.kod_usl = u.CodUslugi
WHERE pv.ReestrMedOrgID=@ReestrMedOrgID
AND pv.Idsp = 9 
AND pv.HelpEnd>='20170215'
GROUP BY pv.id

UPDATE PacientVisit SET ED_COL = t.ed_col
FROM PacientVisit AS pv
JOIN @tab t ON t.id = pv.id
WHERE pv.ReestrMedOrgID=@ReestrMedOrgID
AND pv.Idsp = 9

DECLARE @tab1 TABLE (
id INT,
ed_col NUMERIC(5,2)	
)

INSERT INTO @tab1(Id, ed_col)
SELECT pv.Id, SUM(ISNULL(mus.uet, 0) * CASE WHEN u.KolUslugi IS NULL OR u.KolUslugi = 0 THEN 1 ELSE u.KolUslugi END)
FROM PacientVisit AS pv
LEFT JOIN Uslugi AS u ON u.SluchID = pv.id
LEFT JOIN MappingUslStomat_old mus ON mus.kod_usl = u.CodUslugi
WHERE pv.ReestrMedOrgID=@ReestrMedOrgID
AND pv.Idsp = 9 
AND pv.HelpEnd<'20170215'
GROUP BY pv.id

UPDATE PacientVisit SET ED_COL = t.ed_col
FROM PacientVisit AS pv
JOIN @tab1 t ON t.id = pv.id
WHERE pv.ReestrMedOrgID=@ReestrMedOrgID
AND pv.Idsp = 9




--ALTER TABLE pacientvisit ALTER COLUMN PODR INT