SELECT t.*, t1.D3_SCID
INTO ztemp_dubl0310
FROM (
		SELECT dzo.ID zid, dso.ID, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dpo.NPOLIS, dso.DS1, dso.PROFIL, dso.DATE_1
		FROM D3_PACIENT_OMS AS dpo
		JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		WHERE dzo.D3_SCID = 20568 AND dzo.OS_SLUCH_REGION IS NULL) AS t
JOIN (
		SELECT dso.ID, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dpo.NPOLIS, dso.DS1, dso.PROFIL, dso.DATE_1, dzo.D3_SCID
		FROM D3_PACIENT_OMS AS dpo
		JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] = 2023 AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL ) AND dzo.OS_SLUCH_REGION IS NULL) AS t1 
																													ON t1.FAM = t.FAM
																													AND t1.IM = t.IM
																													AND t1.OT = t.OT
																													AND t1.DR = t.DR
																													AND t1.NPOLIS = t.NPOLIS
																													AND t1.DS1 = t.DS1
																													AND t1.PROFIL = t.PROFIL
																													AND t1.ID <> t.ID 
																													AND t1.DATE_1 = t.DATE_1
																													
																													
UPDATE dzo SET dzo.EXP_COMENT = 'Дубликаты посещений в один день'
FROM ztemp_dubl0310 t
JOIN D3_ZSL_OMS AS dzo ON dzo.ID = zid