DECLARE @id INT = 8014
-- B04.047.002       Профилактический прием (осмотр, консультация) врача-терапевта
INSERT INTO D3_USL_OMS
(D3_SLID,
	D3_ZSLID,
	D3_SLGID,
	LPU,
	PROFIL,
	VID_VME,
	DET,
	DATE_IN,
	DATE_OUT,
	DS,
	CODE_USL,
	KOL_USL,
	PRVS,
	CODE_MD,
	VERS_SPEC
)
SELECT dso.ID, dzo.ID, dso.SL_ID, 460026, dso.PROFIL, 'B01.047.001', 0, dso.DATE_1, dso.DATE_2, dso.DS1, 'B01.047.001', 1, dso.PRVS, dso.IDDOKT, 'V021'

FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')


--A06.09.008        Томография легких
INSERT INTO D3_USL_OMS
(D3_SLID,
	D3_ZSLID,
	D3_SLGID,
	LPU,
	PROFIL,
	VID_VME,
	DET,
	DATE_IN,
	DATE_OUT,
	DS,
	CODE_USL,
	KOL_USL,
	PRVS,
	CODE_MD,
	VERS_SPEC
)
SELECT dso.ID, dzo.ID, dso.SL_ID, 460026, 78, 'A06.09.008', 0, dso.DATE_1, dso.DATE_2, dso.DS1, 'A06.09.008', 1, 60, '157-898-373 47', 'V021'

FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')

--B03.016.002       Общий (клинический) анализ крови
INSERT INTO D3_USL_OMS
(D3_SLID,
	D3_ZSLID,
	D3_SLGID,
	LPU,
	PROFIL,
	VID_VME,
	DET,
	DATE_IN,
	DATE_OUT,
	DS,
	CODE_USL,
	KOL_USL,
	PRVS,
	CODE_MD,
	VERS_SPEC
)
SELECT dso.ID, dzo.ID, dso.SL_ID, 460026, 38, 'B03.016.002', 0, dso.DATE_1, dso.DATE_2, dso.DS1, 'B03.016.002', 1, 215, '037-674-734 90', 'V021'

FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')

--A05.10.004        Расшифровка, описание и интерпретация электрокардиографических данных
INSERT INTO D3_USL_OMS
(D3_SLID,
	D3_ZSLID,
	D3_SLGID,
	LPU,
	PROFIL,
	VID_VME,
	DET,
	DATE_IN,
	DATE_OUT,
	DS,
	CODE_USL,
	KOL_USL,
	PRVS,
	CODE_MD,
	VERS_SPEC
)
SELECT dso.ID, dzo.ID, dso.SL_ID, 460026, 111, 'A05.10.004', 0, dso.DATE_1, dso.DATE_2, dso.DS1, 'A05.10.004', 1, 89, '037-674-803 86', 'V021'

FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')

--A09.05.009        Исследование уровня С-реактивного белка в сыворотке крови
INSERT INTO D3_USL_OMS
(D3_SLID,
	D3_ZSLID,
	D3_SLGID,
	LPU,
	PROFIL,
	VID_VME,
	DET,
	DATE_IN,
	DATE_OUT,
	DS,
	CODE_USL,
	KOL_USL,
	PRVS,
	CODE_MD,
	VERS_SPEC
)
SELECT dso.ID, dzo.ID, dso.SL_ID, 460026, 38, 'A09.05.009', 0, dso.DATE_1, dso.DATE_2, dso.DS1, 'A09.05.009', 1, 215, '037-674-734 90', 'V021'

FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')


INSERT INTO D3_USL_OMS
(D3_SLID,
	D3_ZSLID,
	D3_SLGID,
	LPU,
	PROFIL,
	VID_VME,
	DET,
	DATE_IN,
	DATE_OUT,
	DS,
	CODE_USL,
	KOL_USL,
	PRVS,
	CODE_MD,
	VERS_SPEC
)
SELECT dso.ID, dzo.ID, dso.SL_ID, 460026, 38, 'A09.05.009', 0, dso.DATE_1, dso.DATE_2, dso.DS1, 'A09.05.009', 1, 215, '037-674-734 90', 'V021'

FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')

--B01.047.001

--157-898-373 47

--Никулина Наталья Викторовна  140-296-610 41
--Сергеева Вера Николаевна     165-712-342 65
--Пенкина Карина Юрьевна       107-905-482 61