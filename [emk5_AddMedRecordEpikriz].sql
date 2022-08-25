
CREATE PROCEDURE [dbo].[emk5_AddMedRecordEpikriz]
@IdCaseMis INT
AS
BEGIN
	--exec [[emk5_AddMedRecordNapr057]]
	

--AddMedRecord------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	SELECT TOP 100
	--/guid	 	1..1	GUID	Авторизационный токен --------------------------------------------------------------
		--выбрать нужно GUID 
	--/IdLpu	 	1..1	guid	Идентификатор МО
	(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
	--/IdPatientMis	 	1..1	String	Идентификатор пациента в передающей системе
	,PAT.KRN_GUID as IdPatientMis
	,pat.PATIENTS_ID
	--/IdCaseMis	 	1..1	String	Идентификатор случая в передающей МИС
	,MOT.MOTCONSU_ID AS IdCaseMis
		--/medRecord	 	1..1	 	Медицинская запись. Для значения xsi:type указывается соответствующий тип наследуемого объекта. Описание типов объекта приведено в разделе "Тип MedRecord"
					--/ConsultNote
						--CreationDate	1..1	dateTime	Дата создания документа
						,(cast(MOT.DATE_CONSULTATION as DATE)) as CreationDate
						--FhirMedDocumentType	0..0	string	Идентификатор типа документа (не используется при передаче данных)
						--IdDocumentMis	0..1	string	Идентификатор документа в системе-источнике (МИС)
						
						--IdMedDocument	0..0	int	Идентификатор документа в БД (не используется при передаче данных)
						--Attachment	0..1	DocumentAttachment	Неструктурированное (бинарное) содержание документа
							--DocumentAttachment
							--Data	0..1	base64Binary	Cтруктура SignData в формате base64binary
								--SignData Если передается неподписанный документ, то поля PublicKey, Hash и Sign не заполняются.
									--Data	1..1	Base64binary	Данные вложения (текст, pdf, html,xml) в формате base64binary
									,(SELECT sd.BODY FROM SIGN_DATA AS sd WHERE sd.MOTCONSU_ID = MOT.MOTCONSU_ID AND sd.SIGN_ROLE = 'ORG' AND sd.SIGN_TYPE = 'EPIKRIZ')as Base64binary
									--,MOT.MSE_BodyPreparedReport as Base64binary
									,(SELECT sd.SIGN_BODY FROM SIGN_DATA AS sd WHERE sd.MOTCONSU_ID = MOT.MOTCONSU_ID AND sd.SIGN_ROLE = 'ORG' AND sd.SIGN_TYPE = 'EPIKRIZ')as OrganizationSign
									--,MOT.MSE_ECP_SIGN_DATA_ORG as OrganizationSign
									,(SELECT sd.SIGN_BODY FROM SIGN_DATA AS sd WHERE sd.MOTCONSU_ID = MOT.MOTCONSU_ID AND sd.SIGN_ROLE = 'DOCTOR' AND sd.SIGN_TYPE = 'EPIKRIZ')as PersonalSigns
									--,MOT.MSE_ECP_SIGN_DATA as PersonalSigns
														--,(select cast(N'' as xml).value('xs:base64Binary(sql:column("plain_text"))', 'varchar(max)') as [encoded_value] 
														--	from (select cast(((CASE WHEN isnull(DOC.Description, '') = '' 
														--							THEN 'Медицинский документ ' + convert(varchar(19), MOT.DATE_CONSULTATION, 121) 
														--							ELSE 
														--							CAST(MOT.SEMD as varchar(max)) 
														--							END)) as varbinary(max)) as [plain_text]) as tmp) as Base64binary -- продумать, как собрать весь осмотр в текст
									--PublicKey	0..1	String	Публичный ключ сертификата ЭЦП
									--Hash	0..1	String	Хеш-сумма данных. Расчет хеш-суммы производится по алгоритму ГОСТ Р 34.10-2012 (ГОСТ Р 34.10-2001). Значение хеш-суммы должно соответствовать данным, передаваемым в элементе Data в формате base64binary
									--Sign	0..1	String	ЭЦП по ГОСТ Р 34.10-2012 (ГОСТ Р 34.10-2001)
								--SignData
							--Hash	0..1	base64Binary	Хэш данных (не используется для передачи в сервис)
							--MimeType	Условно-обязателен (Если параметр Data заполнен)	string --MIME-тип данных файла-вложения, передаваемых в атрибуте Data структуры SignData. Поддерживаемые MIME-типы: text/html – HTML; text/plain – текст; application/pdf – PDF; text/xml – XML.
							,'text/xml' AS MimeType
							--Url	0..1	anyURI	Адрес (ссылка), где находятся данные (содержимое вложения).
								,VD.PHYSICAL_PATH + '\' + LET.FOLDER + '\' + LET.FileName AS Url	-- нужно подумать и рассмотреть как вариант давать ссылку на документ... путь можно взять из MOTCONSU_XML
						--Author	1..1	MedicalStaff	Сведения о лице, создавшем документ
							--Person	0..1	PersonWithIdentity	Сведения о о личности медицинского работника
								--/Person/HumanName	 	1..1	 	ФИО врача
									--/HumanName	FamilyName	 	1..1	String	Фамилия врача
									,(select ltrim(rtrim(MED.NOM))) AS FamilyName
									--/HumanName	GivenName	 	1..1	String	Имя врача
									,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
									--/HumanName	MiddleName	 	0..1	String	Отчество врача
									,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --не обязательное - сделать выборку после пробела в MED.PRENOM
								--/Person	IdPersonMis	 	1..1	String	Идентификатор врача в МИС
								,MED.KRN_GUID as IdPersonMis -- предлагаю использовать GUID, можно и MEDECINS_ID
								--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – врача (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
									--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
									,223 as IdDocumentType -- тип документа - СНИЛС
									--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
									,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
									--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
									,'ПФР' as ProviderName -- организация, выдавшая документ
							--Person
							--IdLpu	0..1	string	Идентификатор МО
							,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
							--IdSpeciality	1..1	unsignedShort	Идентификатор специальности медицинского работника
							,118 IdSpeciality--,SPEC.Nsi_specialisation_ID as IdSpeciality
							--IdPosition	1..1	unsignedShort	Идентификатор должности медицинского работника
							--,SPEC.DOLZGNOST as IdPosition
						,182 as IdPosition
						--Header	1..1	string	Заголов ок документа (краткое описание)
						,(CASE WHEN isnull(DOC.Description, '') = '' THEN 'Эпикриз по законченному случаю амбулаторный ' + convert(varchar(19), MOT.DATE_CONSULTATION, 121) ELSE DOC.Description END) AS Header
						,epikriz.DATE_CONSULTATION [Date]						
						
						
					
FROM MOTCONSU MOT with (nolock)
LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
LEFT JOIN DATA_W438_EPIK_ZAK_AMB epikriz ON epikriz.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN PATIENTS PAT on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
LEFT JOIN LETTERS DOC ON DOC.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_GENERAL_EXAM DGE ON DGE.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN (SELECT * FROM LETTERS WHERE D_Type = 1) LET ON LET.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN VIRTUAL_DISKS VD ON VD.VIRTUAL_DISKS_ID = LET.VIRTUAL_DISKS_ID

WHERE epikriz.MOTCONSU_ID = @IdCaseMis
END





GO



GRANT EXECUTE ON [dbo].[emk5_AddMedRecordEpikriz] TO [iemk_user]

GRANT ALTER ON [dbo].[emk5_AddMedRecordEpikriz] TO [iemk_user]

GRANT CONTROL ON [dbo].[emk5_AddMedRecordEpikriz] TO [iemk_user]
