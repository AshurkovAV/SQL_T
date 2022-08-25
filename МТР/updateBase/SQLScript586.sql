BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 585

ALTER TABLE [dbo].[FactPreparedReport]  WITH CHECK ADD  CONSTRAINT [FK_FactPreparedReport_FactReport] FOREIGN KEY([ReportId])
REFERENCES [dbo].[FactReport] ([FactReportID])
ALTER TABLE [dbo].[FactPreparedReport] CHECK CONSTRAINT [FK_FactPreparedReport_FactReport]

EXEC [dbo].[versionUpdate] 586
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



