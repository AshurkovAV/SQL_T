DECLARE @p INT = 23676
UPDATE dso SET TARIF = '372.1', SUM_M = '372.1'
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @p
AND dso.PROFIL =74
--AND dzo.EXP_COMENT like '%Некорректный тариф для консультации психолога%'

UPDATE dzo SET IDSP = 29, SUMV = '372.1', EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @p
AND dso.PROFIL =74
--AND dzo.EXP_COMENT like '%Некорректный тариф для консультации психолога%'



