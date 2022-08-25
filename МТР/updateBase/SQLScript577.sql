BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 576

INSERT INTO [FactExpertCriterion] ([Code]
      ,[Weight]
      ,[Reason]
      ,[PG]
      ,[Type]
      ,[IsEnable]
      ,[DateBegin]
      ,[DateEnd]
      ,[Scope]
      ,[Query]
      ,[Description]
      ,[Comments]
      ,[Name]
      ,[IsAuto]
      ,[PenaltyPercent]
      ,[ErrorScope]
      ,[RefusalPercent]   
      ,[Version]
      ,[Group])
SELECT [Code]
      ,[Weight]
      ,[Reason]
      ,[PG]
      ,[Type]
      ,[IsEnable]
      ,[DateBegin]
      ,[DateEnd]
      ,[Scope]
      ,REPLACE([Query], 'use medicine_ins ', '')[Query]
      ,[Description]
      ,[Comments]
      ,[Name]
      ,[IsAuto]
      ,[PenaltyPercent]
      ,[ErrorScope]
      ,[RefusalPercent]   
      ,9 [Version]
      ,[Group]
  FROM [FactExpertCriterion]
WHERE Version = 7

EXEC [dbo].[versionUpdate] 577
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


  