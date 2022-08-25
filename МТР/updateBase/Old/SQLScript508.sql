CREATE TABLE [dbo].[globalConsultationOnk](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[globalConsultationOnk] ON 

INSERT [dbo].[globalConsultationOnk] ([Id], [Name]) VALUES (1, N'���������� ������� ������������')
INSERT [dbo].[globalConsultationOnk] ([Id], [Name]) VALUES (2, N'���������� ������� �������')
INSERT [dbo].[globalConsultationOnk] ([Id], [Name]) VALUES (3, N'�������� ������� �������')
SET IDENTITY_INSERT [dbo].[globalConsultationOnk] OFF
