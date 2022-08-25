BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 600


CREATE TABLE [dbo].[globalActExpertiseStatus](
	[ActExpertiseStatusId] [int] NOT NULL,
	[StatusCode] [int] NULL,
	[StatusName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ActExpertiseStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


INSERT [dbo].[globalActExpertiseStatus] ([ActExpertiseStatusId], [StatusCode], [StatusName]) VALUES (1, 1, N'Íîâûé')
INSERT [dbo].[globalActExpertiseStatus] ([ActExpertiseStatusId], [StatusCode], [StatusName]) VALUES (2, 2, N'Óòâåðæäåí')

EXEC [dbo].[versionUpdate] 601
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