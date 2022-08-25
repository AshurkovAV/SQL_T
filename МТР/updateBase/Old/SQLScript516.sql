ALTER TABLE [dbo].[ZFactDirection] DROP CONSTRAINT [FK_ZFactDirection_ZFactMedicalServices]
GO

ALTER TABLE [dbo].[ZFactDirection] DROP CONSTRAINT [FK_ZFactDirection_globalMetIssl]
GO

ALTER TABLE [dbo].[ZFactDirection] DROP CONSTRAINT [FK_ZFactDirection_globalDirectionView]
GO

/****** Object:  Table [dbo].[ZFactDirection]    Script Date: 27.11.2018 22:12:24 ******/
DROP TABLE [dbo].[ZFactDirection]
GO

/****** Object:  Table [dbo].[ZFactDirection]    Script Date: 27.11.2018 22:12:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ZFactDirection](
	[ZDirectionId] [int] IDENTITY(1,1) NOT NULL,
	[ZmedicalEventId] [int] NOT NULL,
	[DirectionDate] [datetime] NOT NULL,
	DirectionMo NVARCHAR(6) NULL,
	[DirectionViewId] [int] NOT NULL,
	[MetIsslId] [int] NULL,
	[DirectionService] [nvarchar](15) NULL,
 CONSTRAINT [PK_ZFactDirection] PRIMARY KEY CLUSTERED 
(
	[ZDirectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ZFactDirection]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDirection_globalDirectionView] FOREIGN KEY([DirectionViewId])
REFERENCES [dbo].[globalDirectionView] ([Id])
GO

ALTER TABLE [dbo].[ZFactDirection] CHECK CONSTRAINT [FK_ZFactDirection_globalDirectionView]
GO

ALTER TABLE [dbo].[ZFactDirection]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDirection_globalMetIssl] FOREIGN KEY([MetIsslId])
REFERENCES [dbo].[globalMetIssl] ([Id])
GO

ALTER TABLE [dbo].[ZFactDirection] CHECK CONSTRAINT [FK_ZFactDirection_globalMetIssl]
GO

ALTER TABLE [dbo].[ZFactDirection]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDirection_ZFactMedicalEvent] FOREIGN KEY([ZmedicalEventId])
REFERENCES [dbo].[ZFactMedicalEvent] ([ZmedicalEventId])
GO

ALTER TABLE [dbo].[ZFactDirection] CHECK CONSTRAINT [FK_ZFactDirection_ZFactMedicalEvent]
GO


