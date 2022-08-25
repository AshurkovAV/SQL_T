BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 599

CREATE TABLE [dbo].[globalVidControl](
	[VidControlId] [int] NOT NULL,
	[ControlCode] [int] NULL,
	[ControlName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[VidControlId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


INSERT [dbo].[globalVidControl] ([VidControlId], [ControlCode], [ControlName]) VALUES (1, 1, N'���')
INSERT [dbo].[globalVidControl] ([VidControlId], [ControlCode], [ControlName]) VALUES (2, 2, N'���')
INSERT [dbo].[globalVidControl] ([VidControlId], [ControlCode], [ControlName]) VALUES (3, 3, N'����')
INSERT [dbo].[globalVidControl] ([VidControlId], [ControlCode], [ControlName]) VALUES (4, 4, N'������������ ���')
INSERT [dbo].[globalVidControl] ([VidControlId], [ControlCode], [ControlName]) VALUES (5, 5, N'������������ ���')
INSERT [dbo].[globalVidControl] ([VidControlId], [ControlCode], [ControlName]) VALUES (6, 5, N'������������ ����')

EXEC [dbo].[versionUpdate] 600
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