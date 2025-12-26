SELECT yu.UserName, COUNT(*)
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SCHET_OMS AS dso ON dso.ID = dzo.D3_SCID
		JOIN Yamed_Users AS yu ON yu.ID = dzo.USERID
<<<<<<< HEAD
WHERE dso.[YEAR] = 2025 AND dso.[MONTH] = 8
=======
WHERE dso.[YEAR] = 2025 AND dso.[MONTH] = 7
>>>>>>> e8f1c39c6b0ec0db9093e40e90869ce12ca5707c
GROUP BY yu.UserName


