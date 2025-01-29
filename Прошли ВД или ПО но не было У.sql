SELECT *
FROM (
			SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION, 
			dbo.GROUP_CONCAT_DS(DISTINCT cast(dzo.DATE_Z_2 AS DATE), N' , ', 1)DATE_Z_2,
			MAX(ysme.LPU_ID)LPU_ID
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
								JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
				WHERE dso2.[YEAR] IN (2024)
					AND dzo.OS_SLUCH_REGION IN (47,49) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR
) AS t
LEFT JOIN 
			(SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION, MAX(ysme.LPU_ID)LPU_ID
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
								JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
				WHERE dso2.[YEAR] IN (2024)
					AND dzo.OS_SLUCH_REGION IN (50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR)  AS u ON u.FAM = t.FAM AND u.IM = t.IM AND u.OT = t.OT AND u.DR = t.DR
WHERE u.FAM IS NULL