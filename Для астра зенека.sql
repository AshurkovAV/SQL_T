SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DS1
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso.ID
WHERE dso.DS1 BETWEEN 'I50' AND 'I50.9' OR ddo.DS BETWEEN 'I50' AND 'I50.9'
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DS1
 