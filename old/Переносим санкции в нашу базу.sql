DECLARE @XML_TEXT XML;
DECLARE @idoc INT;
DECLARE @Eror TABLE (
	[S_SUM] [numeric](15, 2) NULL,
	[S_TIP] [int] NULL,
	[S_OSN] [nvarchar](20) NULL,
	[S_COM] [nvarchar](250) NULL,
	[S_IST] [int] NULL,
	[SLID_TEMP] [nvarchar](36) NULL,
	[SCHET_ID] [int] NULL,
	[SLID] [int] NULL,
	[ID] [int] NOT NULL,
	[S_DATE] [datetime] NULL,
	[SCHET_SMO_ID] [int] NULL,
	[RESANK] [int] NULL,
	[S_CODE] [uniqueidentifier] NOT NULL,
	[SANK_IMPORT_ID] [int] NULL)		

	SELECT @XML_TEXT = t.BulkColumn
FROM    (SELECT *    
    FROM OPENROWSET (BULK 'D:\test.xml', SINGLE_CLOB) 
 AS xCol) AS t

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
--INSERT INTO @Eror(	ID,	SMO,	COMENTS,	COMENTS2)
SELECT *
INTO tempSank
FROM OPENXML(@idoc, N'/ZL_LIST/EXP',2) 
WITH (
	CODE_MO NVARCHAR(6),
	[YEAR] INT ,
	[MONTH]  INT,
	NSCHET NVARCHAR(10),
	DSCHET DATETIME,
	NPOLIS NVARCHAR(16),
	USL_OK INT,
	PROFIL INT,
	DS1 NVARCHAR(6),
	DATE_1 DATETIME,
	DATE_2 DATETIME,
	IDSLG [uniqueidentifier],
	S_CODE [uniqueidentifier],
	[S_SUM] [numeric](15, 2),
	[S_TIP] [int] ,
	[S_OSN] [nvarchar](20),
	[S_COM] [nvarchar](250),
	S_DATE DATETIME,
	S_IST INT
) T
WHERE S_TIP = 1

