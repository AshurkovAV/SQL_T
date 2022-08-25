BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 588

CREATE TABLE [dbo].[ZFactDs](
	[ZFactDsId] [int] IDENTITY(1,1) NOT NULL,
	[ZmedicalEventId] [int] NOT NULL,	
	[Ds] [nvarchar](10) NULL,
	[DsPr] [int] NULL,
	[DsType] [int] NULL,
	[PrDs2N] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	ZFactDsId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

EXEC [dbo].[versionUpdate] 589
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



