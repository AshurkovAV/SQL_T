DROP TABLE zsd1
SELECT dpo.NPOLIS,dpo.FAM, dpo.IM, dpo.OT, dpo.DR, 
dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION, 

dbo.GROUP_CONCAT_DS(DISTINCT convert(date, dzo.DATE_Z_2, 102) , N' , ', 1)DATE_Z_2, 
dbo.GROUP_CONCAT_DS(DISTINCT ysme.NameWithID , N' , ', 1)doc
INTO zsd1
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
								JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = IDDOKT
				WHERE dso2.[YEAR] IN (2025) 
				AND dzo.DATE_Z_1 BETWEEN '20250701' AND '20250707'
				AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0) 
				AND dzo.USL_OK = 3  
				AND dzo.OS_SLUCH_REGION IS NULL 
				AND ysme.ID LIKE '700%'
GROUP BY dpo.NPOLIS,  dpo.FAM, dpo.IM, dpo.OT, dpo.DR
				
	
DROP TABLE zs1				
SELECT t.*
INTO zs1 
	FROM zsd1 AS t
		LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				WHERE dso2.[YEAR] IN (2025)
					AND dzo.OS_SLUCH_REGION IN (47,49,50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.FAM = t1.FAM AND t.IM = t1.IM AND t.ot = t1.OT AND t.dr = t1.DR
WHERE  t1.dr IS NULL 

SELECT * FROM zs1
