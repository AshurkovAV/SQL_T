DECLARE @XML_TEXT NVARCHAR(max);
DECLARE @idoc INT;
DECLARE @F002 TABLE (
	[smocod] [nvarchar](5) NOT NULL,
	[tf_okato] [nvarchar](5) NOT NULL,
	[nam_smop] [nvarchar](254) NOT NULL,
	[nam_smok] [nvarchar](250) NOT NULL,
	[inn] [nvarchar](12) NULL,
	[Ogrn] [nvarchar](15) NULL,
	[KPP] [nvarchar](9) NULL,
	[index_j] [nvarchar](6) NULL,
	[addr_j] [nvarchar](254) NULL,
	[index_f] [nvarchar](6) NULL,
	[addr_f] [nvarchar](254) NULL,
	[okopf] [nvarchar](5) NULL,
	[fam_ruk] [nvarchar](40) NULL,
	[im_ruk] [nvarchar](40) NULL,
	[ot_ruk] [nvarchar](40) NULL,
	[phone] [nvarchar](40) NULL,
	[fax] [nvarchar](40) NULL,
	[e_mail] [nvarchar](40) NULL,
	[www] [nvarchar](100) NULL,
	[org] [numeric](1, 0) NULL,
	[d_begin] [datetime] NULL,
	[d_end] [datetime] NULL,
	[name_e] [nvarchar](15) NULL,
	[Nal_p] [nvarchar](1) NULL,
	[DUVED] [datetime] NULL,
	[kol_zl] [numeric](10, 0) NULL,
	[d_edit] [datetime] NULL,
	[n_doc] [nvarchar](20) NULL,
	[d_start] [datetime] NULL,
	[data_e] [datetime] NULL)	
	
SELECT @XML_TEXT = t.BulkColumn
FROM    (SELECT *    
    FROM OPENROWSET (BULK 'PACH_XML_FILE', SINGLE_CLOB) 
 AS xCol) AS t

SET @XML_TEXT = REPLACE(@XML_TEXT, '<?xml version=''1.0'' encoding=''windows-1251''?>', '')

EXEC sp_xml_preparedocument @idoc OUTPUT, @XML_TEXT;
BEGIN TRY
INSERT INTO @F002 ([smocod],[tf_okato],[nam_smop],[nam_smok],[inn],[Ogrn],[KPP],[index_j],[addr_j],[index_f],[addr_f],[okopf],[fam_ruk],[im_ruk],[ot_ruk],[phone],[fax],[e_mail],[www],[org],[d_begin],[d_end],[name_e],[Nal_p],[DUVED],[kol_zl],[d_edit],[n_doc],[d_start],[data_e])
SELECT [smocod],[tf_okato],[nam_smop],[nam_smok],[inn],[Ogrn],[KPP],[index_j],[addr_j],[index_f],[addr_f],[okopf],[fam_ruk],[im_ruk],[ot_ruk],[phone],[fax],[e_mail],[www],[org],[d_begin],[d_end],[name_e],[Nal_p],[DUVED],[kol_zl],[d_edit],[n_doc],[d_start],[data_e]
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
) T
END TRY
BEGIN CATCH
	PRINT 'Ошибка загрузки XML файла.';
END CATCH

update F002 set  
       F002.[tf_okato] = t1.[tf_okato]
      ,F002.[nam_smop] = t1.[nam_smop]
      ,F002.[nam_smok] = t1.[nam_smok]
      ,F002.[inn] = t1.[inn]
      ,F002.[Ogrn] = t1.[Ogrn]
      ,F002.[KPP] = t1.[KPP]
      ,F002.[index_j] = t1.[index_j]
      ,F002.[addr_j] = t1.[addr_j]
      ,F002.[index_f] = t1.[index_f]
      ,F002.[addr_f] = t1.[addr_f]
      ,F002.[okopf] = t1.[okopf]
      ,F002.[fam_ruk] = t1.[fam_ruk]
      ,F002.[im_ruk] = t1.[im_ruk]
      ,F002.[ot_ruk] = t1.[ot_ruk]
      ,F002.[phone] = t1.[phone]
      ,F002.[fax] = t1.[fax]
      ,F002.[e_mail] = t1.[e_mail]
      ,F002.[www] = t1.[www]
      ,F002.[org] = t1.[org]
      ,F002.[d_begin] = t1.[d_begin]
      ,F002.[d_end] = t1.[d_end]
      ,F002.[name_e] = t1.[name_e]
      ,F002.[Nal_p] = t1.[Nal_p]
      ,F002.[DUVED] = t1.[DUVED]
      ,F002.[kol_zl] = t1.[kol_zl]
      ,F002.[d_edit] = t1.[d_edit]
      ,F002.[n_doc] = t1.[n_doc]
      ,F002.[d_start] = t1.[d_start]
      ,F002.[data_e] = t1.[data_e]
FROM F002 AS t
JOIN @F002 AS t1 ON t.[smocod] = t1.[smocod]

INSERT INTO F002
            ([smocod],[tf_okato],[nam_smop],[nam_smok],[inn],[Ogrn],[KPP],[index_j],[addr_j],[index_f],[addr_f],[okopf],[fam_ruk],[im_ruk],[ot_ruk],[phone],[fax],[e_mail],[www],[org],[d_begin],[d_end],[name_e],[Nal_p],[DUVED],[kol_zl],[d_edit],[n_doc],[d_start],[data_e])
SELECT  [smocod],[tf_okato],[nam_smop],[nam_smok],[inn],[Ogrn],[KPP],[index_j],[addr_j],[index_f],[addr_f],[okopf],[fam_ruk],[im_ruk],[ot_ruk],[phone],[fax],[e_mail],[www],[org],[d_begin],[d_end],[name_e],[Nal_p],[DUVED],[kol_zl],[d_edit],[n_doc],[d_start],[data_e]
FROM @F002
WHERE [smocod] NOT IN (
        SELECT t1.[smocod]  
        FROM F002 AS t
        JOIN @F002 AS t1 ON t.[smocod] = t1.[smocod])   