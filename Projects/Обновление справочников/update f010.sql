DECLARE @XML_TEXT NVARCHAR(max);
DECLARE @idoc INT;

SELECT @XML_TEXT = t.BulkColumn
FROM    (SELECT *    
    FROM OPENROWSET (BULK 'D:\Ðååñòð ÑÌÎ_091115.xml', SINGLE_CLOB) 
 AS xCol) AS t

SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version=''1.0'' encoding=''windows-1251''?>', '')

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
SELECT *
FROM OPENXML(@idoc, N'/packet/insCompany', 2) 
WITH (
[smocod] [nvarchar](5)  '../insCompany/smocod',
tf_okato NVARCHAR(5) '../insCompany/tf_okato',
[nam_smop] [nvarchar](254) '../insCompany/nam_smop',
[nam_smok] [nvarchar] (250) '../insCompany/nam_smok'

) 