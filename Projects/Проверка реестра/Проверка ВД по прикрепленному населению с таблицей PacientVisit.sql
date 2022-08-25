DECLARE @schetID INT = 5126
DECLARE @tab TABLE (
	id_enp NVARCHAR(16),
	lpu INT,
	comment NVARCHAR(50)
)
INSERT INTO @tab (id_enp, lpu, comment)
SELECT enp, prmo, 'Прикреплен к другой МО'
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap
WHERE ap.ENP IN (
SELECT pv.Polis
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @schetID AND pv.OsobSluch IN (9 ,22, 23, 11))
AND prmo != 460026

INSERT INTO @tab (id_enp, lpu, comment)
SELECT enp, prmo, 'На дату прохождения прикреплен к другой МО'
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap
WHERE ap.ENP IN (
SELECT pv.Polis
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @schetID AND pv.HelpStart < ap.PrMoDtBeg AND pv.OsobSluch IN (9 ,22, 23, 11)) AND prmo = 460026  


SELECT pv.OsobSluch, pv.FAM, im, ot, dr, 
(SELECT db.FAM + ' ' + im + ' ' + ot FROM DoctorBd AS db WHERE db.id = pv.Doctor) docto,
(SELECT f.NameWithID FROM F003 AS f WHERE t.lpu = f.mcod) lpu, t.comment
FROM PacientVisit AS pv
JOIN @tab t ON t.id_enp = pv.Polis
WHERE pv.ReestrMedOrgID = @schetID
AND pv.OsobSluch IN (9, 22, 23, 11)
ORDER BY pv.Doctor
