
BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 666


CREATE TABLE [dbo].[list_for_forma2](
	[str_NAIM] [nvarchar](255) NULL,
	[N_str] [nvarchar](255) NULL,
	[id] [float] NULL
) ON [PRIMARY]

CREATE TABLE [dbo].[profil_for_list](
	[id] [float] NULL,
	[id_str] [float] NULL,
	[profil] [float] NULL
) ON [PRIMARY]

INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'ВСЕГО:', N'1', 1)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Акушерское дело', N'2', 2)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Акушерство и гинекология, из них:', N'3', 3)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'случаи экстракорпорального оплодотворения', N'3.1', 4)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Аллергология и иммунология', N'4', 5)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Гастроэнтерология', N'5', 6)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Гематология', N'6', 7)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Гериатрия', N'7', 8)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Дерматология', N'8', 9)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Детская онкология, из них:', N'9', 10)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'детская онкогематология', N'9.1', 11)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'химиотерапия', N'9.2', 12)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'радиология, радиотерапия', N'9.3', 13)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Инфекционные болезни', N'10', 14)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Кардиология', N'11', 15)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Колопроктология', N'12', 16)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Медицинская реабилитация', N'13', 17)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Неврология', N'14', 18)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Нейрохирургия', N'15', 19)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Неонатология', N'16', 20)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Нефрология', N'17', 21)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Онкология, из них:', N'18', 22)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'онкогематология', N'18.1', 23)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'химиотерапия', N'18.2', 24)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'радиология, радиотерапия', N'18.3', 25)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Оториноларингология', N'19', 26)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Офтальмология', N'20', 27)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Педиатрия', N'21', 28)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Пульмонология', N'22', 29)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Ревматология', N'23', 30)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Сердечно-сосудистая хирургия', N'24', 31)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Терапия', N'25', 32)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Торакальная хирургия', N'26', 33)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Травматология и ортопедия', N'27', 34)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Урология', N'28', 35)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Хирургия (абдоминальная)', N'29', 36)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Хирургия (комбустиология)', N'30', 37)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Челюстно-лицевая хирургия', N'31', 38)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Эндокринология', N'32', 39)
INSERT [dbo].[list_for_forma2] ([str_NAIM], [N_str], [id]) VALUES (N'Прочие', N'33', 40)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (1, 1, NULL)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (2, 2, 3)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (3, 3, 2)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (4, 3, 136)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (5, 3, 137)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (6, 3, 184)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (7, 4, 137)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (8, 5, 4)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (9, 6, 11)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (10, 7, 12)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (11, 8, 14)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (12, 9, 16)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (13, 10, 18)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (14, 11, NULL)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (15, 12, NULL)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (16, 13, NULL)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (17, 14, 28)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (18, 15, 29)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (19, 16, 30)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (20, 17, 158)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (21, 18, 53)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (22, 19, 54)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (23, 20, 55)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (24, 21, 56)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (25, 22, 60)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (26, 23, NULL)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (27, 24, NULL)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (28, 25, NULL)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (29, 26, 64)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (30, 26, 162)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (31, 26, 163)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (32, 27, 65)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (33, 28, 68)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (34, 29, 75)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (35, 30, 77)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (36, 31, 81)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (37, 32, 97)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (38, 33, 99)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (39, 34, 100)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (40, 35, 108)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (41, 36, 1)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (42, 37, 114)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (43, 38, 116)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (44, 39, 122)
INSERT [dbo].[profil_for_list] ([id], [id_str], [profil]) VALUES (45, 40, NULL)


EXEC [dbo].[versionUpdate] 667
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