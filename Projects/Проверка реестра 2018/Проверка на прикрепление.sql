DECLARE @schetID INT = 3032
DECLARE @tab TABLE (
	id_enp NVARCHAR(16),
	lpu INT,
	comment NVARCHAR(150)
)
INSERT INTO @tab (id_enp, lpu, comment)
SELECT enp, prmo, 'Прикреплен к другой МО '+ CAST(ap.PrMoDtBeg AS NVARCHAR(12))
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap
WHERE ap.ENP IN (
SELECT p.NPOLIS
FROM D3_ZSL_OMS AS dz
JOIN D3_PACIENT_OMS AS p ON dz.D3_PID = p.ID
WHERE dz.D3_SCID = @schetID AND dz.OS_SLUCH_REGION IN (9 ,22, 23,37,38, 47, 48, 49))
AND prmo != 460026

--SELECT * FROM @tab AS t

INSERT INTO @tab (id_enp, lpu, comment)
SELECT enp, prmo, 'На дату прохождения прикреплен к другой МО - ' + CAST(ap.PrMoDtBeg AS NVARCHAR(12))
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap
WHERE ap.ENP IN (
SELECT p.NPOLIS
FROM D3_ZSL_OMS AS dz
JOIN D3_PACIENT_OMS AS p ON dz.D3_PID = p.ID
WHERE dz.D3_SCID = @schetID AND dz.OS_SLUCH_REGION IN (9 ,22, 23,37,38, 47, 48, 49) AND dz.DATE_Z_1 < ap.PrMoDtBeg) AND prmo = 460026  


SELECT dz.OS_SLUCH_REGION, p.FAM, im, ot, dr, 
(SELECT ysme.FAM + ' ' + im + ' ' + ot FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) docto,
(SELECT f.NameWithID FROM F003 AS f WHERE t.lpu = f.mcod) lpu, t.comment

FROM D3_ZSL_OMS AS dz
JOIN D3_PACIENT_OMS AS p ON dz.D3_PID = p.ID
JOIN D3_SL_OMS AS ds ON dz.ID = ds.D3_ZSLID
JOIN @tab t ON t.id_enp = p.nPolis
WHERE dz.D3_SCID = @schetID AND dz.OS_SLUCH_REGION IN (9 ,22, 23,37,38, 47, 48, 49)
ORDER BY Docto