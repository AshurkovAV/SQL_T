SELECT yu.UserName, COUNT(*)
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SCHET_OMS AS dso ON dso.ID = dzo.D3_SCID
		JOIN Yamed_Users AS yu ON yu.ID = dzo.USERID
WHERE dso.[YEAR] = 2025 AND dso.[MONTH] = 7
GROUP BY yu.UserName


