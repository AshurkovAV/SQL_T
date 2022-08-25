DECLARE @XML_TEXT NVARCHAR(max);
DECLARE @idoc INT;

SELECT @XML_TEXT = t.BulkColumn
FROM    (SELECT *    
    FROM OPENROWSET (BULK 'D:\Ðååñòð ÑÌÎ_091115.xml', SINGLE_CLOB) 
 AS xCol) AS t

SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version=''1.0'' encoding=''windows-1251''?>', '')

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
SELECT *
FROM OPENXML(@idoc, N'/packet/insCompany',2) 
WITH (
smocod NVARCHAR(5)  'smocod',
tf_okato NVARCHAR(5) 'tf_okato',
nam_smop NVARCHAR(254) 'nam_smop',
nam_smok NVARCHAR (250) 'nam_smok',
inn nvarchar(12) 'inn',
	Ogrn nvarchar(15) 'Ogrn',
	KPP nvarchar(9) 'KPP',
	index_j nvarchar(6) 'index_j',
	addr_j nvarchar(254) 'addr_j',
	index_f nvarchar(6) 'index_f',
	addr_f nvarchar(254) 'addr_f',
	okopf nvarchar(5) 'okopf',
	fam_ruk nvarchar(40) 'fam_ruk',
	im_ruk nvarchar(40) 'im_ruk',
	ot_ruk nvarchar(40) 'ot_ruk',
	phone nvarchar(40) 'phone',
	fax nvarchar(40) 'fax',
	e_mail nvarchar(40) 'e_mail',
	www nvarchar(100) 'www',
	org numeric(1, 0) 'org',
	d_begin datetime 'd_begin',
	d_end datetime 'd_end',
	name_e nvarchar(15) 'name_e',
	Nal_p nvarchar(1) 'Nal_p',
	DUVED datetime 'DUVED',
	kol_zl numeric(10, 0) 'kol_zl',
	d_edit datetime 'kol_zl',
	n_doc nvarchar(20) 'n_doc',
	d_start datetime 'd_start',
	data_e datetime 'data_e'
) 
ORDER BY smocod