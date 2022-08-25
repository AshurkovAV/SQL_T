BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		 
EXEC [dbo].[versionСheck] 655

UPDATE fec 
SET fec.[Query] = '--003K.00.0211
--DECLARE @AccountID INT =24172
--Взаимное несоответствие исхода заболевания, результата обращения(При RSLT={102, 103, 104, 105, 106, 109, 108,107, 110} ISHOD не должен быть равен 101 )
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 --AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where v9.IDRMP IN (102, 103, 104, 105, 106, 109, 108,107, 110) 
AND v12.IDIZ  IN (101)'
,fec.DateBegin = '20200401'
,fec.[Description] = '003K.00.0211_Взаимное несоответствие исхода заболевания, результата обращения(RSLT={102, 103, 104, 105, 106, 109, 108,107, 110}	ISHOD <> 101)'
,fec.Comments = '003K.00.0211_Взаимное несоответствие исхода заболевания, результата обращения(RSLT={102, 103, 104, 105, 106, 109, 108,107, 110}	ISHOD <> 101)'
FROM FactExpertCriterion AS fec
WHERE fec.Comments LIKE '003K.00.0211_Взаимное несоответствие исхода заболевания, результата обращения(RSLT={102, 103, 104, 105, 106, 109, 108,107, 110%'

EXEC [dbo].[versionUpdate] 656
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