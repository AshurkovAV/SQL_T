DECLARE @p INT = 23378
UPDATE dso SET LPU_1 = 305
---SELECT dso.P_CEL25, dso.LPU_1
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT like '%Несоответствие целей посещения (4.1,4.2) и Подразделения МО (305)%'

UPDATE dzo SET EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT like '%Несоответствие целей посещения (4.1,4.2) и Подразделения МО (305)%'
