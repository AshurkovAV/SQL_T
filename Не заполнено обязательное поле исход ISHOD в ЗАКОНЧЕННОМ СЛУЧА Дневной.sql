UPDATE dzo SET ISHOD = 102, RSLT = 101, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 22321
AND dzo.EXP_COMENT LIKE '%Не заполнено обязательное поле исход ISHOD в ЗАКОНЧЕННОМ СЛУЧА%'
