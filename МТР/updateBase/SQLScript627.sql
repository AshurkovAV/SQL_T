BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 626


UPDATE fec SET fec.IsEnable = 0, fec.IsAuto = 0
    FROM FactExpertCriterion AS fec
WHERE fec.Comments LIKE '��������� �� �� ������������� ������� �������%'
	AND fec.Version = 9

EXEC [dbo].[versionUpdate] 627
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

