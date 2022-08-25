ALTER TABLE ZFactMedicalServices ADD [SpecialityCodeV015] [int] NULL
GO

ALTER TABLE [dbo].[ZFactMedicalServices]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServices_V015] FOREIGN KEY([SpecialityCodeV015])
REFERENCES [dbo].[V015] ([Id])
GO

ALTER TABLE [dbo].[ZFactMedicalServices] CHECK CONSTRAINT [FK_ZFactMedicalServices_V015]
GO

ALTER TABLE [dbo].[ZFactMedicalServices]  WITH CHECK ADD  CONSTRAINT [FK_ZFactMedicalServices_V021] FOREIGN KEY([SpecialityCodeV021])
REFERENCES [dbo].[V021] ([Id])
GO

ALTER TABLE [dbo].[ZFactMedicalServices] CHECK CONSTRAINT [FK_ZFactMedicalServices_V021]
GO