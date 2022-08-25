BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 549

CREATE TABLE [dbo].[ZFactCrit](
	[ZCritId] [int] IDENTITY(1,1) NOT NULL,
	[ZksgKpgId] [int] NOT NULL,
	[Value] [int] NULL,
 CONSTRAINT [PK_ZFactCrit] PRIMARY KEY CLUSTERED 
(
	[ZCritId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ZFactCrit]  WITH CHECK ADD  CONSTRAINT [FK_ZFactCrit_V024] FOREIGN KEY([Value])
REFERENCES [dbo].[V024] ([Id])

ALTER TABLE [dbo].[ZFactCrit] CHECK CONSTRAINT [FK_ZFactCrit_V024]

ALTER TABLE [dbo].[ZFactCrit]  WITH CHECK ADD  CONSTRAINT [FK_ZFactCrit_ZFactKsgKpg] FOREIGN KEY([ZksgKpgId])
REFERENCES [dbo].[ZFactKsgKpg] ([ZksgKpgId])

ALTER TABLE [dbo].[ZFactCrit] CHECK CONSTRAINT [FK_ZFactCrit_ZFactKsgKpg]

EXEC [dbo].[versionUpdate] 550
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