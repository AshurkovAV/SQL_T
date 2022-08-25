CREATE TABLE [dbo].[ZFactMedicalEventOnk](
	[ZMedicalEventOnkId] [int] IDENTITY(1,1) NOT NULL,
	[ZmedicalEventId] [int] NOT NULL,
	[Ds1t] [int] NULL,
	[StageDisease] [int] NULL,
	[OnkT] [int] NULL,
	[OnkN] [int] NULL,
	[OnkM] [int] NULL,
	[Mtstz] [int] NULL,
	[Sod] [numeric](3, 2) NULL,
 CONSTRAINT [PK_ZFactMedicalEventOnk] PRIMARY KEY CLUSTERED 
(
	[ZMedicalEventOnkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalEventOnk_N002] FOREIGN KEY([StageDisease])
REFERENCES [dbo].[N002] ([ID_St])
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk] CHECK CONSTRAINT [FK_ZFactMedicalEventOnk_N002]
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalEventOnk_N003] FOREIGN KEY([OnkT])
REFERENCES [dbo].[N003] ([ID_T])
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk] CHECK CONSTRAINT [FK_ZFactMedicalEventOnk_N003]
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalEventOnk_N004] FOREIGN KEY([OnkN])
REFERENCES [dbo].[N004] ([ID_N])
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk] CHECK CONSTRAINT [FK_ZFactMedicalEventOnk_N004]
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalEventOnk_N005] FOREIGN KEY([OnkM])
REFERENCES [dbo].[N005] ([ID_M])
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk] CHECK CONSTRAINT [FK_ZFactMedicalEventOnk_N005]
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalEventOnk_ZFactMedicalEvent] FOREIGN KEY([ZmedicalEventId])
REFERENCES [dbo].[ZFactMedicalEvent] ([ZmedicalEventId])
GO

ALTER TABLE [dbo].[ZFactMedicalEventOnk] CHECK CONSTRAINT [FK_ZFactMedicalEventOnk_ZFactMedicalEvent]
GO


