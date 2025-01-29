SELECT *
FROM (
SELECT ap.Fam, ap.Im, ap.Ot, ap.Dr----, DIAG10
FROM [SQL_COD].[DocExchange].[dbo].ATTP_People AS ap	
WHERE ap.[Active] = 1 AND ap.Ds IS NULL
AND ap.PrMo = 460026
and YEAR( ap.Dr)BETWEEN 1984 AND 2006 
GROUP BY  ap.Fam, ap.Im, ap.Ot, ap.Dr) AS t
LEFT JOIN (
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dso2.[YEAR] IN (2022,2023,2024)
AND dzo.OS_SLUCH_REGION IN (47,49)
) AS t1 ON t1.Fam = t.Fam AND t1.Im = t.Im AND t1.Ot = t.Ot AND t1.Dr = t.Dr
WHERE t1.FAM IS NULL