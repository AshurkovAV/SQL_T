BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[versionÑheck] 568

CREATE TABLE [dbo].[N021](
	[ID_ZAP] [nvarchar](15) NULL,
	[CODE_SH] [nvarchar](10) NULL,
	[ID_LEKP] [nvarchar](6) NULL,
	[DATEBEG] [date] NULL,
	[DATEEND] [date] NULL
) ON [PRIMARY]
               
EXEC [dbo].[versionUpdate] 569
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