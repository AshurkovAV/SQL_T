SELECT MAX(ap.id)pid, ap.Fam, ap.Im, ap.Ot, ap.Dr, dbo.GROUP_CONCAT_DS(DISTINCT DIAG10, N' , ', 1) DS

FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
	INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
		LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = d.snils
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO IN (460026, 460006) 
AND ap.Ds IS NULL
			AND d.dateend is  NULL
			AND d.DIAG10 IN('E10.0', 'E10.1','E10.2','E10.3','E10.4','E10.5','E10.6','E10.7', 'E10.8', 'E10.9','E10',
			 'E11.0','E11.1','E11.2', 'E11.3', 'E11.4', 'E11.5', 'E11.6','E11.7','E11.8','E11.9', 'E11') 

GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr  	


--SELECT dso.[MONTH], ysme.LPU_ID, dzo.ID, dpo.W
--FROM D3_SCHET_OMS AS dso
--	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
--		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
--			JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso2.IDDOKT
--				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
--WHERE dso.[YEAR] = 2024 AND dso.SchetType = 'DD'
