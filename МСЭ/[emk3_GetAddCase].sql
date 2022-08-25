ALTER PROCEDURE [dbo].[emk3_GetAddCase] 
@dateStart NVARCHAR(8), 
@dateEnd NVARCHAR(8),
@flag INT, -- 0 добавление, 1 обновление, 2 по одной записи
@IdCaseMic NVARCHAR(36) = NULL
AS
BEGIN

	--exec [emk3_GetAddCase] '20190201', '20190228'
	
			/*Запрос на выбор законченного случая амбулаторного обслуживания
			для региональной шины N3.Здравоохранение
			от 10.10.2018
			Автор: Николенко Р.*/
		--Изменения 13.02.2019 в IdPosition поменяли должность spec.DOLZGNOST на SPEC.DOLZGNOST
		--Изменения ashur 28.03.2020  IdCaseResult IdAmbResult
		--Изменения ashur 30.09.2020 изменил idLpu подразделений
		--Изменил ashur 13.04.2021 добавил AND mot.MEDDEP_ID = m.MEDDEP_ID

		-- необходимо выбрать все визиты в рамках случая если их было больше одного во временную таблицу
				BEGIN
				IF 1 = 1 --LOOP CONDITION
					BEGIN
					If EXISTS(SELECT * FROM tempdb..sysobjects WHERE id = object_id('tempdb.dbo.#temp_semd'))
						DROP TABLE #TEMP_SEMD
					    --SELECT * INTO #TEMP FROM TABLE1
					END
				ELSE
					BEGIN
					If EXISTS(SELECT * FROM tempdb..sysobjects WHERE id = object_id('tempdb.dbo.#temp_SEMD'))
						DROP TABLE #TEMP_SEMD
						--SELECT * INTO #TEMP FROM TABLE2
					END 
				END


--AddCase---------------------------------------------------------------------------------------------------------------
	--/	guid	 	1..1	GUID	Авторизационный токен --------------------------------------------------------------
		--выбрать нужно GUID 
	--/CaseAmb ---------------------------------------------------------------------------------------------------------
		--/CaseDto	 	1..1	 	Информация о случае медицинского обслуживания. Для значения xsi:type указывается CaseAmb
			SELECT 
			--top 100
			--/CaseDto	OpenDate	 	1..1	Datetime	Дата открытия случая
			( cast((select TOP 1 SVOD.DATE_CONSULTATION from (select MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE from MOTCONSU where EV_DATE_CLOSE is not null
			group by MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE) SVOD where SVOD.MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID) as date )) AS OpenDate -- так, потому, что по дебильному записывается в таблицу значения открытия и закрытия СЛУЧАЯ, а не события
			--/CasеDto	CloseDate	 	1..1	Datetime	Дата закрытия случая
			,( cast((select TOP 1 SVOD.EV_DATE_CLOSE from (select MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE from MOTCONSU where EV_DATE_CLOSE is not null
			group by MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE) SVOD where SVOD.MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID) as date )) AS CloseDate -- так, потому, что по дебильному записывается в таблицу значения открытия и закрытия СЛУЧАЯ, а не события
			--/CaseDto	HistoryNumber	 	1..1	String	Номер истории болезни/ Амбулаторного талона
			,MOT.MOTCONSU_EV_ID AS HistoryNumber
			--/CaseDto	IdCaseMis	 	1..1	String	Идентификатор случая в передающей МИС
			,MOT.MOTCONSU_EV_ID AS IdCaseMis		
			,MOT.MOTCONSU_ID --для обновления случая	
			--/CaseDto	IdCaseAidType	 	0..1	unsignedByte	Идентификатор вида медицинского обслуживания (OID справочника: 1.2.643.2.69.1.1.1.16) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/7/FilterTree
			,CASE WHEN ISNULL(ETF.ED_TREATMENT_FORM_CODE, '') = '' and ISNULL(DAPC.OMS_V008_ID, '') != ''
			THEN (CASE WHEN DAPC.OMS_V008_ID = 7 THEN '3'
			      WHEN DAPC.OMS_V008_ID = 6 then '1'
				  WHEN DAPC.OMS_V008_ID = 1 then '1'
				  WHEN DAPC.OMS_V008_ID = 2 then '2'
				  WHEN DAPC.OMS_V008_ID = 3 then '3'
				  ELSE '6' END) 
					ELSE 
					(CASE WHEN ISNULL(ETF.ED_TREATMENT_FORM_CODE, '') = '' 
					THEN 6 
					ELSE ETF.ED_TREATMENT_FORM_CODE END)
				END	AS IdCaseAidType
			--/CaseDto	IdPaymentType	 	1..1	unsignedByte	Идентификатор источника финансирования (OID справочника: 1.2.643.2.69.1.1.1.32) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/25/FilterTree
			,1 AS IdPaymentType -- сейчас ставлю ОМС. В дальнейшем разобраться со справочником и способом определения источника финансирования
			--/CaseDto	Confidentiality	 	1..1	unsignedByte	Уровень конфиденциальности передаваемой информации (OID справочника: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			--,ELA.CODE 
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 2
				ELSE ELA.CODE END) AS Confidentiality -- Ставится на вкладке СЭМД таблица ED_LEVEL_ACCESS нет понимания о методе опредедления конфиденциальности	
			--/CaseDto	DoctorConfidentiality	 	1..1	unsignedByte	Уровень конфиденциальности передаваемой информации для врача (OID справочника: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 2
				ELSE ELA.CODE END) AS DoctorConfidentiality -- ставлю пока такой же код таблица ED_LEVEL_ACCESS нет понимания о методе опредедления конфиденциальности
			--/CaseDto	CuratorConfidentiality	 	1..1	unsignedByte	Уровень конфиденциальности передаваемой информации для представителя пациента/опекуна (OID справочника: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 2
				ELSE ELA.CODE END) AS CuratorConfidentiality -- ставлю пока такой же код таблица ED_LEVEL_ACCESS нет понимания о методе опредедления конфиденциальности		
			--/CaseDto	IdLpu	 	1..1	guid	Идентификатор МО
			,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu -- создать поле в таблице FM_ORG для хранения GUID MO (выданный Нетрикой) либо кроссировку делать на OID Росминздрава, со слов Дмитрия Пархимовича можно использовать OID Минздрава
			--/CaseDto	IdCaseResult	 	1..1	unsignedByte	Идентификатор исхода заболевания (OID справочника: 1.2.643.5.1.13.2.1.1.688) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/88/FilterTree Справочник не соответствует ТФОМСу. Проверить сопоставление после обновления
			,CASE WHEN ISNULL(DAPC.ED_OUTCOMES_ID, '') = '' and ISNULL(DAPC.OMS_V012_ID, '') != ''
      THEN (CASE WHEN DAPC.OMS_V012_ID in (1,5,9) THEN 1
      WHEN DAPC.OMS_V012_ID in (2,6,11,15) THEN 2
      WHEN DAPC.OMS_V012_ID in (3,7,12,16) THEN 3
      WHEN DAPC.OMS_V012_ID in (4,8,13,17) THEN 4
      WHEN DAPC.OMS_V012_ID in (1,5,9,14) THEN 5
      END) ELSE 
      (CASE WHEN ISNULL(DAPC.ED_OUTCOMES_ID, '') = '' THEN 3 ELSE 
      	(CASE WHEN DAPC.ED_OUTCOMES_ID in (1,12,16) THEN 1
      WHEN DAPC.ED_OUTCOMES_ID in (3,6,9,13) THEN 2
      WHEN DAPC.ED_OUTCOMES_ID in (4,7,10,14) THEN 3
      WHEN DAPC.ED_OUTCOMES_ID in (5,8,11,15) THEN 4
      WHEN DAPC.ED_OUTCOMES_ID in (1,5,9,14) THEN 6 ELSE 3
      END)
      	 END)
      END AS IdCaseResult
			--/CaseDto	Comment	 	1..1	String	Текст заключения из эпикриза и/или другую важную медицинскую информацию в неструктурированном виде, например, текст медицинского протокола
			--,(convert (VARCHAR(8000), MOT.SEMD)) as Comment	-- Вкладка СЭМД открывается после установки признака случай закрыт
			,MOT.REC_NAME AS [Comment] --Подставил Ашурков А. 20102018 для тестирования отправки случая
			--/CaseDto	IdPatientMis	 	1..1	String	Идентификатор пациента в передающей системе
			,PAT.KRN_GUID AS IdPatientMis
			--/CaseDto	IdCasePurpose	 	0..1	unsignedByte	Идентификатор цели обращения (Классификатор поводов обращения за медицинской помощью, OID справочника: 1.2.643.5.1.13.2.1.1.106)
			,(CASE WHEN ISNULL(DAPC.OMS_V025_ID, '') != ''
      THEN 
      (CASE WHEN DAPC.OMS_V025_ID in (1,2,3,10) THEN 1
      WHEN DAPC.OMS_V025_ID in (4) THEN 3
      WHEN DAPC.OMS_V025_ID in (5) THEN 4
      WHEN DAPC.OMS_V025_ID in (7) THEN 5
      WHEN DAPC.OMS_V025_ID in (6) THEN 10
      ELSE 12 END)
      ELSE
      (CASE WHEN DAPC.VID_PRIEMA = 1 OR DAPC.VID_PRIEMA = 20 THEN 1
          WHEN DAPC.VID_PRIEMA = 13 THEN 2
          WHEN DAPC.VID_PRIEMA = 11 THEN 3
          WHEN DAPC.VID_PRIEMA = 16 THEN 4 
          WHEN DAPC.VID_PRIEMA = 2 THEN 5 
          ELSE 12 END) 
        END) as IdCasePurpose -- значения из таблицы ED_RECEPTION_TYPE посмотреть, что еще нужно сопоставить
			--/CaseDto	IdCaseType	 	1..1	unsignedByte	Идентификатор типа случая обслуживания: амбулаторный, диспансеризация (OID справочника: 1.2.643.2.69.1.1.1.35)
			,(CASE WHEN ISNULL(DAPC.OMS_V006_ID, '') != ''
      THEN
			(CASE WHEN DAPC.OMS_V006_ID = 3 OR DAPC.OMS_V006_ID = 4 THEN 2
					WHEN DAPC.OMS_V006_ID = 1 THEN 3 ELSE 2 END)
				ELSE
			(CASE WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 3 OR DAPC.ED_MED_PROVISION_CONDITIONS_ID = 4 THEN 2
					WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 1 THEN 3 ELSE 2 END)
				END)	as IdCaseType -- таблица ED_MEDPROVISION_CONDITIONS
			--/CaseDto	IdAmbResult	 	0..1	unsignedByte	Код результата обращения (OID справочника: 1.2.643.2.69.1.1.1.17)
			,CASE WHEN ISNULL(DAPC.ED_OUTCOMES_ID, '') = '' and ISNULL(DAPC.OMS_V012_ID, '') != ''
			THEN(CASE WHEN DAPC.OMS_V012_ID IN(1,5,9) THEN 1
					WHEN DAPC.OMS_V012_ID in(2,6,11,15) THEN 2
					WHEN DAPC.OMS_V012_ID IN(4,3,10, 14) THEN 3
					ELSE 17 END)
			ELSE 
      (CASE WHEN ISNULL(DAPC.ED_OUTCOMES_ID, '') = '' THEN 
      	(CASE WHEN DAPC.ED_OUTCOMES_ID IN(1,12,16) THEN 1
					WHEN DAPC.ED_OUTCOMES_ID in(3,6,9,13) THEN 2
					WHEN DAPC.ED_OUTCOMES_ID IN(2,10, 18) THEN 3
					ELSE 17 END)
      	 ELSE 3 END)
      END	as IdAmbResult -- таблица ED_OUTCOMES		
			--/CaseDto	IsActive	 	0..1	Boolean	Признак «Актив». Признак устанавливается, если пациент был направлен на приём к врачу
			,1 as IsActive -- пока считаем, что все пациенты направлены к врачу, позже логику продумаем
			--/CaseDto/DoctorInCharge	 	1..1	 	Информация о лечащем враче -------------------------------------
				--/DoctorInCharge	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится врач
				,fm.depart_oid AS [CaseDto_DoctorInCharge_IdLpu] -- создать поле в таблице FM_ORG для хранения GUID MO (выданный Нетрикой) либо кроссировку делать на OID Росминздрава, со слов Дмитрия Пархимовича можно использовать OID Минздрава
				--/DoctorInCharge	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности врача (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
				,SPEC.Nsi_specialisation_ID as [CaseDto_DoctorInCharge_IdSpeciality]
				--/DoctorInCharge	IdPosition	 	1..1	unsignedShort	Идентификатор должности врача (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
				,SPEC.DOLZGNOST as [CaseDto_DoctorInCharge_IdPosition] -- Добавить в таблицу SPECIALISATION новый столбец DOLZGNOST int, провести сопоставление со справочником 1.2.643.5.1.13.2.1.1.607 -- сделать скрипт на обновление значений в таблицах у МО

				--/DoctorInCharge/Person	 	1..1	 	Информация о персоне (враче)
					--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
					--не обязательное, потом подумаем про секс врачей
					--/Person	BirthDate	 	0..1	Datetime	Дата рождения
					,med.DATA_ROGDENIQ  [DoctorInCharge_Person_BirthDate]
					--не обязательное, потом подумаем
					--/Person	IdPersonMis	 	1..1	String	Идентификатор врача в МИС
					,MED.KRN_GUID as [DoctorInCharge_Person_IdPersonMis] -- предлагаю использовать GUID, можно и MEDECINS_ID
						--/Person/HumanName	 	1..1	 	ФИО врача
							--/HumanName	FamilyName	 	1..1	String	Фамилия врача
							,(select ltrim(rtrim(MED.NOM))) AS [Person_HumanName_FamilyName]
							--/HumanName	GivenName	 	1..1	String	Имя врача
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [Person_HumanName_GivenName]
							--/HumanName	MiddleName	 	0..1	String	Отчество врача
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [Person_HumanName_MiddleName] --не обязательное - сделать выборку после пробела в MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – врача (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
							,223 as [Person_Documents_IdentityDocument_IdDocumentType] -- тип документа - СНИЛС
							--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
							,MED.SYS_SNILS as [Person_Documents_IdentityDocument_DocN] -- номер снилса доктора без пробелов и тире
							--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
							,'ПФР' as [Person_Documents_IdentityDocument_ProviderName] -- организация, выдавшая документ
			--/CaseDto/Authenticator	 	1..1	 	Лицо, подписывающее или визирующее формируемый набор медицинской информации
				--/Authenticator	IdRole	 	0..1	unsignedByte	Роль в оказании помощи (OID справочника: 1.2.643.5.1.13.2.7.1.30) не обязательное
					--/Authenticator/Doctor	 	1..1	 	Информация о медицинском работнике
						--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится медицинский работник
						,--(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) 
						fm.depart_oid AS [Authenticator_Doctor_IdLpu]
						--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности медицинского работника (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
						,SPEC.Nsi_specialisation_ID as [Authenticator_Doctor_IdSpeciality]
						--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности медицинского работника (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
						,SPEC.DOLZGNOST as [Authenticator_Doctor_IdPosition]
							--/Doctor/Person	 	1..1	 	Информация о персоне --не обязательное
								--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156) --не обязательное
								--/Person	BirthDate	 	0..1	Datetime	Дата рождения --не обязательное
								,med.DATA_ROGDENIQ [Doctor_Person_BirthDate]
								--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
								,MED.KRN_GUID as [Doctor_Person_IdPersonMis] -- предлагаю использовать GUID, можно и MEDECINS_ID
								--/Person/HumanName	 	1..1	 	ФИО медицинского работника
									--/HumanName	FamilyName	 	1..1	String	Фамилия медицинского работника
									,(select ltrim(rtrim(MED.NOM))) AS [Doctor_Person_HumanName_FamilyName]
									--/HumanName	GivenName	 	1..1	String	Имя медицинского работника
									,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [Doctor_Person_HumanName_GivenName]
									--/HumanName	MiddleName	 	0..1	String	Отчество медицинского работника
									,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [Doctor_Person_HumanName_MiddleName] --не обязательное - сделать выборку после пробела в MED.PRENOM
								--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – медицинского работника (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
									--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
									,223 as [Doctor_Person_Documents_IdentityDocument_IdDocumentType] -- тип документа - СНИЛС
									--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
									,MED.SYS_SNILS as [Doctor_Person_Documents_IdentityDocument_DocN] -- номер снилса доктора без пробелов и тире
									--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
									,'ПФР' as [Doctor_Person_Documents_IdentityDocument_ProviderName] -- организация, выдавшая документ
			--/CaseDto/Author	 	1..1	 	Лицо, являющееся автором передаваемого набора медицинской информации (как правило, лечащий врач)
				--/Author	IdRole	 	0..1	unsignedByte	Роль в оказании помощи (OID справочника: 1.2.643.5.1.13.2.7.1.30)
				,4 AS IdRole -- передаем значение "лечащий врач"
				--/Author/Doctor	 	1..1	 	Информация о медицинском работнике
					--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится медицинский работник
					,fm.depart_oid AS [Author_Doctor_IdLpu]
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности медицинского работника (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as [Author_Doctor_IdSpeciality]
					--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности медицинского работника (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as [Author_Doctor_IdPosition]
				--/Doctor/Person	 	1..1	 	Информация о персоне
					--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156) --не обязательное
					--/Person	BirthDate	 	0..1	Datetime	Дата рождения --не обязательное
					,med.DATA_ROGDENIQ  [Author_Doctor_Person_BirthDate]
					--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
					,MED.KRN_GUID as [Author_Doctor_Person_IdPersonMis] -- предлагаю использовать GUID, можно и MEDECINS_ID
					--/Person/HumanName	 	1..1	 	ФИО медицинского работника
						--/HumanName	FamilyName	 	1..1	String	Фамилия медицинского работника
						,(select ltrim(rtrim(MED.NOM))) AS [Author_Doctor_Person_HumanName_FamilyName]
						--/HumanName	GivenName	 	1..1	String	Имя медицинского работника
						,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [Author_Doctor_Person_HumanName_GivenName]
						--/HumanName	MiddleName	 	0..1	String	Отчество медицинского работника
						,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [Author_Doctor_Person_HumanName_MiddleName] --не обязательное - сделать выборку после пробела в MED.PRENOM
					--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – медицинского работника (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
						--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
						,223 as [Author_Doctor_Person_IdDocumentType] -- тип документа - СНИЛС
						--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
						,MED.SYS_SNILS as [Author_Doctor_Person_DocN] -- номер снилса доктора без пробелов и тире
						--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
						,'ПФР' as [Author_Doctor_Person_ProviderName] -- организация, выдавшая документ	
			--/CaseDto/LegalAuthenticator	 	0..1	 	В элементе указывается информация о лице, утвердившем информацию о случае обслуживания (несущем юридическую ответственность)
				--/LegalAuthenticator	IdRole	 	0..1	unsignedByte	Роль в оказании помощи (OID справочника: 1.2.643.5.1.13.2.7.1.30)
				--/LegalAuthenticator/Doctor	 	1..1	 	Информация о медицинском работнике
					--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится медицинский работник
					,fm.depart_oid AS [LegalAuthenticator_Doctor_IdLpu]
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности медицинского работника (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as [LegalAuthenticator_Doctor_IdSpeciality]
					--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности медицинского работника (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as [LegalAuthenticator_Doctor_IdPosition]
					--/Doctor/Person	 	1..1	 	Информация о персоне
						--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	Дата рождения
						,med.DATA_ROGDENIQ  [LegalAuthenticator_Doctor_Person_BirthDate]
						--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
						,MED.KRN_GUID as [LegalAuthenticator_Doctor_Person_IdPersonMis] -- предлагаю использовать GUID, можно и MEDECINS_ID
						--/Person/HumanName	 	1..1	 	ФИО медицинского работника
							--/HumanName	FamilyName	 	1..1	String	Фамилия медицинского работника
							,(select ltrim(rtrim(MED.NOM))) AS [LegalAuthenticator_Doctor_Person_FamilyName]
							--/HumanName	GivenName	 	1..1	String	Имя медицинского работника
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [LegalAuthenticator_Doctor_Person_GivenName]
							--/HumanName	MiddleName	 	0..1	String	Отчество медицинского работника
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [LegalAuthenticator_Doctor_Person_MiddleName] --не обязательное - сделать выборку после пробела в MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – медицинского работника (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
							,223 as [LegalAuthenticator_Doctor_Person_IdDocumentType] -- тип документа - СНИЛС
							--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
							,MED.SYS_SNILS as [LegalAuthenticator_Doctor_Person_DocN] -- номер снилса доктора без пробелов и тире
							--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
							,'ПФР' as [LegalAuthenticator_Doctor_Person_ProviderName] -- организация, выдавшая документ	
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
-------------/CaseDto/Steps/StepAmb	 	1..*	 	Информация об эпизоде случая медицинского обслуживания
				-- необходимо выбрать все визиты в рамках случая если их было больше одного

				--/StepAmb	DateStart	 	1..1	Datetime	Дата начала эпизода
				,MOT.DATE_CONSULTATION AS DateStart --пишем дату, на которую проводилась консультация
				--/StepAmb	DateEnd	 	1..1	Datetime	Дата окончания эпизода
				,MOT.DATE_CONSULTATION AS DateEnd --пишем ту же дату, так как это случай обслуживания в поликлинике - визит
				--/StepAmb	Comment	 	0..1	String	Комментарий
				,MOT.REC_NAME AS [Steps_Comment]
				--/StepAmb	IdStepMis	 	1..1	String	Идентификатор эпизода случая медицинского обслуживания в передающей МИС
				,MOT.MOTCONSU_ID AS IdStepMis
				--/StepAmb	IdPaymentType	 	0..1	unsignedByte	Идентификатор источника финансирования (OID справочника: 1.2.643.2.69.1.1.1.32)
				,1 AS [Steps_IdPaymentType] -- сейчас ставлю ОМС. В дальнейшем разобраться со справочником и способом определения источника финансирования
				--/StepAmb	IdVisitPlace	 	1..1	unsignedByte	Идентификатор места посещения (Классификатор мест обслуживания, OID справочника: 1.2.643.2.69.1.1.1.18) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/9/FilterTree
				,(CASE WHEN ISNULL(DAPC.OMS_TER_PODRAZD_ID, '') != ''
				THEN
				(CASE WHEN DAPC.OMS_TER_PODRAZD_ID = 21 THEN 1
				WHEN DAPC.OMS_TER_PODRAZD_ID in (4, 10, 11) THEN 3
				WHEN DAPC.OMS_TER_PODRAZD_ID in (2, 3, 6, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20) THEN 3
				ELSE 6 END)
				ELSE
				(CASE WHEN DMB.ED_RECEPTION_PLACE_ID = 1 THEN 1
						WHEN DMB.ED_RECEPTION_PLACE_ID = 2 THEN 2
						WHEN DMB.ED_RECEPTION_PLACE_ID = 3 THEN 4
						WHEN DMB.ED_RECEPTION_PLACE_ID = 4 THEN 3
						WHEN DMB.ED_RECEPTION_PLACE_ID = 5 THEN 5
						ELSE 6 END)
					END)	as IdVisitPlace
				--/StepAmb	IdVisitPurpose	 	1..1	unsignedByte	Идентификатор цели посещения (Классификатор целей посещения амбулаторно-поликлинической организации, OID справочника: 1.2.643.2.69.1.1.1.19) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/10/FilterTree
				,1 as IdVisitPurpose --пока пишу лечебно-диагностическая, потом будем сводиться по остальным
				--/StepAmb/Doctor	 	1..1	 	Информация о враче
					--/Doctor	IdLpu	 	0..1	guid	Идентификатор МО, к которому относится врач
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	Идентификатор специальности врача (Номенклатура специальностей специалистов с высшим и послевузовским медицинским и фармацевтическим образованием в сфере здравоохранения, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as [StepAmb_Doctor_IdSpecialit]
					--/Doctor	IdPosition	 	1..1	unsignedShort	Идентификатор должности врача (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as [StepAmb_Doctor_IdPosition]
					--/Doctor/Person	 	1..1	 	Информация о персоне
						--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	Дата рождения
						,med.DATA_ROGDENIQ  [StepAmb_Doctor_BirthDate]
						--/Person	IdPersonMis	 	1..1	String	Идентификатор участника случая в МИС
						,MED.KRN_GUID as [StepAmb_Doctor_IdPersonMis] -- предлагаю использовать GUID, можно и MEDECINS_ID
						--/Person/HumanName	 	1..1	 	ФИО врача
							--/HumanName	FamilyName	 	1..1	String	Фамилия врача
							,(select ltrim(rtrim(MED.NOM))) AS [StepAmb_Doctor_FamilyName]
							--/HumanName	GivenName	 	1..1	String	Имя врача
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [StepAmb_Doctor_GivenName]
							--/HumanName	MiddleName	 	0..1	String	Отчество врача
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [StepAmb_Doctor_MiddleName] --не обязательное - сделать выборку после пробела в MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – врача (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
							,223 as [StepAmb_Doctor_IdDocumentType] -- тип документа - СНИЛС
							--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
							,MED.SYS_SNILS as [StepAmb_Doctor_DocN] -- номер снилса доктора без пробелов и тире
							--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
							,'ПФР' as [StepAmb_Doctor_ProviderName] -- организация, выдавшая документ	
							
	--/StepAmb/MedRecords	 	0..1	 	Массив MedRecord, доступных для эпизода амбулаторного случая обслуживания

--/CaseDto/MedRecords	 	1..1	 	Массив MedRecord, доступных для амбулаторного случая обслуживания
--CaseVisitType 	1..1 	byte 	Порядок обращения (OID справочника: 1.2.643.5.1.13.13.11.1007 ) 
							,cast((case when DMB.VISIT_NUMBER = 0 THEN 1 when DMB.VISIT_NUMBER >= 1 THEN 2 ELSE 2 END)  AS NVARCHAR(2)) CaseVisitType

FROM MOTCONSU MOT WITH (NOLOCK)
LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
LEFT JOIN ED_TREATMENT_FORM ETF ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID
LEFT JOIN ED_LEVEL_ACCESS ELA ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD
LEFT JOIN PATIENTS PAT ON PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
LEFT JOIN DATA_MOTCONSU_BILLDET DMB on DMB.MOTCONSU_ID = MOT.MOTCONSU_ID 
LEFT JOIN OMS_TER_PODRAZD OTP ON OTP.OMS_TER_PODRAZD_ID = DAPC.OMS_TER_PODRAZD_ID
JOIN (SELECT * FROM meddep WHERE ARCHIVE != 1) m ON m.MEDECINS_ID = med.MEDECINS_ID AND mot.MEDDEP_ID = m.MEDDEP_ID
LEFT JOIN (SELECT * FROM fm_dep_frmo fm  WHERE mo_oid IN (SELECT IEMK_OID FROM fm_org WHERE FM_ORG_ID = 1) )fm ON fm.FM_DEP_FRMO_ID = m.FM_DEP_FRMO_ID

WHERE 
		-- делаем выборку для случаев, у которых только 1 визит
		MOT.MOTCONSU_ID in (select MOTCONSU_ID FROM ( SELECT MOTCONSU_ID, MOTCONSU_EV_ID FROM MOTCONSU GROUP BY MOTCONSU_ID, MOTCONSU_EV_ID HAVING COUNT(*) = 1 ) E)
		-- делаем выборку только из закрытых случаев обращения
		and MOT.EV_CLOSE = 1 
		-- запись, которая закрывает событие
		and MOT.ZAPIS_ZAKR_VAYHAQ_SOB_TIE = 1 
		-- выбираем только опубликованные записи
		--and MOT.PUBLISHED = 1 
		-- выбираем только подписанные врачом записи
		--and MOT.REC_STATUS = 'A'
		--добавляем только не изменявшиеся запси, так как остальные будут "обновляться" при ранее созданном кейсе
		--and MOT.CHANGED <> 1 
		
		AND (( CAST((SELECT TOP 1 SVOD.DATE_CONSULTATION FROM (SELECT MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE FROM MOTCONSU WHERE EV_DATE_CLOSE IS NOT NULL
			GROUP BY MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE) SVOD WHERE SVOD.MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID) AS DATE )) >= @dateStart AND 
			( CAST((SELECT TOP 1 SVOD.DATE_CONSULTATION FROM (SELECT MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE FROM MOTCONSU WHERE EV_DATE_CLOSE IS NOT NULL
			GROUP BY MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE) SVOD WHERE SVOD.MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID) AS DATE )) <= @dateEnd)
	--AND med.MEDECINS_ID = 2600038
		--AND  MOT.MOTCONSU_EV_ID IN (SELECT IdCaseMis FROM emk.dbo.ztepmpat_460066)
	

AND((@flag = 0 AND ( EMK3_SENDED IS NULL OR EMK3_SENDED = 0))
OR ( @flag = 1 AND EMK3_SENDED < mot.KRN_MODIFY_DATE AND EMK3_SENDED IN(2,3))
OR (@flag = 2 AND mot.KRN_GUID = @IdCaseMic))


	--AND	(EMK3_SEND_DATE < MOT.KRN_MODIFY_DATE 
	--AND ( EMK3_SENDED IS NULL OR EMK3_SENDED = 0)--)
	--AND MOT.MOTCONSU_EV_ID = 622199


		--and MOT.SEMD is not null -- смотрим только записи у которых заполнено поле Comment на вкладке СЭМД (открывается после закрытия случая)
ORDER BY MOT.MOTCONSU_ID DESC  -- для разборки скрипта, потом можно убрать

END






GO


