CREATE VIEW [dbo].[view_emk3_MedicalStaff]
 AS
SELECT SPEC.Nsi_specialisation_ID as [IdSpeciality]
				--/DoctorInCharge	IdPosition	 	1..1	unsignedShort	Идентификатор должности врача (Номенклатура должностей медицинских работников и фармацевтических работников, OID 1.2.643.5.1.13.2.1.1.607)
				,SPEC.DOLZGNOST as [IdPosition] -- Добавить в таблицу SPECIALISATION новый столбец DOLZGNOST int, провести сопоставление со справочником 1.2.643.5.1.13.2.1.1.607 -- сделать скрипт на обновление значений в таблицах у МО

				--/DoctorInCharge/Person	 	1..1	 	Информация о персоне (враче)
					--/Person	Sex	 	0..1	unsignedByte	Код пола (Классификатор половой принадлежности, OID 1.2.643.5.1.13.2.1.1.156)
					--не обязательное, потом подумаем про секс врачей
					--/Person	BirthDate	 	0..1	Datetime	Дата рождения
					,med.DATA_ROGDENIQ  [BirthDate]
					--не обязательное, потом подумаем
					--/Person	IdPersonMis	 	1..1	String	Идентификатор врача в МИС
					,MED.MEDECINS_ID as [IdPersonMis] -- предлагаю использовать GUID, можно и MEDECINS_ID
						--/Person/HumanName	 	1..1	 	ФИО врача
							--/HumanName	FamilyName	 	1..1	String	Фамилия врача
							,(select ltrim(rtrim(MED.NOM))) AS [FamilyName]
							--/HumanName	GivenName	 	1..1	String	Имя врача
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [GivenName]
							--/HumanName	MiddleName	 	0..1	String	Отчество врача
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [MiddleName] --не обязательное - сделать выборку после пробела в MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	Информация о документах участника случая – врача (объект заполняется аналогично документам пациента). Передается информация о СНИЛС (при ее наличии в МИС).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	Код типа документа (OID справочника: 1.2.643.2.69.1.1.1.6)
							,223 as [IdDocumentType] -- тип документа - СНИЛС
							--/DocumentDto	DocN	 	1..1	String	Номер документа. Не должны использоваться разделители (пробелы, тире и т.д.)
							,MED.SYS_SNILS as [DocN] -- номер снилса доктора без пробелов и тире
							--/DocumentDto	ProviderName	 	1..1	String	Наименование организации, выдавшей документ
							,'ПФР' as [ProviderName] -- организация, выдавшая документ
							,sd.MEDECINS_ID
							,sd.SIGN_TYPE
							,sd.MOTCONSU_ID
							,sd.SIGN_ROLE
							,sd.SIGN_BODY
FROM MEDECINS MED 
JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
JOIN SIGN_DATA AS sd ON sd.MEDECINS_ID = MED.MEDECINS_ID




GO




GO
GRANT INSERT ON [dbo].[view_emk3_MedicalStaff] TO [fer]
GO

GO
GRANT SELECT ON [dbo].[view_emk3_MedicalStaff] TO [fer]
GO

GO
GRANT ALTER ON [dbo].[view_emk3_MedicalStaff] TO [fer]
GO

GO
GRANT UPDATE ON [dbo].[view_emk3_MedicalStaff] TO [fer]
GO

GO
GRANT DELETE ON [dbo].[view_emk3_MedicalStaff] TO [fer]
GO

GO
GRANT CONTROL ON [dbo].[view_emk3_MedicalStaff] TO [fer]
GO

GO
GRANT INSERT ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO

GO
GRANT SELECT ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO

GO
GRANT ALTER ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO

GO
GRANT UPDATE ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO

GO
GRANT DELETE ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO

GO
GRANT CONTROL ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO



