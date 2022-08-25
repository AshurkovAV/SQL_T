DECLARE @XML_TEXT NVARCHAR(max);
DECLARE @idoc INT;
DECLARE @F011 TABLE (	
	[IDDoc] [numeric](2, 0) NOT NULL,
	[DocName] [nvarchar](254) NOT NULL,
	[DocSer] [nvarchar](10) NULL,
	[DocNum] [nvarchar](20) NULL,
	[DATEBEG] [datetime] NOT NULL,
	[DATEEND] [datetime] NULL)		
	
--	SELECT @XML_TEXT = t.BulkColumn
--FROM    (SELECT *    
--    FROM OPENROWSET (BULK '\\sqlserver\vip\F011(УДЛ).xml', SINGLE_CLOB) 
-- AS xCol) AS t
--SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version="1.0" encoding="windows-1251"?>', '')

SELECT @XML_TEXT = [XMLCODE] FROM [SprUpdate] WHERE NAME_SPR = 'F011'

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
BEGIN TRY
INSERT INTO @F011 (IDDoc,DocName, DocSer, DocNum, DATEBEG, DATEEND)
	        SELECT IDDoc,DocName, DocSer, DocNum, DATEBEG, DATEEND
	FROM OPENXML (@idoc, N'/PACKET/ZAP', 1)
		WITH ([IDDoc] [numeric](2, 0) ,
	[DocName] [nvarchar](254) ,
	[DocSer] [nvarchar](10),
	[DocNum] [nvarchar](20),
	[DATEBEG] date,
	[DATEEND] date
			  ) 
END TRY
BEGIN CATCH
	PRINT 'Ошибка загрузки XML файла.';
END CATCH

UPDATE @F011 SET DATEEND = NULL WHERE DATEEND = '19000101' 

UPDATE F011 
SET F011.IDDOC = t1.IDDOC
      ,F011.DOCNAME = t1.DOCNAME
      ,F011.DOCSER = t1.DOCSER
      ,F011.DOCNUM = t1.DOCNUM
      ,F011.DATEBEG = t1.DATEBEG
      ,F011.DATEEND = t1.DATEEND
FROM F011 as t
JOIN @F011 as t1 on t.IDDOC = t1.IDDOC

INSERT INTO F011
       ([Id]
      ,[IDDoc]
      ,[DocName]
      ,[DocSer]
      ,[DocNum]
      ,[DATEBEG]
      ,[DATEEND])
SELECT [IDDoc]
      ,[IDDoc]
      ,[DocName]
      ,[DocSer]
      ,[DocNum]
      ,[DATEBEG]
      ,[DATEEND]
FROM @F011
WHERE [IDDoc] not in (
        SELECT t1.[IDDoc]  
        FROM F011 AS t
JOIN @F011 AS t1 ON t.[IDDoc] = t1.[IDDoc])