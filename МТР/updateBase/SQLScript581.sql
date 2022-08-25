BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 580

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


	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.064.002', N'���������������� ����� (������, ������������) �����-����������� ��������', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.006', N'���������������� ����� (������, ������������) �����-�����������', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.002', N'���������������� ����� (������, ������������) �����-�����������-���������', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.067.001', N'����� (������, ������������) �����-�����������-������� ���������', 90, 72, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.067.002', N'����� (������, ������������) �����-�����������-������� ���������', 90, 72, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.064.003', N'����� (������, ������������) �����-����������� �������� ���������', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.064.004', N'����� (������, ������������) �����-����������� �������� ���������', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.064.001', N'������������ ����� (������, ������������) �����-����������� ��������', 86, 68, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.007', N'����� (������, ������������) �����-����������� ���������', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.008', N'����� (������, ������������) �����-����������� ���������', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.005', N'������������ ����� (������, ������������) �����-�����������', 171, 69, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.001', N'����� (������, ������������) �����-�����������-��������� ���������', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.002', N'����� (������, ������������) �����-�����������-��������� ���������', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.001', N'������������ ����� (������, ������������) �����-�����������-���������', 89, 71, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.003', N'����� (������, ������������) ������� ����� ���������', 85, 208, 11)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.065.004', N'����� (������, ������������) ������� ����� ���������', 85, 208, 11)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.065.003', N'������������ ����� (������, ������������) ������� �����', 85, 208, 11)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.063.001', N'����� (������, ������������) �����-��������� ���������', 63, 43, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B01.063.002', N'����� (������, ������������) �����-��������� ���������', 63, 43, 13)
	INSERT [dbo].[SprVME_Prof_Spec] ([VidVME], [VidVMEname], [Profil], [Spec], [VidPom]) VALUES (N'B04.063.001', N'������������ ����� (������, ������������) �����-���������', 63, 43, 13)

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
