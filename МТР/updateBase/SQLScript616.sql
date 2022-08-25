BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		 
EXEC [dbo].[versionСheck] 615

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST('20200401' AS DateTime), NULL, 2, N'--006F.00.0360	ZL_LIST/ZAP/Z_SL/RSLT	D, R	V009	IDRMP	DS_ONK=1	RSLT <> {317, 321, 332, 343, 347}
--006F.00.0360 результат не соответствует подозрению на онко
--DECLARE @AccountID INT =24172
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.IDRMP,v9.RMPNAME ,v12.[IDIZ],v12.IZNAME
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 -- AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where 
 v9.IDRMP IN (317, 321, 332, 343, 347)
     and  z.SignSuspectedDsOnk=1          
--order by   fp.AccountId , fp.externalid ', N'006F.00.0360 результат не соответствует подозрению на онко', N'006F.00.0360 результат не соответствует подозрению на онко', N'Результат не соответствует подозрению на онко', 1, 0.0000, 4, 1.0000, 9, 2)

EXEC [dbo].[versionUpdate] 616
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



