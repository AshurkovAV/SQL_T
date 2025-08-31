SELECT distinct t.*, p.*--, d.*
FROM(
		SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dpo.NPOLIS
		FROM D3_SCHET_OMS AS dso
			JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		WHERE dso.[YEAR] = 2025 AND dzo.USL_OK = 1 AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
		AND dso.CODE_MO = 460026 ) AS t

LEFT JOIN (

		SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR
		FROM D3_SCHET_OMS AS dso
			JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		WHERE dso.[YEAR] = 2025 AND dzo.OS_SLUCH_REGION IN (47, 49)) AS t2 ON t2.FAM = t.FAM AND t2.IM = t.IM AND t2.OT = t.OT AND t2.DR = t.DR

INNER JOIN Prikrep AS p ON t.FAM = p.Фамилия AND t.IM = p.Имя AND t.OT = p.Отчество AND t.DR = p.Дата_рождения 
--LEFT JOIN [2] d ON t.NPOLIS = d.column1

WHERE t2.FAM IS NULL 