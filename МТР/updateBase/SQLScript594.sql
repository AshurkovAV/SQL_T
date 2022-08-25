BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 593

CREATE TABLE [dbo].[globalSchetType](
	[ID] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[LPref] [nvarchar](10) NULL,
 CONSTRAINT [PK_globalSchetType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'C', N'Онко счет', N'LC')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'DF', N'Счет профосмотр несовершеннолетных', N'LF')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'DO', N'Счет профосмотр взрослых', N'LO')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'DP', N'Счет 1 этап диспансеризации взрослых', N'LP')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'DS', N'Счет детей-сирот', N'LS')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'DU', N'Счет детей принятых под опеку', N'LU')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'DV', N'Счет 2 этап диспансеризации взрослых', N'LV')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'H', N'Общий счёт', N'L')
INSERT [dbo].[globalSchetType] ([ID], [Name], [LPref]) VALUES (N'T', N'ВМТ счет', N'LT')

EXEC [dbo].[versionUpdate] 594
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