SELECT t_du.*, t.MOBIL_TELEFON
FROM ztemp_du03082023 AS t_du
LEFT JOIN (
	
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2, dso.DS1
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] = 2023
		AND (dso2.NSCHET LIKE '%+' OR dso2.[MONTH] = 7)
		AND dso2.SchetType IN ('C','H')	
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr
LEFT JOIN telefon1 AS t ON t_du.FAM = t.NOM AND t_du.IM = t.PRENOM AND t_du.OT = t.PATRONYME AND t_du.DR = t.NE_LE 
WHERE t_p.FAM IS NULL

SELECT *
FROM telefon1