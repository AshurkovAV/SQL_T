CREATE TABLE [dbo].[ZFactContraindications](
	[ZContraindicationsId] [int] IDENTITY(1,1) NOT NULL,
	[ZMedicalEventOnkId] [int] NOT NULL,
	[Prot] [int] NULL,
	[Dprot] [datetime] NULL,
 CONSTRAINT [PK_ZFact—ontraindications] PRIMARY KEY CLUSTERED 
(
	[ZContraindicationsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ZFactContraindications]  WITH CHECK ADD  CONSTRAINT [FK_ZFactContraindications_N001] FOREIGN KEY([Prot])
REFERENCES [dbo].[N001] ([ID_PrOt])
GO

ALTER TABLE [dbo].[ZFactContraindications] CHECK CONSTRAINT [FK_ZFactContraindications_N001]
GO

ALTER TABLE [dbo].[ZFactContraindications]  WITH CHECK ADD  CONSTRAINT [FK_ZFactContraindications_ZFactMedicalEventOnk] FOREIGN KEY([ZMedicalEventOnkId])
REFERENCES [dbo].[ZFactMedicalEventOnk] ([ZMedicalEventOnkId])
GO

ALTER TABLE [dbo].[ZFactContraindications] CHECK CONSTRAINT [FK_ZFactContraindications_ZFactMedicalEventOnk]
GO


