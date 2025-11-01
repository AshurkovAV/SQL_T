DECLARE @id INT = 23799

UPDATE dso SET DN = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
	AND dzo.EXP_COMENT LIKE '%Некорректный Код диспансерного наблюдения%'
	AND dzo.OS_SLUCH_REGION = 4
	
UPDATE dzo SET EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @id 
	AND dzo.EXP_COMENT LIKE '%Некорректный Код диспансерного наблюдения%'
	AND dzo.OS_SLUCH_REGION = 4