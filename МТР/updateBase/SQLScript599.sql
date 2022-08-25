BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 598

SET IDENTITY_INSERT [dbo].[FactExpertCriterion] ON 
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [FactExpertCriterionID], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003F.00.1240
--дата консилиума заполнена, а консилиум не проводился


--DECLARE @AccountID INT =28739
SELECT distinct e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
JOIN ZslFactMedicalEvent ze 
  ON ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID
JOIN ZFactMedicalEvent e 
  ON ze.ZslMedicalEventId = e.ZslMedicalEventId
--JOIN ZFactMedicalEventOnk onk 
--    ON onk.ZmedicalEventId = e.ZmedicalEventId
JOIN ZFactConsultations AS zc 
  ON zc.ZMedicalEventId = e.ZmedicalEventId
  AND zc.PrCons NOT IN (1,2,3)    
                  
          
WHERE zc.DtCons IS NOT NULL', N'003F.00.1240_Дата консилиума заполнена, а консилиум не проводился', N'003F.00.1240_Дата консилиума заполнена, а консилиум не проводился', N'Дата консилиума заполнена, а консилиум не проводился', 1, 0.0000, 4, 1.0000, 1319, 9, 2)
SET IDENTITY_INSERT [dbo].[FactExpertCriterion] OFF

EXEC [dbo].[versionUpdate] 599
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