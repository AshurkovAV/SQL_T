DECLARE @D3_SCID INT = 33
DECLARE @OsobSluch INT  = 11

declare @tab table (
id int,
name nvarchar(100)
)


insert into @tab (id, name)
SELECT t1.id, 'Дубликат (В ТЕКУЩЕМ РЕЕСТРЕ) ПО детсво дата последнего ' + convert(nvarchar(12), t2.DATE_Z_1) AS per--*,  t2.DATE_Z_1, 'Дубликат (В ТЕКУЩЕМ РЕЕСТРЕ) ПО детсво' AS per
FROM(
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zslv 
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 68) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch) AS t1
INNER JOIN (
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 68) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch) AS t2 ON t2.ID <> t1.ID
AND t2.FAM = t1.FAM AND t2.im = t1.im AND t2.ot = t1.ot AND t2.dr = t1.dr


insert into @tab (id, name)
SELECT t1.id, 'Дубликат (по году) ПО детсво дата последнего ' + convert(nvarchar(12), t2.DATE_Z_1) AS per
FROM(
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 68) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch
AND zsl.VOZR NOT IN ('G00.M03','G00.M04','G00.M05','G00.M06','G00.M07','G00.M08','G00.M09','G00.M10','G00.M11'
,'G00.M12','G01.M03','G01.M06','G01.M09','G02.M06')) AS t1
INNER JOIN (
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL_OMS] zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
JOIN D3_SCHET_OMS AS s ON s.ID = zsl.D3_SCID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 68) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID != @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch 
AND zsl.VOZR NOT IN ('G00.M03','G00.M04','G00.M05','G00.M06','G00.M07','G00.M08','G00.M09','G00.M10','G00.M11'
,'G00.M12','G01.M03','G01.M06','G01.M09','G02.M06')
AND (s.MONTH IN (1, 2, 3, 4, 5, 6) AND s.YEAR = 2018)) AS t2 ON t2.ID <> t1.ID
AND t2.FAM = t1.FAM AND t2.im = t1.im AND t2.ot = t1.ot AND t2.dr = t1.dr



update dz  set EXP_COMENT = 'МЭК - ' + t.name
from D3_ZSL_OMS dz
join @tab t on dz.ID = t.id
where dz.D3_SCID = @D3_SCID