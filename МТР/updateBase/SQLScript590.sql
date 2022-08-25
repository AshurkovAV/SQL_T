BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 589

ALTER TABLE [dbo].[ZFactDs]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDs_ZFactMedicalEvent] FOREIGN KEY([ZmedicalEventId])
REFERENCES [dbo].[ZFactMedicalEvent] ([ZmedicalEventId])

ALTER TABLE [dbo].[ZFactDs] CHECK CONSTRAINT [FK_ZFactDs_ZFactMedicalEvent]


EXEC [dbo].[versionUpdate] 590
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



