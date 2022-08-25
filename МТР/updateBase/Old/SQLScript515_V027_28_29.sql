CREATE TABLE [dbo].[V027](
	Id INt IDENTITY(1,1) NOT NULL,
	[IDCZ] [int] NOT NULL,
	[N_CZ] [nvarchar](254) NOT NULL,
	[DATEBEG] [datetime] NOT NULL,
	[DATEEND] [datetime] NULL
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[V028](
	Id INt IDENTITY(1,1) NOT NULL,
	[IDVN] [int] NOT NULL,
	[N_VN] [nvarchar](254) NOT NULL,
	[DATEBEG] [datetime] NOT NULL,
	[DATEEND] [datetime] NULL
PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[V029](
	Id INt IDENTITY(1,1) NOT NULL,
	[IDMET] [int] NOT NULL,
	[N_MET] [nvarchar](300) NULL,
	[DATEBEG] [datetime] NULL,
	[DATEEND] [datetime] NULL
PRIMARY KEY CLUSTERED 
(
	Id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[V027] ([IDCZ], [N_CZ], [DATEBEG], [DATEEND]) VALUES (1, N'Острое', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V027] ([IDCZ], [N_CZ], [DATEBEG], [DATEEND]) VALUES (2, N'Впервые в жизни установленное хроническое', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V027] ([IDCZ], [N_CZ], [DATEBEG], [DATEEND]) VALUES (3, N'Ранее установленное хроническое', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V028] ([IDVN], [N_VN], [DATEBEG], [DATEEND]) VALUES (1, N'Направление к онкологу', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V028] ([IDVN], [N_VN], [DATEBEG], [DATEEND]) VALUES (2, N'Направление на биопсию', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V028] ([IDVN], [N_VN], [DATEBEG], [DATEEND]) VALUES (3, N'Направление на дообследование', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V028] ([IDVN], [N_VN], [DATEBEG], [DATEEND]) VALUES (4, N'Направление для определения тактики обследования и/или тактики лечения', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V029] ([IDMET], [N_MET], [DATEBEG], [DATEEND]) VALUES (1, N'Лабораторная диагностика', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V029] ([IDMET], [N_MET], [DATEBEG], [DATEEND]) VALUES (2, N'Инструментальная диагностика', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V029] ([IDMET], [N_MET], [DATEBEG], [DATEEND]) VALUES (3, N'Методы лучевой диагностики, за исключением дорогостоящих', CAST(0x0000A94E00000000 AS DateTime), NULL)
INSERT [dbo].[V029] ([IDMET], [N_MET], [DATEBEG], [DATEEND]) VALUES (4, N'Дорогостоящие методы лучевой диагностики (КТ, МРТ, ангиография)', CAST(0x0000A94E00000000 AS DateTime), NULL)
