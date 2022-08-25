BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 587

UPDATE fec SET fec.[Query] = '
--003K.00.0190
--Взаимное несоответствие исхода заболевания, результата обращения
--DECLARE @AccountID INT =24172


--убрал 305 и 308
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where v12.IDIZ=306 
AND v9.IDRMP NOT IN (305,308,314, 315, 317, 318, 321, 322, 323, 324, 325, 332, 333, 334, 335, 336, 343, 344, 347, 348, 349,  350,
                     351, 353, 355, 356, 357, 358, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374)

'
FROM FactExpertCriterion AS fec
WHERE fec.[Description] LIKE '003K.00.0190_При ISHOD=306%'

EXEC [dbo].[versionUpdate] 588
COMMIT TRAN;		
END TRY
		BEGIN CATCH			
			SET @ErrorMessage= ERROR_MESSAGE()
			SET @ErrorSeverity= ERROR_SEVERITY()
			SET @ErrorState= ERROR_STATE()
			RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState)
			IF (@@trancount > 0) ROLLBACK TRAN						
		END CATCH
IF (@@trancount > 0) ROLLBACK TRAN;

