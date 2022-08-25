ALTER PROCEDURE [dbo].[emk3_GetAddMedRecordService]
@IdCaseMis INT
AS
BEGIN
	--exec [emk3_GetAddMedRecordService]
	
					/*Запрос на добавление медицинской записи к случаю обслуживания
			ДОБАВЛЕНИЕ УСЛУГИ
			для региональной шины N3.Здравоохранение
			от 10.10.2018
			Автор: Николенко Р.*/

--AddMedRecord------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	SELECT TOP 100
	--/guid	 	1..1	GUID	Авторизационный токен --------------------------------------------------------------
		--выбрать нужно GUID 
	--/IdLpu	 	1..1	guid	Идентификатор МО
	(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
	--/IdPatientMis	 	1..1	String	Идентификатор пациента в передающей системе
	,PAT.KRN_GUID as IdPatientMis
	--/IdCaseMis	 	1..1	String	Идентификатор случая в передающей МИС
	,MOT.MOTCONSU_ID AS IdCaseMis
		--/medRecord	 	1..1	 	Медицинская запись. Для значения xsi:type указывается соответствующий тип наследуемого объекта. Описание типов объекта приведено в разделе "Тип MedRecord"
					--/Service 1..1 Комплексный тип Service предназначен для передаче данных о выполненных (оказанных) услугах в рамках эпизода случая обслуживания.
						--DateEnd	1..1	dateTime	Дата окончания оказания услуги
						,cast(DMB.DATE_CONSULTATION as DATE) as DateEnd
						--DateStart	1..1	dateTime	Дата начала оказания услуги
						,cast(DMB.DATE_CONSULTATION as DATE) as DateStart
						--IdServiceType	1..1	string	Код услуги по региональной номенклатуре(Справочник OID: 1.2.643.2.69.1.1.1.88)
						,SERV.MINZDRAV_CODE as IdServiceType -- пока пишу наши коды, нужно продумать, как сопоставить на код минздрава наши "е..нутые" региональные кодификаторы
						--PaymentInfo	0..1	PaymentInfo	Информация об оплате услуги
							--HealthCareUnit	1..1	unsignedByte	Идентификатор единицы учета медицинской помощи (Справочник OID: 1.2.643.5.1.13.2.1.1.80)
							--IdPaymentType	1..1	unsignedByte	Идентификатор источника финансирования (Справочник OID: 1.2.643.5.1.13.2.1.1.104)
							--PaymentState	1..1	unsignedByte	Идентификатор статуса оплаты услуги (Справочник OID: 1.2.643.5.1.13.2.7.1.41)
							--Quantity	1..1	int	Количество выполненных (оказанных) услуг данного типа
							--Tariff	1..1	decimal	Сведения о тарифе (значение должно быть больше 0)
						--Performer	1..1	Participant	Сведения об исполнителе услуги
							--Doctor	0..1 (обязательно только для Service)	MedicalStaff	Данные медицинского работника
										--/Doctor	1..1	MedicalStaff	Сведения о медицинском работнике
											--Person	0..1	PersonWithIdentity	Сведения о о личности медицинского работника
												--/Person/HumanName	 	1..1	 	ФИО врача
													--/HumanName	FamilyName	 	1..1	String	Фамилия врача
													,(select ltrim(rtrim(MED.NOM))) AS FamilyName
													--/HumanName	GivenName	 	1..1	String	Имя врача
													,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
													--/HumanName	MiddleName	 	0..1	String	Отчество врача
													,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --не обязательное - сделать выборку после пробела в MED.PRENOM
												,med.DATA_ROGDENIQ  [BirthDate]
												--/Person	IdPersonMis	 	1..1	String	Идентификатор врача в МИС
												,MED.KRN_GUID as IdPersonMis -- предлагаю использовать GUID, можно и MEDECINS_ID
													--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – врача (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
														--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
														,223 as IdDocumentType -- тип документа - СНИЛС
														--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
														,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
														--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
														,'ПФР' as ProviderName -- организация, выдавшая документ
												--IdLpu	0..1	string	Идентификатор МО
												,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
												--IdSpeciality	1..1	unsignedShort	Идентификатор специальности медицинского работника
												,SPEC.Nsi_specialisation_ID as IdSpeciality
												--IdPosition	1..1	unsignedShort	Идентификатор должности медицинского работника
												,SPEC.DOLZGNOST as IdPosition
										--/Doctor
										--IdRole	0..1 (обязательно только для Service)	unsignedByte	Роль работника в оказании помощи (Справочник OID: 1.2.643.5.1.13.2.7.1.30) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/92/FilterTree
											,3 AS IdRole -- напишем, что визирует "врач"
						--ServiceName	1..1	string	Наименование услуги
					,SERV.LABEL ServiceName 
					
	
FROM MOTCONSU MOT with (nolock)
--LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
--LEFT JOIN ED_TREATMENT_FORM ETF ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID
--LEFT JOIN ED_LEVEL_ACCESS ELA ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD
LEFT JOIN PATIENTS PAT on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
INNER JOIN FM_BILL FB ON FB.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_MOTCONSU_BILLDET DMB on DMB.MOTCONSU_ID = FB.MOTCONSU_ID
LEFT JOIN FM_BILLDET FBT ON FBT.FM_BILL_ID = FB.FM_BILL_ID
LEFT JOIN FM_SERV SERV ON SERV.FM_SERV_ID = FBT.FM_SERV_ID
--LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOT.MOTCONSU_ID
--LEFT JOIN CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
--LEFT JOIN MOTCONSU_XML MOTXML on MOTXML.MOTCONSU_ID = MOT.MOTCONSU_ID 

	WHERE 
--MOT.PUBLISHED = 1 -- выбираем только опубликованные записи
--AND MOT.REC_STATUS = 'A' -- выбираем только подписанные врачом записи
--AND 
MOT.MOTCONSU_ID = @IdCaseMis
--and MOT.CHANGED <> 1 --добавляем только не изменявшиеся запси, так как остальные будут "обновляться" при ранее созданном кейсе
--and MOT.MOTCONSU_ID <> MOT.MOTCONSU_EV_ID -- выбираем записи, которые не открывают событие, а созданы в рамках законченного случая
--and MOT.ZAPIS_ZAKR_VAYHAQ_SOB_TIE <> 1 -- это не должна быть последняя запись, закрывающаяя событие, так как она будет передана в CloseCase

ORDER BY MOT.MOTCONSU_ID DESC -- для разборки скрипта, потом можно убрать

END


GO


