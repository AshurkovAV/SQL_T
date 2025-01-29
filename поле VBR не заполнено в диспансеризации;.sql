BEGIN TRANSACTION TR1
DECLARE @p INT = 22346
UPDATE dzo SET OS_SLUCH_REGION = 59, IDSP = 30
FROM D3_ZSL_OMS AS dzo	
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID		
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT LIKE '%Некорректно подан случай диспансерного наблюдения%'

UPDATE dzo SET EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo	
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID		
WHERE dzo.D3_SCID = @p
AND dzo.EXP_COMENT LIKE '%Некорректно подан случай диспансерного наблюдения%'
IF @@ERROR <> 0
   BEGIN
     RAISERROR('Error, transaction not completed!',16,-1)
     ROLLBACK TRANSACTION TR1
   END
 ELSE
   COMMIT TRANSACTION TR1
