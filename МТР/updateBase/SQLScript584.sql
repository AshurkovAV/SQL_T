BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 583

SET IDENTITY_INSERT [dbo].[globalReportType] ON 

INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (1, N'��� ���')
INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (2, N'��� ���')
INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (3, N'��� ����')
INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (4, N'��� ��� �������')
INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (5, N'��� ��� �������')
INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (6, N'��� ���� �������')
INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (7, N'����')
INSERT [dbo].[globalReportType] ([ReportTypeID], [Name]) VALUES (8, N'������')

SET IDENTITY_INSERT [dbo].[globalReportType] OFF

EXEC [dbo].[versionUpdate] 584
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
