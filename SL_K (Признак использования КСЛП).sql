BEGIN TRANSACTION TR1
DECLARE @p INT = 23437
UPDATE dso SET SL_K = 0
FROM D3_ZSL_OMS AS dzo	
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_KSG_KPG_OMS AS dkko ON dkko.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT LIKE '%SL_K (Признак использования КСЛП)%'

UPDATE dkko SET SL_K = 0
FROM D3_ZSL_OMS AS dzo	
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_KSG_KPG_OMS AS dkko ON dkko.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT LIKE '%SL_K (Признак использования КСЛП)%'

UPDATE dzo SET EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo	
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_KSG_KPG_OMS AS dkko ON dkko.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT LIKE '%SL_K (Признак использования КСЛП)%'
IF @@ERROR <> 0
   BEGIN
     RAISERROR('Error, transaction not completed!',16,-1)
     ROLLBACK TRANSACTION TR1
   END
 ELSE
   COMMIT TRANSACTION TR1
