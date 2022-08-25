BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		 
EXEC [dbo].[versionÑheck] 604

EXECUTE('CREATE VIEW dbo.[ActExpertiseShortView]
AS
SELECT fae.ActExpertiseId, fae.NumAct, fae.DateAct, 
fae.Mo, CAST(fae.Mo AS NVARCHAR(6)) + ''  '' + f2.nam_mok AS MoShort, 
fae.Smo, CAST(fae.Smo AS NVARCHAR(6)) + ''  '' + f.nam_smok AS SmoShort,
fae.VidControlId, CAST(gvc.ControlCode AS NVARCHAR(10)) + ''  '' + gvc.ControlName AS VidControlShort,
fae.VidExpertiseId, CAST(f3.IDVID AS NVARCHAR(10)) + ''  '' + f3.VIDNAME AS VidExpertiseShort,
fae.DateExpertiseBegin, fae.DateExpertiseEnd,
fae.ActExspertiStatusId, CAST(gaes.StatusCode AS NVARCHAR(10)) + '' '' + gaes.StatusName AS ActExspertiStatusShort,
fae.MedicalAccountId, ''Ñ÷åò ÌÎ ¹ '' + CAST(mav.AccountNumber AS NVARCHAR(30)) + '' îò '' + CONVERT(NVARCHAR(10), mav.AccountDate ,102) AS MedicalAccountShort
FROM FactActExpertise AS fae
LEFT JOIN (SELECT F002.smocod, F002.nam_smok FROM F002 GROUP BY F002.smocod, F002.nam_smok) AS f ON fae.Smo = f.smocod
LEFT JOIN (SELECT F003.mcod, F003.nam_mok FROM F003 GROUP BY F003.mcod, F003.nam_mok) AS f2 ON fae.Mo = f2.mcod
LEFT JOIN globalVidControl AS gvc ON gvc.VidControlId = fae.VidControlId
LEFT JOIN globalActExpertiseStatus AS gaes ON gaes.ActExpertiseStatusId = fae.ActExspertiStatusId
LEFT JOIN F006 AS f3 ON fae.VidExpertiseId = f3.IDVID
LEFT JOIN MedicalAccountView AS mav ON mav.MedicalAccountId = fae.MedicalAccountId ')


EXEC [dbo].[versionUpdate] 605
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

