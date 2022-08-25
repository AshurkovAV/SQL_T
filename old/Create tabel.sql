CREATE TABLE [dbo].[AttachedDoctorSpr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FAM] [nvarchar](50) NOT NULL,
	[IM] [nvarchar](50) NULL,
	[OT] [nvarchar](50) NULL,
	[DR] [datetime] NULL,
	[SNILS] [nvarchar](14) NOT NULL,
	[PROFIL] [int] NULL,
	[NameWithID]  AS ((((((([FAM]+' ')+substring(isnull([IM],' '),(1),(1)))+'. ')+substring(isnull([OT],' '),(1),(1)))+'. (')+[SNILS])+')'),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SNILS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AttachedDoctorSpr]  WITH CHECK ADD  CONSTRAINT [FK_AttachedDoctorSpr_V002] FOREIGN KEY([PROFIL])
REFERENCES [dbo].[V002] ([Id])
GO

ALTER TABLE [dbo].[AttachedDoctorSpr] CHECK CONSTRAINT [FK_AttachedDoctorSpr_V002]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Фамилия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AttachedDoctorSpr', @level2type=N'COLUMN',@level2name=N'FAM'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Имя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AttachedDoctorSpr', @level2type=N'COLUMN',@level2name=N'IM'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Отчество' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AttachedDoctorSpr', @level2type=N'COLUMN',@level2name=N'OT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Дата рождения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AttachedDoctorSpr', @level2type=N'COLUMN',@level2name=N'DR'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'СНИЛС' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AttachedDoctorSpr', @level2type=N'COLUMN',@level2name=N'SNILS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Профиль' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AttachedDoctorSpr', @level2type=N'COLUMN',@level2name=N'PROFIL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Справочник врачей (локальный)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AttachedDoctorSpr'
GO

CREATE TABLE [dbo].[AttachedJournalSpr](
	[ID] [int] NOT NULL,
	[FAM] [nvarchar](50) NULL,
	[IM] [nvarchar](50) NULL,
	[OT] [nvarchar](50) NULL,
	[DR] [datetime] NULL,
 CONSTRAINT [PK_AttachedJournalSpr] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[AttachedPeopleSpr](
	[ID] [int] NOT NULL,
	[FAM] [nvarchar](50) NULL,
	[IM] [nvarchar](50) NULL,
	[OT] [nvarchar](50) NULL,
	[DR] [datetime] NULL,
	[W] [int] NULL,
	[MR] [nvarchar](100) NULL,
	[TUDL] [int] NULL,
	[NUDL] [nvarchar](40) NULL,
	[DUDL] [datetime] NULL,
	[OUDL] [nvarchar](200) NULL,
	[SNILS] [nvarchar](200) NULL,
	[TempID] [nvarchar](16) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


