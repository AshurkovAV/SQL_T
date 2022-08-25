BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 716

INSERT M001 ([IDDS], [DSNAME], [DATEBEG], [DATEEND], [Class], [Section], [Payable]) VALUES (N'U11', N'Необходимость иммунизации против COVID-19', CAST(0x0000AB3500000000 AS DateTime), NULL, 22, NULL, 1)
INSERT M001 ([IDDS], [DSNAME], [DATEBEG], [DATEEND], [Class], [Section], [Payable]) VALUES (N'U11.9', N'	Необходимость иммунизации против COVID-19 неуточненная', CAST(0x0000AB3500000000 AS DateTime), NULL, 22, NULL, 1)

EXEC [dbo].[versionUpdate] 717
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

