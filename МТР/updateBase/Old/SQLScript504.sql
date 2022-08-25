CREATE TABLE [dbo].[ZFactDiagBlok](
	[ZDiagBlokId] [int] IDENTITY(1,1) NOT NULL,
	[ZMedicalEventOnkId] [int] NOT NULL,
	[DiagTip] [int] NULL,
	[DiagCode7] [int] NULL,
	[DiagCode10] [int] NULL,
	[DiagRslt8] [int] NULL,
	[DiagRslt11] [int] NULL,
 CONSTRAINT [PK_ZFactDiagBlok] PRIMARY KEY CLUSTERED 
(
	[ZDiagBlokId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ZFactDiagBlok]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDiagBlok_N007] FOREIGN KEY([DiagCode7])
REFERENCES [dbo].[N007] ([ID_Mrf])
GO

ALTER TABLE [dbo].[ZFactDiagBlok] CHECK CONSTRAINT [FK_ZFactDiagBlok_N007]
GO

ALTER TABLE [dbo].[ZFactDiagBlok]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDiagBlok_N008] FOREIGN KEY([DiagRslt8])
REFERENCES [dbo].[N008] ([ID_R_M])
GO

ALTER TABLE [dbo].[ZFactDiagBlok] CHECK CONSTRAINT [FK_ZFactDiagBlok_N008]
GO

ALTER TABLE [dbo].[ZFactDiagBlok]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDiagBlok_N010] FOREIGN KEY([DiagCode10])
REFERENCES [dbo].[N010] ([ID_Igh])
GO

ALTER TABLE [dbo].[ZFactDiagBlok] CHECK CONSTRAINT [FK_ZFactDiagBlok_N010]
GO

ALTER TABLE [dbo].[ZFactDiagBlok]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDiagBlok_N011] FOREIGN KEY([DiagRslt11])
REFERENCES [dbo].[N011] ([ID_R_I])
GO

ALTER TABLE [dbo].[ZFactDiagBlok] CHECK CONSTRAINT [FK_ZFactDiagBlok_N011]
GO

ALTER TABLE [dbo].[ZFactDiagBlok]  WITH CHECK ADD  CONSTRAINT [FK_ZFactDiagBlok_ZFactMedicalEventOnk] FOREIGN KEY([ZMedicalEventOnkId])
REFERENCES [dbo].[ZFactMedicalEventOnk] ([ZMedicalEventOnkId])
GO

ALTER TABLE [dbo].[ZFactDiagBlok] CHECK CONSTRAINT [FK_ZFactDiagBlok_ZFactMedicalEventOnk]
GO


