BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 719

CREATE TABLE [dbo].[FactEconomicFin](
	[EconomicFinId] [int] IDENTITY(1,1) NOT NULL,
	[FinOrder] [nvarchar](254) NULL,
	[FinDate] [datetime] NULL,
	[FinDateBegin] [datetime] NULL,
	[FinDateEnd] [datetime] NULL,
	[TotalAmount] [money] NULL,
	[Kol] [int] NULL,
	[SumPayment] [money] NULL,
	[CancelKol] [int] NULL,
	[SumCancelPayment] [money] NULL,
	[Body] [varbinary](max) NULL,
	[Comments] [nvarchar](254) NULL,
PRIMARY KEY CLUSTERED 
(
	[EconomicFinId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



EXEC [dbo].[versionUpdate] 720
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


