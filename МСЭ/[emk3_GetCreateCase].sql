
ALTER PROCEDURE [dbo].[emk3_GetCreateCase]
AS
BEGIN
	--exec [emk3_GetCreateCase]
	
					/*Запрос на выбор законченного случая амбулаторного обслуживания
			для региональной шины N3.Здравоохранение
			от 10.10.2018
			Автор: Николенко Р.*/

--Скрипт требует добавления столбца DOLZGNOST в таблицу SPECIALISATION
-- смотри файл SPECIALISATION_UPDATE.sql


--CreateCase------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	--/	guid	 	1..1	GUID	Авторизационный токен --------------------------------------------------------------
		--выбрать нужно GUID 
	--/CaseDto	 	1..1	 	Информация о случае медицинского обслуживания. Для значения xsi:type указывается CaseAmb
		--/CaseDto	 	1..1	 	Информация о случае медицинского обслуживания. Для значения xsi:type указывается CaseAmb
			SELECT TOP 1000
			--/CaseDto	OpenDate	 	1..1	Datetime	Дата открытия случая
			(cast (MOT.DATE_CONSULTATION as Date)) AS OpenDate 
			--/CasеDto	CloseDate	 	1..1	Datetime	Дата закрытия случая
			-- не передаем, так как ее пока нет, случай только открыт
			--/CaseDto	HistoryNumber	 	1..1	String	Номер истории болезни/ Амбулаторного талона
			,MOT.MOTCONSU_EV_ID AS HistoryNumber
			--/CaseDto	IdCaseMis	 	1..1	String	Идентификатор случая в передающей МИС
			,MOT.MOTCONSU_ID AS IdCaseMis --передаем ID для начала случая обращения
			--/CaseDto	IdCaseAidType	 	0..1	unsignedByte	Идентификатор вида медицинского обслуживания (OID справочника: 1.2.643.2.69.1.1.1.16) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/7/FilterTree
			,ETF.ED_TREATMENT_FORM_CODE AS IdCaseAidType
			--/CaseDto	IdPaymentType	 	1..1	unsignedByte	Идентификатор источника финансирования (OID справочника: 1.2.643.2.69.1.1.1.32) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/25/FilterTree
			,'1' AS IdPaymentType -- сейчас ставлю ОМС. В дальнейшем разобраться со справочником и способом определения источника финансирования
			--/CaseDto	Confidentiality	 	1..1	unsignedByte	Уровень конфиденциальности передаваемой информации (OID справочника: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 'N'
				ELSE ELA.CODE END) AS Confidentiality -- Ставится на вкладке СЭМД таблица ED_LEVEL_ACCESS нет понимания о методе опредедления конфиденциальности	
			--/CaseDto	DoctorConfidentiality	 	1..1	unsignedByte	Уровень конфиденциальности передаваемой информации для врача (OID справочника: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 'N'
				ELSE ELA.CODE END) AS DoctorConfidentiality -- ставлю пока такой же код таблица ED_LEVEL_ACCESS нет понимания о методе опредедления конфиденциальности
			--/CaseDto	CuratorConfidentiality	 	1..1	unsignedByte	Уровень конфиденциальности передаваемой информации для представителя пациента/опекуна (OID справочника: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 'N'
				ELSE ELA.CODE END) AS CuratorConfidentiality -- ставлю пока такой же код таблица ED_LEVEL_ACCESS нет понимания о методе опредедления конфиденциальности		
			--/CaseDto	IdLpu	 	1..1	guid	Идентификатор МО
			,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu -- создать поле в таблице FM_ORG для хранения GUID MO (выданный Нетрикой) либо кроссировку делать на OID Росминздрава, со слов Дмитрия Пархимовича можно использовать OID Минздрава
			--/CaseDto	IdCaseResult	 	1..1	unsignedByte	Идентификатор исхода заболевания (OID справочника: 1.2.643.5.1.13.2.1.1.688) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/88/FilterTree Справочник не соответствует ТФОМСу. Проверить сопоставление после обновления
			,DAPC.ED_OUTCOMES_ID as IdCaseResult
			--/CaseDto	Comment	 	1..1	String	Текст заключения из эпикриза и/или другую важную медицинскую информацию в неструктурированном виде, например, текст медицинского протокола
				--не подходит, так как СЭМД формируется после закрытия случая,(convert (VARCHAR(8000), MOT.SEMD)) as Comment	-- Вкладка СЭМД открывается после установки признака случай закрыт
				--готовой сборки по полям нет. нужно продумать механизм "сборки" текста из заполненных таблиц MOTXML.FILLED_TABLES или делать импорт информации из сформированного rtf файла осмотра
			,MOT.EV_NAME AS Comment --напишем диагноз по случаю как комментарий к случаю
			--/CaseDto	IdPatientMis	 	1..1	String	Идентификатор пациента в передающей системе
			,PAT.KRN_GUID AS IdPatientMis
			--/CaseDto	IdCasePurpose	 	0..1	unsignedByte	Идентификатор цели обращения (Классификатор поводов обращения за медицинской помощью, OID справочника: 1.2.643.5.1.13.2.1.1.106)
			,(CASE WHEN DAPC.VID_PRIEMA = 1 OR DAPC.VID_PRIEMA = 20 THEN 1
					WHEN DAPC.VID_PRIEMA = 13 THEN 2
					WHEN DAPC.VID_PRIEMA = 11 THEN 3
					WHEN DAPC.VID_PRIEMA = 16 THEN 4 
					WHEN DAPC.VID_PRIEMA = 2 THEN 5 
					ELSE 12 END) as IdCasePurpose -- значения из таблицы ED_RECEPTION_TYPE посмотреть, что еще нужно сопоставить
			--/CaseDto	IdCaseType	 	1..1	unsignedByte	Идентификатор типа случая обслуживания: амбулаторный, диспансеризация (OID справочника: 1.2.643.2.69.1.1.1.35)
			,(CASE WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 3 OR DAPC.ED_MED_PROVISION_CONDITIONS_ID = 4 THEN 2
					WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 1 THEN 3 END) as IdCaseType -- таблица ED_MEDPROVISION_CONDITIONS
			--/CaseDto	IdAmbResult	 	0..1	unsignedByte	Код результата обращения (OID справочника: 1.2.643.2.69.1.1.1.17)
			,(CASE WHEN DAPC.ED_OUTCOMES_ID = 16 THEN 1
					WHEN DAPC.ED_OUTCOMES_ID = 3 THEN 2
					WHEN DAPC.ED_OUTCOMES_ID = 18 OR DAPC.ED_OUTCOMES_ID = 2 OR DAPC.ED_OUTCOMES_ID = 4 OR DAPC.ED_OUTCOMES_ID = 5 THEN 3
					ELSE 17 END) as IdAmbResult -- таблица ED_OUTCOMES
			--/CaseDto	IsActive	 	0..1	Boolean	Признак «Актив». Признак устанавливается, если пациент был направлен на приём к врачу
			,'1' as IsActive -- пока считаем, что все пациенты направлены к врачу, позже логику продумаем
			--/CaseDto/DoctorInCharge	 	1..1	 	Информация о лечащем враче -------------------------------------
				--/DoctorInCharge	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится врач
				,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu -- создать поле в таблице FM_ORG для хранения GUID MO (выданный Нетрикой) либо кроссировку делать на OID Росминздрава, со слов Дмитрия Пархимовича можно использовать OID Минздрава
				--/DoctorInCharge	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности врача (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
				,SPEC.Nsi_specialisation_ID as IdSpeciality
				--/DoctorInCharge	IdPosition	 	1..1	unsignedShort	Идентификатор должности врача (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
				,SPEC.DOLZGNOST as IdPosition -- Добавить в таблицу SPECIALISATION новый столбец DOLZGNOST int, провести сопоставление со справочником 1.2.643.5.1.13.2.1.1.607 -- сделать скрипт на обновление значений в таблицах у МО

				--/DoctorInCharge/Person	 	1..1	 	Информация о персоне (враче)
					--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
					--не обязательное, потом подумаем про секс врачей
					--/Person	BirthDate	 	0..1	Datetime	Дата рождения
					--не обязательное, потом подумаем
					--/Person	IdPersonMis	 	1..1	String	Идентификатор врача в МИС
					,MED.KRN_GUID as IdPersonMis -- предлагаю использовать GUID, можно и MEDECINS_ID
						--/Person/HumanName	 	1..1	 	ФИО врача
							--/HumanName	FamilyName	 	1..1	String	Фамилия врача
							,(select ltrim(rtrim(MED.NOM))) AS FamilyName
							--/HumanName	GivenName	 	1..1	String	Имя врача
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
							--/HumanName	MiddleName	 	0..1	String	Отчество врача
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --не обязательное - сделать выборку после пробела в MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – врача (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
							,'223' as IdDocumentType -- тип документа - СНИЛС
							--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
							,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
							--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
							,'ПФР' as ProviderName -- организация, выдавшая документ
			--/CaseDto/Authenticator	 	1..1	 	Лицо, подписывающее или визирующее формируемый набор медицинской информации
				--/Authenticator	IdRole	 	0..1	unsignedByte	Роль в оказании помощи (OID справочника: 1.2.643.5.1.13.2.7.1.30) не обязательное http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/92/FilterTree
					,'3' AS IdRole -- напишем, что визирует "врач"
					--/Authenticator/Doctor	 	1..1	 	Информация о медицинском работнике
						--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится медицинский работник
						,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
						--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности медицинского работника (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
						,SPEC.Nsi_specialisation_ID as IdSpeciality
						--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности медицинского работника (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
						,SPEC.DOLZGNOST as IdPosition
							--/Doctor/Person	 	1..1	 	Информация о персоне --не обязательное
								--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156) --не обязательное
								--/Person	BirthDate	 	0..1	Datetime	Дата рождения --не обязательное
								--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
								,MED.KRN_GUID as IdPersonMis -- предлагаю использовать GUID, можно и MEDECINS_ID
								--/Person/HumanName	 	1..1	 	ФИО медицинского работника
									--/HumanName	FamilyName	 	1..1	String	Фамилия медицинского работника
									,(select ltrim(rtrim(MED.NOM))) AS FamilyName
									--/HumanName	GivenName	 	1..1	String	Имя медицинского работника
									,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
									--/HumanName	MiddleName	 	0..1	String	Отчество медицинского работника
									,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --не обязательное - сделать выборку после пробела в MED.PRENOM
								--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – медицинского работника (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
									--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
									,'223' as IdDocumentType -- тип документа - СНИЛС
									--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
									,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
									--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
									,'ПФР' as ProviderName -- организация, выдавшая документ
			--/CaseDto/Author	 	1..1	 	Лицо, являющееся автором передаваемого набора медицинской информации (как правило, лечащий врач)
				--/Author	IdRole	 	0..1	unsignedByte	Роль в оказании помощи (OID справочника: 1.2.643.5.1.13.2.7.1.30)
				,'4' AS IdRole -- передаем значение "лечащий врач"
				--/Author/Doctor	 	1..1	 	Информация о медицинском работнике
					--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится медицинский работник
					,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности медицинского работника (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as IdSpeciality
					--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности медицинского работника (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as IdPosition
				--/Doctor/Person	 	1..1	 	Информация о персоне
					--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156) --не обязательное
					--/Person	BirthDate	 	0..1	Datetime	Дата рождения --не обязательное
					--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
					--/Person/HumanName	 	1..1	 	ФИО медицинского работника
						--/HumanName	FamilyName	 	1..1	String	Фамилия медицинского работника
						,(select ltrim(rtrim(MED.NOM))) AS FamilyName
						--/HumanName	GivenName	 	1..1	String	Имя медицинского работника
						,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
						--/HumanName	MiddleName	 	0..1	String	Отчество медицинского работника
						,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --не обязательное - сделать выборку после пробела в MED.PRENOM
					--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – медицинского работника (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
						--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
						,'223' as IdDocumentType -- тип документа - СНИЛС
						--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
						,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
						--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
						,'ПФР' as ProviderName -- организация, выдавшая документ	
			--/CaseDto/LegalAuthenticator	 	0..1	 	В элементе указывается информация о лице, утвердившем информацию о случае обслуживания (несущем юридическую ответственность)
				--/LegalAuthenticator	IdRole	 	0..1	unsignedByte	Роль в оказании помощи (OID справочника: 1.2.643.5.1.13.2.7.1.30)
				,'4' AS IdRole -- пишем "лечащий врач"
				--/LegalAuthenticator/Doctor	 	1..1	 	Информация о медицинском работнике
					--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится медицинский работник
					,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности медицинского работника (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as IdSpeciality
					--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности медицинского работника (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as IdPosition
					--/Doctor/Person	 	1..1	 	Информация о персоне
						--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	Дата рождения
						--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
						,MED.KRN_GUID as IdPersonMis -- предлагаю использовать GUID, можно и MEDECINS_ID
						--/Person/HumanName	 	1..1	 	ФИО медицинского работника
							--/HumanName	FamilyName	 	1..1	String	Фамилия медицинского работника
							,(select ltrim(rtrim(MED.NOM))) AS FamilyName
							--/HumanName	GivenName	 	1..1	String	Имя медицинского работника
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
							--/HumanName	MiddleName	 	0..1	String	Отчество медицинского работника
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --не обязательное - сделать выборку после пробела в MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – медицинского работника (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
							,'223' as IdDocumentType -- тип документа - СНИЛС
							--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
							,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
							--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
							,'ПФР' as ProviderName -- организация, выдавшая документ	
			--/CaseDto/Guardian	 	0..1	 	Информация о другом участнике случая (родителе/ опекуне)
				-- написать выборку для пациентов, у которых есть законный представитель
				--/Guardian	IdRelationType	 	1..1	unsignedByte	Код отношения к пациенту (справочник Отношение к пациенту, OID 1.2.643.5.1.13.2.7.1.15)
				--/Guardian	UnderlyingDocument	 	1..1	String	Реквизиты документа, удостоверяющие право представлять пациента
				--/Guardian/Person	 	1..1	 	Информация о персоне
					--/Person	Sex	 	1..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
					--/Person	BirthDate	 	1..1	Datetime	Дата рождения
					--/Person	IdPersonMis	 	1..1	String	Идентификатор другого участника случая в МИС
					--/Person/HumanName	 	1..1	 	ФИО другого участника случая (родителя/ опекуна)
						--/HumanName	FamilyName	 	1..1	String	Фамилия
						--/HumanName	GivenName	 	1..1	String	Имя
						--/HumanName	MiddleName	 	0..1	String	Отчество
					--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах другого участника случая (объект заполняется аналогично документам пациента)
						--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
						--,'223' as IdDocumentType -- тип документа - СНИЛС
						--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
						--,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
						--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
						--,'ПФР' as ProviderName -- организация, выдавшая документ	
			--/CaseDto/Steps/StepAmb	 	1..*	 	Информация об эпизоде случая медицинского обслуживания
				-- опишем только текущий случай
				--/StepAmb	DateStart	 	1..1	Datetime	Дата начала эпизода
				,(cast (MOT.DATE_CONSULTATION as Date)) AS DateStart --пишем дату без времени, на которую проводилась консультация
				--/StepAmb	DateEnd	 	1..1	Datetime	Дата окончания эпизода
				,(cast (MOT.DATE_CONSULTATION as Date)) AS DateEnd --пишем ту же дату, так как это случай обслуживания в поликлинике - визит
				--/StepAmb	Comment	 	0..1	String	Комментарий
				,(CAST(convert(DATE, MOT.DATE_CONSULTATION, 104) as varchar) + ' / ' + MOT.REC_NAME ) AS Comment --напишем дату консультации и заголовок
				--/StepAmb	IdStepMis	 	1..1	String	Идентификатор эпизода случая медицинского обслуживания в передающей МИС
				,MOT.MOTCONSU_ID AS IdStepMis
				--/StepAmb	IdPaymentType	 	0..1	unsignedByte	Идентификатор источника финансирования (OID справочника: 1.2.643.2.69.1.1.1.32)
				,'1' AS IdPaymentType -- сейчас ставлю ОМС. В дальнейшем разобраться со справочником и способом определения источника финансирования
				--/StepAmb	IdVisitPlace	 	1..1	unsignedByte	Идентификатор места посещения (Классификатор мест обслуживания, OID справочника: 1.2.643.2.69.1.1.1.18) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/9/FilterTree
				,(CASE WHEN DMB.ED_RECEPTION_PLACE_ID = 1 THEN 1
						WHEN DMB.ED_RECEPTION_PLACE_ID = 2 THEN 2
						WHEN DMB.ED_RECEPTION_PLACE_ID = 3 THEN 4
						WHEN DMB.ED_RECEPTION_PLACE_ID = 4 THEN 3
						WHEN DMB.ED_RECEPTION_PLACE_ID = 5 THEN 5
						ELSE 6 END) as IdVisitPlace
				--/StepAmb	IdVisitPurpose	 	1..1	unsignedByte	Идентификатор цели посещения (Классификатор целей посещения амбулаторно-поликлинической организации, OID справочника: 1.2.643.2.69.1.1.1.19) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/10/FilterTree
				,'1' as IdVisitPurpose --пока пишу лечебно-диагностическая, потом будем сводиться по остальным
				--/StepAmb/Doctor	 	1..1	 	Информация о враче
					--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится врач
					,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности врача (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as IdSpeciality
					--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности врача (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as IdPosition
					--/Doctor/Person	 	1..1	 	Информация о персоне
						--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	Дата рождения
						--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
						,MED.KRN_GUID as IdPersonMis -- предлагаю использовать GUID, можно и MEDECINS_ID
						--/Person/HumanName	 	1..1	 	ФИО врача
							--/HumanName	FamilyName	 	1..1	String	Фамилия врача
							,(select ltrim(rtrim(MED.NOM))) AS FamilyName
							--/HumanName	GivenName	 	1..1	String	Имя врача
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
							--/HumanName	MiddleName	 	0..1	String	Отчество врача
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --не обязательное - сделать выборку после пробела в MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – врача (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
							,'223' as IdDocumentType -- тип документа - СНИЛС
							--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
							,MED.SYS_SNILS as DocN -- номер снилса доктора без пробелов и тире
							--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
							,'ПФР' as ProviderName -- организация, выдавшая документ	
-- открыли случай и добавили в него сведения об открывающей записи
			--/StepAmb/MedRecords	 	0..1	 	Массив MedRecord, доступных для эпизода амбулаторного случая обслуживания
			-- будет в отдельном запросе
			--/CaseDto/MedRecords	 	1..1	 	Массив MedRecord, доступных для амбулаторного случая обслуживания

FROM MOTCONSU MOT with (nolock)
LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC with (nolock) ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
LEFT JOIN ED_TREATMENT_FORM ETF with (nolock) ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID
LEFT JOIN ED_LEVEL_ACCESS ELA with (nolock) ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD
LEFT JOIN PATIENTS PAT with (nolock) on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED with (nolock) ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC with (nolock) ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
LEFT JOIN DATA_MOTCONSU_BILLDET DMB with (nolock) on DMB.MOTCONSU_ID = MOT.MOTCONSU_ID 
--LEFT JOIN MOTCONSU_XML MOTXML on MOTXML.MOTCONSU_ID = MOT.MOTCONSU_ID 

WHERE 
	MOT.PUBLISHED = 1 -- выбираем только опубликованные записи
	AND MOT.REC_STATUS = 'A' -- выбираем только подписанные врачом записи
	AND MOT.MOTCONSU_ID = MOT.MOTCONSU_EV_ID -- выбираем записи, открывающие событие либо одиночные визиты как начало случая
	--and MOT.CHANGED <> 1 --добавляем только не изменявшиеся запси, так как остальные будут "обновляться" при ранее созданном кейсе
	--and MOT.SEMD is not null -- смотрим только записи у которых заполнено поле Comment на вкладке СЭМД (открывается после закрытия случая)
ORDER BY MOT.MOTCONSU_ID DESC -- для разборки скрипта, потом можно убрать


END


GO


