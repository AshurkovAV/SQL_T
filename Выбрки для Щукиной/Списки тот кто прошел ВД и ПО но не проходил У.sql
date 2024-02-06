SELECT t.*, tl.MOBIL_TELEFON
FROM(
		SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION, dzo.DATE_Z_2, ysme.NameWithID, 
		CASE WHEN ysme.LPU_ID = 460006 THEN '«¿¬Œƒ— ¿ﬂ' 
             WHEN ysme.LPU_ID = 460026 THEN '—Œﬁ«Õ¿ﬂ' 
        ELSE 'ÃŒ ÌÂ ÓÔÂ‰ÂÎÂÌ‡' END gb
		FROM D3_ZSL_OMS AS dzo
			JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			JOIN f003 f ON f.mcod = dso2.CODE_MO
			LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
		WHERE dso2.[YEAR] = 2023
		AND dzo.OS_SLUCH_REGION IN (47,49) ) AS t

LEFT JOIN (
			
		SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR
		FROM D3_ZSL_OMS AS dzo
			JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			JOIN f003 f ON f.mcod = dso2.CODE_MO
		WHERE dso2.[YEAR] = 2023
		AND dzo.OS_SLUCH_REGION IN (50) ) AS tu ON tu.FAM = t.FAM AND tu.IM = t.IM AND tu.OT = t.OT AND tu.DR = t.DR
LEFT JOIN telefon1 AS tl ON t.FAM = tl.NOM AND t.IM = tl.PRENOM AND t.OT = tl.PATRONYME AND t.DR = tl.NE_LE 
WHERE tu.FAM IS NULL