CREATE TABLE [dbo].[ZFactConsultations](
	[ZConsultationsId] [int] IDENTITY(1,1) NOT NULL,
	[ZMedicalEventId] [int] NOT NULL,
	[PrCons] [int] NULL,
	[DtCons] [datetime] NULL,
 CONSTRAINT [PK_ZFactConsultations] PRIMARY KEY CLUSTERED 
(
	[ZConsultationsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ZFactConsultations]  WITH NOCHECK ADD  CONSTRAINT [FK_ZFactConsultations_ZFactMedicalEvent] FOREIGN KEY([ZMedicalEventId])
REFERENCES [dbo].[ZFactMedicalEvent] ([ZMedicalEventId])
GO

ALTER TABLE [dbo].[ZFactConsultations] CHECK CONSTRAINT [FK_ZFactConsultations_ZFactMedicalEvent]
GO