BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 702

CREATE TABLE [dbo].[V019](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IDHM] [int] NOT NULL,
	[HMNAME] [nvarchar](1000) NOT NULL,
	[DIAG] [nvarchar](4000) NOT NULL,
	[HVID] [nvarchar](255) NULL,
	[DATEBEG] [datetime] NOT NULL,
	[DATEEND] [datetime] NULL,
	[HGR] [int] NULL,
	[HMODP] [nvarchar](255) NULL,
	[IDMODP] [int] NULL,
 CONSTRAINT [PK_V019_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

EXEC [dbo].[versionUpdate] 703
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
