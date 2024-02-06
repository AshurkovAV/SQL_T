	DECLARE @pp1 int = 20973
    DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)


SELECT t.zid, t.SUMV, 'ƒубликаты посещений врачей одной специальности' com  
FROM (
		SELECT dzo.ID zid, dso.ID, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dpo.NPOLIS, dso.DS1, dso.PROFIL, dso.DATE_1, dzo.SUMV
		FROM D3_PACIENT_OMS AS dpo
		JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		WHERE dzo.D3_SCID = @pp1 AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL ) 
			AND dzo.OS_SLUCH_REGION IS NULL
			AND dzo.IDSP <> 28
			AND dzo.USL_OK = 3) AS t
JOIN (
		SELECT dso.ID, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dpo.NPOLIS, dso.DS1, dso.PROFIL, dso.DATE_1
		FROM D3_PACIENT_OMS AS dpo
		JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] IN(2023, 2024) AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL ) 
			AND dzo.OS_SLUCH_REGION IS NULL
			AND dzo.IDSP <> 28
			AND dzo.USL_OK = 3 ) AS t1 
																													ON t1.FAM = t.FAM
																													AND t1.IM = t.IM
																													AND t1.OT = t.OT
																													AND t1.DR = t.DR
																													AND t1.NPOLIS = t.NPOLIS
																													AND t1.DS1 = t.DS1
																													AND t1.PROFIL = t.PROFIL
																													AND t1.ID <> t.ID 
																													AND t1.DATE_1 = t.DATE_1
																													
  UPDATE D3_ZSL_OMS SET EXP_COMENT = 'ƒубликаты посещений врачей одной специальности'
		HERE ID IN (SELECT id FROM @tab) 