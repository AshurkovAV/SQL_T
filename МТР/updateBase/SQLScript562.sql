BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[versionСheck] 561


INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A9C800000000 AS DateTime), NULL, 2, N'--не заполнено поле характер заболевания МЭК 5.1.4.
SELECT             
DISTINCT e.ZmedicalEventId
--p.AccountId, p.ExternalId
     --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
FROM FactTerritoryAccount a --счета            
INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
                       AND p.AccountId=@AccountId        
            --and a.Destination=38000
            AND a.Date >= ''20190101''
                  
INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] AND ze.AssistanceConditions<>4        
INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId  AND e.SignSuspectedDsOnk=0                        
INNER JOIN m001 ON m001.Id = e.DiagnosisGeneral AND m001.idds IN (SELECT idds FROM m001 WHERE idds LIKE ''C%'' OR idds BETWEEN ''D00%'' AND ''D09%'')
--LEFT JOIN ZFactSank sa ON sa.ZmedicalEventId=e.ZmedicalEventId
WHERE e.Czab IS NULL', N'Не заполнено поле характер заболевания', N'Не заполнено поле характер заболевания', N'Не заполнено поле характер заболевания', 1, 0.0000, 4, 1.0000,  7, 1)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A9C800000000 AS DateTime), NULL, 2, N'--не заполнено поле признак подозрение на онкологию МЭК 5.1.4.
SELECT             
DISTINCT e.ZmedicalEventId
--,a.[Date],
--p.AccountId, p.ExternalId
     --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
FROM FactTerritoryAccount a --счета            
INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
                       AND p.AccountId=@AccountId        
            --and a.Destination=38000
            AND a.Date >= ''20190101''
                  
INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]      
INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId --AND e.SignSuspectedDsOnk=0                        
--LEFT JOIN ZFactSank sa ON sa.ZmedicalEventId=e.ZmedicalEventId
WHERE e.SignSuspectedDsOnk IS NULL', N'Не заполнено поле признак подозрение на онкологию', N'Не заполнено поле признак подозрение на онкологию', N'Не заполнено поле признак подозрение на онкологию', 1, 0.0000, 4, 1.0000,  7, 1)



EXEC [dbo].[versionUpdate] 562
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