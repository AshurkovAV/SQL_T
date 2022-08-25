BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		 
EXEC [dbo].[versionÑheck] 606 

EXECUTE('CREATE VIEW [dbo].[SankShortView] AS 
SELECT t1.PName, t1.Surname, [t1].Patronymic, t1.Birthday, 
CAST(v6.IDUMP AS NVARCHAR(1)) + ''  '' + v6.UMPNAME uslok,
sl.EventBegin, sl.EventEnd, m.IDDS + ''  '' + m.DSNAME ds1,
v.IDPC + ''  '' + v.N_PC p_cel, zsl.AcceptPrice, zsl.Price, zsl.RefusalPrice,
f.Osn + '' '' + f.Comments osn,
p.MedicalAccountId,
zs.ActExpertiseId
FROM ZFactSank AS zs
JOIN [FactPatient] AS p ON p.PatientId = zs.PatientId
LEFT OUTER JOIN [FactPerson] AS [t1] ON [t1].[PersonId] = p.[PersonalId]
JOIN ZslFactMedicalEvent AS zsl ON zsl.PatientId = p.PatientId
JOIN ZFactMedicalEvent AS sl ON sl.ZslMedicalEventId = zsl.ZslMedicalEventId AND sl.ZmedicalEventId = zs.ZmedicalEventId
LEFT JOIN v025 v ON v.IDPC = sl.Pcel
LEFT JOIN v006 v6 ON v6.id = zsl.AssistanceConditions
LEFT JOIN F014 AS f ON f.Id = zs.ReasonId
LEFT JOIN M001 AS m ON m.Id = sl.DiagnosisGeneral')


EXEC [dbo].[versionUpdate] 607
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