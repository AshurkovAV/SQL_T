DECLARE @XML_TEXT XML;
DECLARE @idoc INT;

SELECT @XML_TEXT = t.BulkColumn
FROM    (SELECT *    
    FROM OPENROWSET (BULK 'D:\ot.xml', SINGLE_CLOB) 
 AS xCol) AS t
--SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version="1.0" encoding="windows-1251"?>', '')

--SELECT @XML_TEXT = [XMLCODE] FROM [SprUpdate] WHERE NAME_SPR = 'F011'

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;

INSERT INTO PacientVisit (fam, im, ot, dr, W, DOCSER, DOCNUM, Polis, Errors, ReestrMedOrgID )
SELECT lastName, firstName, secondName,
convert(datetime, 
substring(birthday, 0, 5) + substring(birthday, 6, 2) + substring(birthday, 9, 2)), CASE WHEN sex = 'male' THEN 1 ELSE 2 END,
substring(passport, 0, 5), substring(passport, 6, 7), insurance, diagnosis, 38 
	FROM OPENXML (@idoc, N'/INSURANCE_REPORT/patients/patient', 1)
		WITH (			
	--hospital [nvarchar](254) 'hospital',
	--code INT 'code',
	lastName NVARCHAR(250) 'lastName',
	firstName NVARCHAR(40) 'firstName',
	secondName NVARCHAR(40) 'secondName',
	sex NVARCHAR(10) 'sex',
	birthday NVARCHAR(10) 'birthday',
	passport NVARCHAR(50) 'passport',
	insurance NVARCHAR(40) 'insurance',
	snils NVARCHAR(16) 'snils',
	testsCount NVARCHAR(50) 'testsCount',
	appointmentsCount NVARCHAR (100) 'appointmentsCount',
	diagnosis NVARCHAR(500) 'diagnosis',
	comorbidities NVARCHAR(200) 'comorbidities'	
			  ) 


