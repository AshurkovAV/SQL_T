---Украинцы
DECLARE @schet INT = 2095
DECLARE @tab TABLE (
	id INT,
	NAME NVARCHAR(15)
	)

SELECT p.FAM AS [Фамилия], im [Имя], p.OT [Отчетсво], 
v.NameWithID [Пол], CAST(p.DR AS DATE) [Дата рождения], 
p.DOCSER + ' ' + p.DOCNUM [УДЛ], s2.NSCHET [Место жительства], ''[Место регистрации], 
v2.NameWithID [Условия оказания помощи], s.DS1 [МКБ], 
CONVERT(nvarchar(10), s.DATE_1, 126) + '-' + CONVERT(nvarchar(10), s.DATE_2, 126) [дата начала и дата окончания лечения], 
v3.NameWithID [Профиль оказания мед. помощи], 1 [Объемы мед помощи], s.TARIF [ТАриф],
s.SUMV [Стоимость оказания], sk.NameWithID

FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
LEFT JOIN V005 AS v ON v.Id = p.W
LEFT JOIN V006 AS v2 ON v2.id = s.USL_OK
LEFT JOIN V015 AS v3 ON v3.ID = s.MSPID
JOIN SCHET AS s2 ON s2.ID = s.SCHET_ID
JOIN USL AS u ON u.SLID = s.ID
LEFT JOIN [SprKsg] sk ON sk.ID = u.IDKSG
WHERE p.SCHET_ID IN (2099, 2087,2079, 2081) and CODE_USL = 'TF1.K01.001'