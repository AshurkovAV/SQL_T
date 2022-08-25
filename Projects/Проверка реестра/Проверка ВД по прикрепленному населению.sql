DECLARE @schetID INT = 1048
DECLARE @tab TABLE (
	id_enp NVARCHAR(16),
	lpu INT,
	comment NVARCHAR(50)
)
INSERT INTO @tab (id_enp, lpu, comment)
SELECT enp, prmo, 'Прикреплен к другой МО'
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap
WHERE ap.ENP IN (
SELECT p.NPOLIS
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
WHERE s.SCHET_ID = @schetID AND s.OS_SLUCH_REGION IN (9 ,22, 11))
AND prmo != 460026

INSERT INTO @tab (id_enp, lpu, comment)
SELECT enp, prmo, 'На дату прохождения прикреплен к другой МО'
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap
WHERE ap.ENP IN (
SELECT p.NPOLIS
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
WHERE s.SCHET_ID = @schetID AND s.DATE_1 < ap.PrMoDtBeg AND s.OS_SLUCH_REGION IN (9 ,22, 23, 11)) AND prmo = 460026  


SELECT s.OS_SLUCH_REGION, p.FAM, im, ot, dr, 
(SELECT db.FAM + ' ' + im + ' ' + ot FROM DoctorBd AS db WHERE db.id = s.IDDOKTO) docto,
(SELECT f.NameWithID FROM F003 AS f WHERE t.lpu = f.mcod) lpu, t.comment
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
JOIN @tab t ON t.id_enp = p.NPOLIS
WHERE s.SCHET_ID = @schetID
AND s.OS_SLUCH_REGION IN (9, 22, 11)
ORDER BY IDDOKTO
