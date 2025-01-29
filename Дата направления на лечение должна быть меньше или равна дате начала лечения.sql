--UPDATE dzo SET dzo.LPU = 460026, dzo.EXP_COMENT = NULL
--UPDATE dzo SET dzo.EXP_COMENT = NULL

--UPDATE dso SET PODR = '460026209712'
SELECT ZSL_ID, MIN(dso.DATE_1)DATE_1, min(dzo.NPR_DATE)NPR_DATE
INTO ztemp_naprdate
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 22290
AND dzo.EXP_COMENT like '%Дата направления на лечение должна быть меньше или равна дате начала лечения%'
GROUP BY dzo.ZSL_ID

UPDATE dzo SET dzo.NPR_DATE = t.DATE_1, dzo.EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN ztemp_naprdate t ON dzo.ZSL_ID = t.zsl_id