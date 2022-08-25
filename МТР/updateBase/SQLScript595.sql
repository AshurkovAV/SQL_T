BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 594

ALTER TABLE [dbo].[FactMedicalAccount]  WITH CHECK ADD  CONSTRAINT [FK_FactMedicalAccount_globalSchetType] FOREIGN KEY(SchetType)
REFERENCES [dbo].[globalSchetType] ([ID])
ALTER TABLE [dbo].[FactMedicalAccount] CHECK CONSTRAINT [FK_FactMedicalAccount_globalSchetType]

EXEC [dbo].[versionUpdate] 595
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

