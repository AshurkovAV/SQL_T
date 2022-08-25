CREATE TABLE [dbo].[globalDirectionView](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_globalDirectionView] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[globalMetIssl](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[globalDirectionView] ON 

INSERT [dbo].[globalDirectionView] ([Id], [Name]) VALUES (1, N'Направление к онкологу')
INSERT [dbo].[globalDirectionView] ([Id], [Name]) VALUES (2, N'Направление на биопсию')
INSERT [dbo].[globalDirectionView] ([Id], [Name]) VALUES (3, N'Направление на дообследование')
SET IDENTITY_INSERT [dbo].[globalDirectionView] OFF
SET IDENTITY_INSERT [dbo].[globalMetIssl] ON 

INSERT [dbo].[globalMetIssl] ([Id], [Name]) VALUES (1, N'Лабораторная диагностика')
INSERT [dbo].[globalMetIssl] ([Id], [Name]) VALUES (2, N'Инструментальная диагностика')
INSERT [dbo].[globalMetIssl] ([Id], [Name]) VALUES (3, N'Методы лучевой диагностики, за исключением дорогостоящих')
INSERT [dbo].[globalMetIssl] ([Id], [Name]) VALUES (4, N'Дорогостоящие методы лучевой диагностики (КТ, МРТ, ангиография)')
SET IDENTITY_INSERT [dbo].[globalMetIssl] OFF
