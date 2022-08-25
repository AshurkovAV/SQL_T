INSERT INTO [D3_DSS_OMS] ( [D3_SLID]
      ,[D3_SLGID]
      ,[DS]
      ,[DS_PR]
      ,[DS_TYPE]
      ,[PR_DS2_N])
  
SELECT dso2.ID, dso2.SL_ID, d.DIAG10, 0, 2, 1 
--dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso2.DATE_1, dso2.DS1, d.DIAG10, dzo.ZSL_ID, COUNT(*)
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON ap.active=1 
			AND ap.prmo=460026 
			AND dpo.FAM = ap.fam AND dpo.IM = ap.im AND dpo.OT = ap.ot AND dpo.DR = ap.dr
JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d ON d.PID=ap.ID AND d.MO=460026 AND d.dateend is  NULL AND d.DIAG10 BETWEEN 'I00' AND 'I99.9' 
WHERE dso.[YEAR] = 2021 AND ds1 != d.DIAG10
AND dso.[MONTH] IN (11) AND dzo.D3_SCID = 6628
AND dso2.DS1 BETWEEN 'I00' AND 'I99.9' --AND dso2.P_CEL25 = '1.0'
AND dzo.ZSL_ID != 'C3CFAFF6-2645-4820-887C-29CCB1C114E6'
GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso2.DATE_1, dso2.DS1, d.DIAG10, dso2.ID , dso2.SL_ID, dzo.ZSL_ID