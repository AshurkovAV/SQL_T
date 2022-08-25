DECLARE @XML_TEXT NVARCHAR(max);
DECLARE @idoc INT;
DECLARE @F003_ TABLE (
	[tf_okato] [nvarchar](5) NULL,
	[mcod] [nvarchar](6) NOT NULL,
	[nam_mop] [nvarchar](250) NOT NULL,
	[nam_mok] [nvarchar](250) NOT NULL,
	[inn] [nvarchar](12) NOT NULL,
	[Ogrn] [nvarchar](15) NOT NULL,
	[KPP] [nvarchar](9) NOT NULL,
	[index_j] [nvarchar](6) NULL,
	[addr_j] [nvarchar](254) NOT NULL,
	[okopf] [nvarchar](5) NULL,
	[vedpri] [numeric](3, 0) NOT NULL,
	[org] [numeric](1, 0) NOT NULL,
	[fam_ruk] [nvarchar](40) NOT NULL,
	[im_ruk] [nvarchar](40) NOT NULL,
	[ot_ruk] [nvarchar](40) NOT NULL,
	[phone] [nvarchar](40) NULL,
	[fax] [nvarchar](40) NULL,
	[e_mail] [nvarchar](50)  NULL,
	[n_doc] [nvarchar](30)  NULL,
	[d_start] [datetime] NULL,
	[data_e] [datetime] NULL,
	[d_term] [nvarchar](255) NULL,
	[mp] [nvarchar](20) NULL,
	[picPage] [nvarchar](255) NULL,
	[picCopy] [nvarchar](255) NULL,
	[www] [nvarchar](100) NULL,
	[d_begin] [datetime] NULL,
	[d_end] [datetime] NULL,
	YEAR_WORK [nvarchar](40) NULL,
	[name_e] [nvarchar](10) NULL,
	[DUVED] [datetime] NULL,
	[d_edit] [datetime] NOT NULL)
	
SELECT @XML_TEXT = t.BulkColumn
FROM    (SELECT *    
    FROM OPENROWSET (BULK 'D:\Реесир МО_091115.xml', SINGLE_CLOB) 
 AS xCol) AS t
  
 SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version=''1.0'' encoding=''windows-1251''?>', '')
  SELECT @XML_TEXT
EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
BEGIN TRY
	INSERT INTO @F003_ ([tf_okato],[mcod],[nam_mop],[nam_mok]      ,[inn]      ,[Ogrn]   )--   ,[KPP]      ,[index_j]      ,[addr_j]      ,[okopf]      ,[vedpri]      ,[org]      ,[fam_ruk]      ,[im_ruk]      ,[ot_ruk]      ,[phone]      ,[fax]      ,[e_mail]      ,[n_doc]      ,[d_start]      ,[data_e]      ,[mp]      ,[www]      ,[d_begin]      ,[d_end]      ,[name_e]      ,[DUVED]      ,[d_edit])
	SELECT [tf_okato],[mcod],[nam_mop],[nam_mok]      ,[inn]      ,[Ogrn]
	FROM OPENXML (@idoc, '/packet/medCompany', 1)
		WITH ([tf_okato] [nvarchar](5),
			  [mcod] [varchar](6),
			  [nam_mop] [nvarchar](250),
			 [nam_mok] [nvarchar](250), 
			  [inn] [nvarchar](12),
			  [Ogrn] [nvarchar](15)
			  ) T
END TRY
BEGIN CATCH
	PRINT 'Ошибка загрузки XML файла.';
END CATCH
SELECT * FROM @F003_