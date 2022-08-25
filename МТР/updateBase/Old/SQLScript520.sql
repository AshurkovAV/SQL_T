CREATE TABLE [dbo].[ZFactAnticancerDrug](
	[ZAnticancerDrugId] [int] IDENTITY(1,1) NOT NULL,
	[ZMedicalServiceOnkId] [int] NOT NULL,
	[RegNum] [nvarchar](40) NULL,
	[DataInj] [datetime] NULL,
 CONSTRAINT [PK_ZFactAnticancerDrug] PRIMARY KEY CLUSTERED 
(
	[ZAnticancerDrugId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ZFactAnticancerDrug]  WITH CHECK ADD  CONSTRAINT [FK_ZFactAnticancerDrug_ZFactMedicalServicesOnk] FOREIGN KEY([ZMedicalServiceOnkId])
REFERENCES [dbo].[ZFactMedicalServicesOnk] ([ZmedicalServicesOnkId])
GO

ALTER TABLE [dbo].[ZFactAnticancerDrug] CHECK CONSTRAINT [FK_ZFactAnticancerDrug_ZFactMedicalServicesOnk]
GO