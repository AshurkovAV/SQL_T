CREATE TABLE [dbo].[V025](
	[IDPC] [nvarchar](3) NULL,
	[N_PC] [nvarchar](254) NULL,
	[DATEBEG] [date] NULL,
	[DATEEND] [date] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'1.0', N'Посещение по заболеванию', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'1.1', N'Посещениe в неотложной форме', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'1.2', N'Aктивное посещение', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'1.3', N'Диспансерное наблюдение', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'2.1', N'Медицинский осмотр', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'2.2', N'Диспансеризация', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'2.3', N'Комплексное обследование', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'2.5', N'Патронаж', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'2.6', N'Посещение по другим обстоятельствам', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'3.0', N'Обращение по заболеванию', CAST(0xB63D0B00 AS Date), NULL)
INSERT [dbo].[V025] ([IDPC], [N_PC], [DATEBEG], [DATEEND]) VALUES (N'3.1', N'Обращение с профилактической целью.', CAST(0xB63D0B00 AS Date), NULL)
