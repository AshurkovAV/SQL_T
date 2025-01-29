declare @tab table (
id int,
name nvarchar(100)
)
--if OBJECT_ID('ztemp_PO_dubl1') is not null drop table ztemp_PO_dubl1
--if OBJECT_ID('ztemp_PO_dubl2') is not null drop table ztemp_PO_dubl2

DECLARE @D3_SCID INT = 23421
DECLARE @OsobSluch INT  = 49

insert into @tab (id, name)
SELECT t.ID, 'ƒÛ·ÎËÍ‡Ú œŒ (√Œƒ) ' + convert(nvarchar(12), t.DATE_Z_1) AS per
FROM (
SELECT s.ID AS ids, zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, p.SMO, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
JOIN D3_SCHET_OMS AS s ON zsl.D3_SCID = s.ID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 97) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE  s.[YEAR] IN (2024)  AND zsl.OS_SLUCH_REGION = 49 AND s.NSCHET NOT LIKE '%Ó¯Ë·%') AS t1
INNER JOIN (
	SELECT s.ID AS ids, zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, p.SMO, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
JOIN D3_SCHET_OMS AS s ON zsl.D3_SCID = s.ID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 97) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch AND (p.PR_NOV IS NULL OR p.PR_NOV = 0)  AND s.NSCHET NOT LIKE '%Ó¯Ë·%') AS t ON t.FAM = t1.FAM AND t.im = t1.IM AND t.OT = t1.ot AND t.DR = t1.dr AND t.ids!=t1.IDs



insert into @tab (id, name)
SELECT t1.id, 'ƒÛ·ÎËÍ‡Ú (¬ “≈ ”Ÿ≈Ã –≈≈—“–≈) œŒ ' + convert(nvarchar(12), t2.DATE_Z_1) AS per
--SELECT t1.ID, t1.FAM, t1.im, t1.ot, t1.dr, t1.SMO, t1.DATE_Z_1 AS date_one, t2.doc, t2.DATE_Z_1 AS date_to,  'ƒÛ·ÎËÍ‡Ú (¬ “≈ ”Ÿ≈Ã –≈≈—“–≈) œŒ' AS per
FROM(
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, p.SMO, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 97) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch) AS t1
INNER JOIN (
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 97) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch AND (p.PR_NOV IS NULL OR p.PR_NOV = 0)) AS t2 ON t2.ID <> t1.ID
AND t2.FAM = t1.FAM AND t2.im = t1.im AND t2.ot = t1.ot AND t2.dr = t1.dr
--ORDER BY t2.FAM, t2.im


--SELECT *
--FROM @tab


update dz  set EXP_COMENT = 'Ã›  - ' + t.name
from D3_ZSL_OMS dz
join @tab t on dz.ID = t.id
where dz.D3_SCID = @D3_SCID


