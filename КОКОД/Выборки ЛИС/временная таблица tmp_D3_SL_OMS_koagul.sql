--временная таблица tmp_D3_SL_OMS_koagul
USE [ElmedKokod2]
GO

/****** Object:  Table [dbo].[D3_SL_OMS]    Script Date: 26.09.2022 10:45:05 ******/
/*SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
*/
CREATE TABLE [dbo].tmp_D3_SL_OMS_koagul(
	--[ID] [int] IDENTITY(1,1) NOT NULL,
	[D3_ZSLID] [int] NOT NULL,
	[D3_ZSLGID] [nvarchar](36) NULL,
	[SL_ID] [nvarchar](36) NULL,
	[LPU_1] [nvarchar](8) NULL,
	[PROFIL] [int] NULL,
	[DET] [int] NULL,
	[P_CEL] [nvarchar](3) NULL,
	[NHISTORY] [nvarchar](50) NULL,
	[DATE_1] [datetime] NULL,
	[DATE_2] [datetime] NULL,
	[DS1] [nvarchar](10) NULL,
	[PRVS] [int] NULL,
	[VERS_SPEC] [nvarchar](4) NULL,
	[IDDOKT] [nvarchar](25) NULL,
	[ED_COL] [numeric](7, 2) NULL,
	[TARIF] [numeric](17, 2) NULL,
	[SUM_M] [numeric](17, 2) NULL,
	[PRVS21] [int] NULL,
	[P_CEL25] [nvarchar](3) NULL,
	--[PRVS_VERS]  AS ((isnull([VERS_SPEC],'V015')+'_')+CONVERT([nvarchar](4),[PRVS],0)),
	)
/*PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[D3_SL_OMS] ADD  CONSTRAINT [DF_D3_SL_OMS_VERS_SPEC]  DEFAULT (N'V021') FOR [VERS_SPEC]
GO

ALTER TABLE [dbo].[D3_SL_OMS]  WITH CHECK ADD  CONSTRAINT [FK_D3_SL_D3_ZSL] FOREIGN KEY([D3_ZSLID])
REFERENCES [dbo].[D3_ZSL_OMS] ([ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[D3_SL_OMS] CHECK CONSTRAINT [FK_D3_SL_D3_ZSL]
GO

*/
