CREATE TABLE [dbo].[F003_2](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[tf_okato] [nvarchar](5) NULL,
	[mcod] [nvarchar](6) NULL,
	[nam_mop] [nvarchar](250) NULL,
	[nam_mok] [nvarchar](250) NULL,
	[inn] [nvarchar](12) NULL,
	[Ogrn] [nvarchar](15) NULL,
	[KPP] [nvarchar](9) NULL,
	[index_j] [nvarchar](6) NULL,
	[addr_j] [nvarchar](254) NULL,
	[okopf] [nvarchar](6) NULL,
	[vedpri] [numeric](3, 0) NULL,
	[org] [numeric](1, 0) NULL,
	[fam_ruk] [nvarchar](40) NOT NULL,
	[im_ruk] [nvarchar](40) NOT NULL,
	[ot_ruk] [nvarchar](40) NOT NULL,
	[phone] [nvarchar](40) NOT NULL,
	[fax] [nvarchar](40) NOT NULL,
	[e_mail] [nvarchar](50) NOT NULL,
	[n_doc] [nvarchar](30) NULL,
	[d_start] [datetime] NULL,
	[data_e] [datetime] NULL,
	[mp] [nvarchar](30) NULL,
	[www] [nvarchar](100) NULL,
	[d_begin] [datetime] NULL,
	[d_end] [datetime] NULL,
	[name_e] [nvarchar](10) NULL,
	[DUVED] [datetime] NULL,
	[d_edit] [datetime] NOT NULL,
 CONSTRAINT [PK_F003_2] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'F003 Единый реестр медицинских организаций, осуществляющих деятельность в сфере обязательного медицинского страхования (MO) medical_organization ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'F003_2'
GO

SET IDENTITY_INSERT [dbo].[F003_2] ON 
INSERT INTO [medicine_ins].[dbo].[F003_2]( [Id]
      ,[tf_okato]
      ,[mcod]
      ,[nam_mop]
      ,[nam_mok]
      ,[inn]
      ,[Ogrn]
      ,[KPP]
      ,[index_j]
      ,[addr_j]
      ,[okopf]
      ,[vedpri]
      ,[org]
      ,[fam_ruk]
      ,[im_ruk]
      ,[ot_ruk]
      ,[phone]
      ,[fax]
      ,[e_mail]
      ,[n_doc]
      ,[d_start]
      ,[data_e]
      ,[mp]
      ,[www]
      ,[d_begin]
      ,[d_end]
      ,[name_e]
      ,[DUVED]
      ,[d_edit])
  
  SELECT [Id]
      ,[tf_okato]
      ,[mcod]
      ,[nam_mop]
      ,[nam_mok]
      ,[inn]
      ,[Ogrn]
      ,[KPP]
      ,[index_j]
      ,[addr_j]
      ,[okopf]
      ,[vedpri]
      ,[org]
      ,[fam_ruk]
      ,[im_ruk]
      ,[ot_ruk]
      ,[phone]
      ,[fax]
      ,[e_mail]
      ,[n_doc]
      ,[d_start]
      ,[data_e]
      ,[mp]
      ,[www]
      ,[d_begin]
      ,[d_end]
      ,[name_e]
      ,[DUVED]
      ,[d_edit]
  FROM f003
  
  SET IDENTITY_INSERT [dbo].[F003_2] OFF