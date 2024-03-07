--временная таблица tmp_D3_USL_OMS_koagul
USE [ElmedKokod2]
GO

/****** Object:  Table [dbo].[D3_USL_OMS]    Script Date: 21.09.2022 14:09:15 ******/
/*SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
*/
CREATE TABLE [dbo].[tmp_D3_USL_OMS_koagul](
	[nam_mok] [nvarchar](250) NULL, 
	[npolis] [nvarchar](20) NULL, 
	[schid_old] [int] NOT NULL,
	[fam] [nvarchar](40) NULL,
	[im] [nvarchar](40) NULL,
	[ot] [nvarchar](40) NULL,
	[dr] [datetime] NULL,
	[D3_PID] [int] NOT NULL,
	[sch_id] [int] NOT NULL, 
	[ISHOD] [int] NULL,
	
	[D3_SLID] [int] NOT NULL,
	[D3_ZSLID] [int] NOT NULL,
	[D3_SLGID] [nvarchar](36) NULL,
	[IDSERV] [nvarchar](36) NULL,
	[LPU] [nvarchar](6) NULL,
	[PROFIL] [int] NULL,
	[VID_VME] [nvarchar](16) NULL,
	[DET] [int] NULL,
	[DATE_IN] [datetime] NULL,
	[DATE_OUT] [datetime] NULL,
	[DS] [nvarchar](10) NULL,
	[CODE_USL] [nvarchar](20) NULL,
	[KOL_USL] [numeric](8, 2) NULL,
	[SUMV_USL] [numeric](17, 2) NULL,
	[PRVS] [int] NULL,
	[CODE_MD] [nvarchar](25) NULL,
	[VERS_SPEC] [nvarchar](4) NULL,
	[PRVS_VERS] [nvarchar](9) NULL /*AS ((isnull([VERS_SPEC],'V015')+'_')+CONVERT([nvarchar](4),[PRVS],0))*/
)
/*PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[D3_USL_OMS] ADD  CONSTRAINT [DF_D3_USL_OMS_VERS_SPEC]  DEFAULT (N'V021') FOR [VERS_SPEC]
GO

ALTER TABLE [dbo].[D3_USL_OMS]  WITH CHECK ADD  CONSTRAINT [FK_D3_USL_D3_SL] FOREIGN KEY([D3_SLID])
REFERENCES [dbo].[D3_SL_OMS] ([ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[D3_USL_OMS] CHECK CONSTRAINT [FK_D3_USL_D3_SL]
GO

*/
