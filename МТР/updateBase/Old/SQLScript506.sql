CREATE TABLE [dbo].[ZFactDirection](
	[ZDirectionId] [int] IDENTITY(1,1) NOT NULL,
	[ZmedicalServicesId] [int] NOT NULL,
	[DirectionDate] [datetime] NULL,
	[DirectionViewId] [int] NULL,
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

ALTER TABLE [dbo].[ZFactDirection]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDirection_ZFactMedicalServices] FOREIGN KEY([ZmedicalServicesId])
REFERENCES [dbo].[ZFactMedicalServices] ([ZmedicalServicesId])
GO

ALTER TABLE [dbo].[ZFactDirection] CHECK CONSTRAINT [FK_ZFactDirection_ZFactMedicalServices]
GO


