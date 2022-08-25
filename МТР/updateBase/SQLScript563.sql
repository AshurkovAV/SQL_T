BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[version�heck] 562

ALTER TABLE [dbo].[ZFactDirection] DROP CONSTRAINT [FK_ZFactDirection_globalDirectionView]

ALTER TABLE [dbo].[ZFactDirection]  WITH NOCHECK ADD  CONSTRAINT [FK_ZFactDirection_V028] FOREIGN KEY([DirectionViewId])
REFERENCES [dbo].V028 ([Id])

ALTER TABLE [dbo].[ZFactDirection] CHECK CONSTRAINT [FK_ZFactDirection_V028]

EXEC [dbo].[versionUpdate] 563
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