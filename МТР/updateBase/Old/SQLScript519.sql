ALTER TABLE [dbo].[ZFactMedicalServicesOnk] DROP CONSTRAINT [FK_ZFactMedicalServicesOnk_ZFactMedicalServices]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] DROP CONSTRAINT [FK_ZFactMedicalServicesOnk_N017]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] DROP CONSTRAINT [FK_ZFactMedicalServicesOnk_N016]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] DROP CONSTRAINT [FK_ZFactMedicalServicesOnk_N015]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] DROP CONSTRAINT [FK_ZFactMedicalServicesOnk_N014]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] DROP CONSTRAINT [FK_ZFactMedicalServicesOnk_N013]
GO

/****** Object:  Table [dbo].[ZFactMedicalServicesOnk]    Script Date: 27.11.2018 22:49:03 ******/
DROP TABLE [dbo].[ZFactMedicalServicesOnk]
GO

/****** Object:  Table [dbo].[ZFactMedicalServicesOnk]    Script Date: 27.11.2018 22:49:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ZFactMedicalServicesOnk](
	[ZmedicalServicesOnkId] [int] IDENTITY(1,1) NOT NULL,
	[ZmedicalEventOnkId] [int] NOT NULL,	
	[ServicesOnkTypeId] [int] NULL,
	[HirTypeId] [int] NULL,
	[LekTypeLId] [int] NULL,
	[LekTypeVId] [int] NULL,
	[LuchTypeId] [int] NULL,
 CONSTRAINT [PK_ZFactMedicalServicesOnk] PRIMARY KEY CLUSTERED 
(
	[ZmedicalServicesOnkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServicesOnk_N013] FOREIGN KEY([ServicesOnkTypeId])
REFERENCES [dbo].[N013] ([ID_TLech])
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] CHECK CONSTRAINT [FK_ZFactMedicalServicesOnk_N013]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServicesOnk_N014] FOREIGN KEY([HirTypeId])
REFERENCES [dbo].[N014] ([ID_THir])
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] CHECK CONSTRAINT [FK_ZFactMedicalServicesOnk_N014]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServicesOnk_N015] FOREIGN KEY([LekTypeLId])
REFERENCES [dbo].[N015] ([ID_TLek_L])
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] CHECK CONSTRAINT [FK_ZFactMedicalServicesOnk_N015]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServicesOnk_N016] FOREIGN KEY([LekTypeVId])
REFERENCES [dbo].[N016] ([ID_TLek_V])
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] CHECK CONSTRAINT [FK_ZFactMedicalServicesOnk_N016]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServicesOnk_N017] FOREIGN KEY([LuchTypeId])
REFERENCES [dbo].[N017] ([ID_TLuch])
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] CHECK CONSTRAINT [FK_ZFactMedicalServicesOnk_N017]
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServicesOnk_ZFactMedicalEventOnk] FOREIGN KEY([ZmedicalEventOnkId])
REFERENCES [dbo].[ZFactMedicalEventOnk] (ZMedicalEventOnkId)
GO

ALTER TABLE [dbo].[ZFactMedicalServicesOnk] CHECK CONSTRAINT [FK_ZFactMedicalServicesOnk_ZFactMedicalEventOnk]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Сведения об услуге при лечении онкологического заболевания' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ZFactMedicalServicesOnk'
GO