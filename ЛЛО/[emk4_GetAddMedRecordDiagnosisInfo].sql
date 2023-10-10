CREATE PROCEDURE [dbo].[emk4_GetAddMedRecordDiagnosisInfo]
@IdCaseMis INT
AS
BEGIN
	--exec emk3_GetAddMedRecordDiagnosisInfo
	
			/*Запрос на добавление медицинской записи к случаю обслуживания
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
					--/DiagnosisInfo	1..1	DiagnosisInfo	Диагноз
						--IdDiseaseType	0..1	unsignedByte	Идентификатор характеров заболеваний (Справочник OID: 1.2.643.2.69.1.1.1.8)
						--DiagnosedDate	1..1	Datetime	Дата постановки диагноза
						,CASE WHEN instrum.DATA_W438_PROTOKOL_ISSLED_ID IS NOT NULL THEN instrum.DATE_CONSULTATION
						      WHEN epikriz.DATA_W438_EPIK_ZAK_AMB_ID    IS NOT NULL THEN epikriz.DATE_CONSULTATION
						      WHEN llo.DATA236_ID                       IS NOT NULL THEN llo.DATE_CONSULTATION
             ELSE (cast(DD.DATE_CONSULTATION as DATE)) END as DiagnosedDate
						--IdDiagnosisType	1..1	unsignedByte	Идентификатор статуса диагноза (Справочнк OID: 1.2.643.2.69.1.1.1.26)
						,1 AS IdDiagnosisType -- для всех пока пишем основной
						--Comment	1..1	String	Комментарий к диагнозу
						,MKB.DESCRIPTION AS Comment
						--DiagnosisChangeReason	0..1	unsignedByte	Причина изменения диагноза (для ранее зарегистрированного диагноза) (Справочник OID: 1.2.643.2.69.1.1.1.9)
						--DiagnosisStage	0..1	unsignedByte	Идентификатор этапа установления диагноза (Справочник OID: 1.2.643.2.69.1.1.1.10)
						--IdDispensaryState	0..1	unsignedByte	Идентификатор состояния диспансерного учета по данному диагнозу (заболеванию) (Справочник OID: 1.2.643.2.69.1.1.1.11)
						--IdTraumaType	0..1	unsignedByte	Идентификатор типа травм (Справочник OID: 1.2.643.2.69.1.1.1.12)
						--MESImplementationFeature	0..1	unsignedByte	Идентификатор особенности выполнения стандарта (Справочник OID: 1.2.643.2.69.1.1.1.13)
						--MedicalStandard	0..1	int	Код стандарта учета оказания медицинской помощи (Справочник OID: 1.2.643.2.69.1.1.1.29
						--MkbCode	1..1	String	Код заболевания по МКБ-10 (Справочник OID: 1.2.643.2.69.1.1.1.2)
						,CASE 
							WHEN instrum.DATA_W438_PROTOKOL_ISSLED_ID IS NOT NULL THEN MKB1.CODE
							WHEN llo.DATA236_ID                       IS NOT NULL THEN MKB2.CODE
                          ELSE MKB.CODE END AS MkbCode
					--/DiagnosisInfo 
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
	
	
FROM MOTCONSU MOT with (nolock)
LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
--LEFT JOIN ED_TREATMENT_FORM ETF ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID
--LEFT JOIN ED_LEVEL_ACCESS ELA ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD
LEFT JOIN DATA_W438_PROTOKOL_ISSLED instrum ON instrum.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_W438_EPIK_ZAK_AMB epikriz    ON epikriz.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_GRACE_PRESCRIPTION llo ON mot.MOTCONSU_ID = llo.MOTCONSU_ID 
LEFT JOIN PATIENTS PAT on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
LEFT JOIN DATA_MOTCONSU_BILLDET DMB on DMB.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
LEFT JOIN CIM10 MKB1 on MKB1.CIM10_ID = instrum.NAPRAVITEL_NYY_DIAGNOZ
LEFT JOIN CIM10 MKB2 on MKB2.CIM10_ID = llo.DIAGNOZ_MKB_10

--LEFT JOIN MOTCONSU_XML MOTXML on MOTXML.MOTCONSU_ID = MOT.MOTCONSU_ID 

where 
--MOT.PUBLISHED = 1 -- выбираем только опубликованные записи
--and MOT.REC_STATUS = 'A' -- выбираем только подписанные врачом записи
--AND 
MOT.MOTCONSU_ID = @IdCaseMis
--and MOT.CHANGED <> 1 --добавляем только не изменявшиеся запси, так как остальные будут "обновляться" при ранее созданном кейсе
--and MOT.MOTCONSU_ID <> MOT.MOTCONSU_EV_ID -- выбираем записи, которые не открывают событие, а созданы в рамках законченного случая
--and MOT.ZAPIS_ZAKR_VAYHAQ_SOB_TIE <> 1 -- это не должна быть последняя запись, закрывающаяя событие, так как она будет передана в CloseCase

ORDER BY MOT.MOTCONSU_ID DESC -- для разборки скрипта, потом можно убрать
END



GO


GRANT EXECUTE ON [dbo].[emk4_GetAddMedRecordDiagnosisInfo] TO [iemk_user]
GRANT ALTER ON [dbo].[emk4_GetAddMedRecordDiagnosisInfo] TO [iemk_user]
GRANT CONTROL ON [dbo].[emk4_GetAddMedRecordDiagnosisInfo] TO [iemk_user]