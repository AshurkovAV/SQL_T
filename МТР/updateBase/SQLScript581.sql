BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 580

IF (NOT EXISTS (SELECT *
FROM INFORMATION_SCHEMA.TABLES s 
WHERE s.TABLE_TYPE = 'BASE TABLE' AND s.TABLE_NAME = 'SprVME_Prof_Spec'))
BEGIN
	CREATE TABLE [dbo].[SprVME_Prof_Spec](
		[VidVME] [nvarchar](255) NULL,
		[VidVMEname] [nvarchar](255) NULL,
		[Profil] [float] NULL,
		[Spec] [float] NULL,
		[VidPom] [float] NULL
	) ON [PRIMARY]


	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.064.002', N'Профилактический прием (осмотр, консультация) врача-стоматолога детского', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.006', N'Профилактический прием (осмотр, консультация) врача-стоматолога', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.002', N'Профилактический прием (осмотр, консультация) врача-стоматолога-терапевта', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.067.001', N'Прием (осмотр, консультация) врача-стоматолога-хирурга первичный', 90, 72, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.067.002', N'Прием (осмотр, консультация) врача-стоматолога-хирурга повторный', 90, 72, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.064.003', N'Прием (осмотр, консультация) врача-стоматолога детского первичный', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.064.004', N'Прием (осмотр, консультация) врача-стоматолога детского повторный', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.064.001', N'Диспансерный прием (осмотр, консультация) врача-стоматолога детского', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.007', N'Прием (осмотр, консультация) врача-стоматолога первичный', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.008', N'Прием (осмотр, консультация) врача-стоматолога повторный', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.005', N'Диспансерный прием (осмотр, консультация) врача-стоматолога', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.001', N'Прием (осмотр, консультация) врача-стоматолога-терапевта первичный', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.002', N'Прием (осмотр, консультация) врача-стоматолога-терапевта повторный', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.001', N'Диспансерный прием (осмотр, консультация) врача-стоматолога-терапевта', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.003', N'Прием (осмотр, консультация) зубного врача первичный', 85, 208, 11)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.004', N'Прием (осмотр, консультация) зубного врача повторный', 85, 208, 11)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.003', N'Диспансерный прием (осмотр, консультация) зубного врача', 85, 208, 11)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.063.001', N'Прием (осмотр, консультация) врача-ортодонта первичный', 63, 43, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.063.002', N'Прием (осмотр, консультация) врача-ортодонта повторный', 63, 43, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.063.001', N'Диспансерный прием (осмотр, консультация) врача-ортодонта', 63, 43, 13)

END


EXEC [dbo].[versionUpdate] 581
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
