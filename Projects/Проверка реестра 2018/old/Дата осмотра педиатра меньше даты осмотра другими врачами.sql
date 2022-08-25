DECLARE @D3_SCID INT = 2071
DECLARE @OsobSluch INT  = 11

-----Begin Собираем все случаи педиатра----
DECLARE @sluchPediatr68 TABLE (
	[ID] [int] NOT NULL,
	[FAM] [nvarchar](40) NULL,
	[im] [nvarchar](40) NULL,
	[ot] [nvarchar](40) NULL,
	[dr] [date] NULL,
	DATE_1 [date] NULL,
	DATE_2 [date] NULL,
	[doc] [nvarchar](62) NULL
)
INSERT INTO @sluchPediatr68(ID,FAM,im,ot,dr,DATE_1,DATE_2,doc)
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(ds.DATE_1 AS DATE)DATE_1, CAST(ds.DATE_2 AS DATE)DATE_2,
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL] zsl
JOIN PACIENT AS p ON p.ID = zsl.D3_PID
LEFT JOIN (SELECT * FROM D3_SL AS ds WHERE ds.PROFIL = 68) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch
-----End Собираем все случаи педиатра----
-----Begin Собираем все случаи кроме педиатра----
DECLARE @sluchNotPediatr TABLE (
	[ID] [int] NOT NULL,
	[FAM] [nvarchar](40) NULL,
	[im] [nvarchar](40) NULL,
	[ot] [nvarchar](40) NULL,
	[dr] [date] NULL,
	DATE_1 [date] NULL,
	DATE_2 [date] NULL,
	[doc] [nvarchar](62) NULL
)

INSERT INTO @sluchNotPediatr(ID,FAM,im,ot,dr,DATE_1,DATE_2,doc)
SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(ds.DATE_1 AS DATE)DATE_1, CAST(ds.DATE_2 AS DATE)DATE_2,
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
FROM [D3_ZSL] zsl
JOIN PACIENT AS p ON p.ID = zsl.D3_PID
LEFT JOIN (SELECT * FROM D3_SL AS ds WHERE ds.PROFIL != 68) AS ds ON zsl.ID = ds.D3_ZSLID
WHERE zsl.D3_SCID = @D3_SCID AND zsl.OS_SLUCH_REGION = @OsobSluch
-----End Собираем все случаи кроме педиатра----

SELECT *
FROM @sluchPediatr68 AS sp
JOIN @sluchNotPediatr AS snp ON snp.ID = sp.ID
WHERE snp.DATE_2 > sp.DATE_2
ORDER BY snp.FAM, snp.im

