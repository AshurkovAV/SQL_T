BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 720

CREATE TABLE [dbo].[FactEconomicFinDetail](
	[EconomicFinDetailId] [int] IDENTITY(1,1) NOT NULL,
	[EconomicFinId] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[NameTfk] [nvarchar](250) NULL,
	[AccountNumber] [nvarchar](15) NULL,
	[AccountDate] [datetime] NULL,
	[Kol] [int] NULL,
	[SumPayment] [money] NULL,
	[CancelKol] [int] NULL,
	[SumCancelPayment] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[EconomicFinDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[FactEconomicFinDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactEconomicFinDetail_FactEconomicFin] FOREIGN KEY([EconomicFinId])
REFERENCES [dbo].[FactEconomicFin] ([EconomicFinId])

ALTER TABLE [dbo].[FactEconomicFinDetail] CHECK CONSTRAINT [FK_FactEconomicFinDetail_FactEconomicFin]

ALTER TABLE [dbo].[FactEconomicFinDetail]  WITH CHECK ADD  CONSTRAINT [FK_FactEconomicFinDetail_FactTerritoryAccount] FOREIGN KEY([AccountId])
REFERENCES [dbo].[FactTerritoryAccount] ([TerritoryAccountId])

ALTER TABLE [dbo].[FactEconomicFinDetail] CHECK CONSTRAINT [FK_FactEconomicFinDetail_FactTerritoryAccount]


EXEC [dbo].[versionUpdate] 721
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




