DECLARE @p INT = 23437
UPDATE dso SET TARIF = '385.8', SUM_M = '385.8'
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT like '%Некорректный тариф для консультации психолога%'

UPDATE dzo SET IDSP = 29, SUMV = '385.8', EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT like '%Некорректный тариф для консультации психолога%'



