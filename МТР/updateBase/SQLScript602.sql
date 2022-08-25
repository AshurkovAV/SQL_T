BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 601

CREATE TABLE [dbo].[FactActExpertise](
	[ActExpertiseId] [int] IDENTITY(1,1) NOT NULL,
	[NumAct] [nvarchar](10) NULL,
	[DateAct] [datetime] NULL,
	[Mo] [nvarchar](10) NULL,
	[Smo] [nvarchar](10) NULL,
	[VidControlId] [int] NULL,
	[VidExpertiseId] [int] NULL,
	[DateExpertiseBegin] [datetime] NULL,
	[DateExpertiseEnd] [datetime] NULL,
	[ActExspertiStatusId] [int] NULL,
	[MedicalAccountId] [int] NULL,
	[DateEdit] [datetime] NULL,
 CONSTRAINT [PK_FactActExpertise] PRIMARY KEY CLUSTERED 
(
	[ActExpertiseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[FactActExpertise]  WITH CHECK ADD  CONSTRAINT [FK_FactActExpertise_globalActExpertiseStatus] FOREIGN KEY([ActExspertiStatusId])
REFERENCES [dbo].[globalActExpertiseStatus] ([ActExpertiseStatusId])

ALTER TABLE [dbo].[FactActExpertise] CHECK CONSTRAINT [FK_FactActExpertise_globalActExpertiseStatus]

ALTER TABLE [dbo].[FactActExpertise]  WITH CHECK ADD  CONSTRAINT [FK_FactActExpertise_globalVidControl] FOREIGN KEY([VidControlId])
REFERENCES [dbo].[globalVidControl] ([VidControlId])
ALTER TABLE [dbo].[FactActExpertise] CHECK CONSTRAINT [FK_FactActExpertise_globalVidControl]

EXEC [dbo].[versionUpdate] 602
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

