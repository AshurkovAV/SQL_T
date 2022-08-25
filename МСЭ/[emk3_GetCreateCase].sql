
ALTER PROCEDURE [dbo].[emk3_GetCreateCase]
AS
BEGIN
	--exec [emk3_GetCreateCase]
	
					/*������ �� ����� ������������ ������ ������������� ������������
			��� ������������ ���� N3.���������������
			�� 10.10.2018
			�����: ��������� �.*/

--������ ������� ���������� ������� DOLZGNOST � ������� SPECIALISATION
-- ������ ���� SPECIALISATION_UPDATE.sql


--CreateCase------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	--/	guid	 	1..1	GUID	��������������� ����� --------------------------------------------------------------
		--������� ����� GUID 
	--/CaseDto	 	1..1	 	���������� � ������ ������������ ������������. ��� �������� xsi:type ����������� CaseAmb
		--/CaseDto	 	1..1	 	���������� � ������ ������������ ������������. ��� �������� xsi:type ����������� CaseAmb
			SELECT TOP 1000
			--/CaseDto	OpenDate	 	1..1	Datetime	���� �������� ������
			(cast (MOT.DATE_CONSULTATION as Date)) AS OpenDate 
			--/Cas�Dto	CloseDate	 	1..1	Datetime	���� �������� ������
			-- �� ��������, ��� ��� �� ���� ���, ������ ������ ������
			--/CaseDto	HistoryNumber	 	1..1	String	����� ������� �������/ ������������� ������
			,MOT.MOTCONSU_EV_ID AS HistoryNumber
			--/CaseDto	IdCaseMis	 	1..1	String	������������� ������ � ���������� ���
			,MOT.MOTCONSU_ID AS IdCaseMis --�������� ID ��� ������ ������ ���������
			--/CaseDto	IdCaseAidType	 	0..1	unsignedByte	������������� ���� ������������ ������������ (OID �����������: 1.2.643.2.69.1.1.1.16) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/7/FilterTree
			,ETF.ED_TREATMENT_FORM_CODE AS IdCaseAidType
			--/CaseDto	IdPaymentType	 	1..1	unsignedByte	������������� ��������� �������������� (OID �����������: 1.2.643.2.69.1.1.1.32) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/25/FilterTree
			,'1' AS IdPaymentType -- ������ ������ ���. � ���������� ����������� �� ������������ � �������� ����������� ��������� ��������������
			--/CaseDto	Confidentiality	 	1..1	unsignedByte	������� ������������������ ������������ ���������� (OID �����������: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 'N'
				ELSE ELA.CODE END) AS Confidentiality -- �������� �� ������� ���� ������� ED_LEVEL_ACCESS ��� ��������� � ������ ������������ ������������������	
			--/CaseDto	DoctorConfidentiality	 	1..1	unsignedByte	������� ������������������ ������������ ���������� ��� ����� (OID �����������: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 'N'
				ELSE ELA.CODE END) AS DoctorConfidentiality -- ������ ���� ����� �� ��� ������� ED_LEVEL_ACCESS ��� ��������� � ������ ������������ ������������������
			--/CaseDto	CuratorConfidentiality	 	1..1	unsignedByte	������� ������������������ ������������ ���������� ��� ������������� ��������/������� (OID �����������: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 'N'
				ELSE ELA.CODE END) AS CuratorConfidentiality -- ������ ���� ����� �� ��� ������� ED_LEVEL_ACCESS ��� ��������� � ������ ������������ ������������������		
			--/CaseDto	IdLpu	 	1..1	guid	������������� ��
			,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu -- ������� ���� � ������� FM_ORG ��� �������� GUID MO (�������� ��������) ���� ����������� ������ �� OID ������������, �� ���� ������� ����������� ����� ������������ OID ���������
			--/CaseDto	IdCaseResult	 	1..1	unsignedByte	������������� ������ ����������� (OID �����������: 1.2.643.5.1.13.2.1.1.688) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/88/FilterTree ���������� �� ������������� ������. ��������� ������������� ����� ����������
			,DAPC.ED_OUTCOMES_ID as IdCaseResult
			--/CaseDto	Comment	 	1..1	String	����� ���������� �� �������� �/��� ������ ������ ����������� ���������� � ������������������� ����, ��������, ����� ������������ ���������
				--�� ��������, ��� ��� ���� ����������� ����� �������� ������,(convert (VARCHAR(8000), MOT.SEMD)) as Comment	-- ������� ���� ����������� ����� ��������� �������� ������ ������
				--������� ������ �� ����� ���. ����� ��������� �������� "������" ������ �� ����������� ������ MOTXML.FILLED_TABLES ��� ������ ������ ���������� �� ��������������� rtf ����� �������
			,MOT.EV_NAME AS Comment --������� ������� �� ������ ��� ����������� � ������
			--/CaseDto	IdPatientMis	 	1..1	String	������������� �������� � ���������� �������
			,PAT.KRN_GUID AS IdPatientMis
			--/CaseDto	IdCasePurpose	 	0..1	unsignedByte	������������� ���� ��������� (������������� ������� ��������� �� ����������� �������, OID �����������: 1.2.643.5.1.13.2.1.1.106)
			,(CASE WHEN DAPC.VID_PRIEMA = 1 OR DAPC.VID_PRIEMA = 20 THEN 1
					WHEN DAPC.VID_PRIEMA = 13 THEN 2
					WHEN DAPC.VID_PRIEMA = 11 THEN 3
					WHEN DAPC.VID_PRIEMA = 16 THEN 4 
					WHEN DAPC.VID_PRIEMA = 2 THEN 5 
					ELSE 12 END) as IdCasePurpose -- �������� �� ������� ED_RECEPTION_TYPE ����������, ��� ��� ����� �����������
			--/CaseDto	IdCaseType	 	1..1	unsignedByte	������������� ���� ������ ������������: ������������, ��������������� (OID �����������: 1.2.643.2.69.1.1.1.35)
			,(CASE WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 3 OR DAPC.ED_MED_PROVISION_CONDITIONS_ID = 4 THEN 2
					WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 1 THEN 3 END) as IdCaseType -- ������� ED_MEDPROVISION_CONDITIONS
			--/CaseDto	IdAmbResult	 	0..1	unsignedByte	��� ���������� ��������� (OID �����������: 1.2.643.2.69.1.1.1.17)
			,(CASE WHEN DAPC.ED_OUTCOMES_ID = 16 THEN 1
					WHEN DAPC.ED_OUTCOMES_ID = 3 THEN 2
					WHEN DAPC.ED_OUTCOMES_ID = 18 OR DAPC.ED_OUTCOMES_ID = 2 OR DAPC.ED_OUTCOMES_ID = 4 OR DAPC.ED_OUTCOMES_ID = 5 THEN 3
					ELSE 17 END) as IdAmbResult -- ������� ED_OUTCOMES
			--/CaseDto	IsActive	 	0..1	Boolean	������� ������. ������� ���������������, ���� ������� ��� ��������� �� ���� � �����
			,'1' as IsActive -- ���� �������, ��� ��� �������� ���������� � �����, ����� ������ ���������
			--/CaseDto/DoctorInCharge	 	1..1	 	���������� � ������� ����� -------------------------------------
				--/DoctorInCharge	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����
				,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu -- ������� ���� � ������� FM_ORG ��� �������� GUID MO (�������� ��������) ���� ����������� ������ �� OID ������������, �� ���� ������� ����������� ����� ������������ OID ���������
				--/DoctorInCharge	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ����� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
				,SPEC.Nsi_specialisation_ID as IdSpeciality
				--/DoctorInCharge	IdPosition	 	1..1	unsignedShort	������������� ��������� ����� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
				,SPEC.DOLZGNOST as IdPosition -- �������� � ������� SPECIALISATION ����� ������� DOLZGNOST int, �������� ������������� �� ������������ 1.2.643.5.1.13.2.1.1.607 -- ������� ������ �� ���������� �������� � �������� � ��

				--/DoctorInCharge/Person	 	1..1	 	���������� � ������� (�����)
					--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
					--�� ������������, ����� �������� ��� ���� ������
					--/Person	BirthDate	 	0..1	Datetime	���� ��������
					--�� ������������, ����� ��������
					--/Person	IdPersonMis	 	1..1	String	������������� ����� � ���
					,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
						--/Person/HumanName	 	1..1	 	��� �����
							--/HumanName	FamilyName	 	1..1	String	������� �����
							,(select ltrim(rtrim(MED.NOM))) AS FamilyName
							--/HumanName	GivenName	 	1..1	String	��� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
							--/HumanName	MiddleName	 	0..1	String	�������� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
							,'223' as IdDocumentType -- ��� ��������� - �����
							--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
							,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
							--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
							,'���' as ProviderName -- �����������, �������� ��������
			--/CaseDto/Authenticator	 	1..1	 	����, ������������� ��� ���������� ����������� ����� ����������� ����������
				--/Authenticator	IdRole	 	0..1	unsignedByte	���� � �������� ������ (OID �����������: 1.2.643.5.1.13.2.7.1.30) �� ������������ http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/92/FilterTree
					,'3' AS IdRole -- �������, ��� �������� "����"
					--/Authenticator/Doctor	 	1..1	 	���������� � ����������� ���������
						--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����������� ��������
						,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
						--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ������������ ��������� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
						,SPEC.Nsi_specialisation_ID as IdSpeciality
						--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ������������ ��������� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
						,SPEC.DOLZGNOST as IdPosition
							--/Doctor/Person	 	1..1	 	���������� � ������� --�� ������������
								--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156) --�� ������������
								--/Person	BirthDate	 	0..1	Datetime	���� �������� --�� ������������
								--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
								,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
								--/Person/HumanName	 	1..1	 	��� ������������ ���������
									--/HumanName	FamilyName	 	1..1	String	������� ������������ ���������
									,(select ltrim(rtrim(MED.NOM))) AS FamilyName
									--/HumanName	GivenName	 	1..1	String	��� ������������ ���������
									,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
									--/HumanName	MiddleName	 	0..1	String	�������� ������������ ���������
									,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
								--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ������������ ��������� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
									--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
									,'223' as IdDocumentType -- ��� ��������� - �����
									--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
									,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
									--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
									,'���' as ProviderName -- �����������, �������� ��������
			--/CaseDto/Author	 	1..1	 	����, ���������� ������� ������������� ������ ����������� ���������� (��� �������, ������� ����)
				--/Author	IdRole	 	0..1	unsignedByte	���� � �������� ������ (OID �����������: 1.2.643.5.1.13.2.7.1.30)
				,'4' AS IdRole -- �������� �������� "������� ����"
				--/Author/Doctor	 	1..1	 	���������� � ����������� ���������
					--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����������� ��������
					,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ������������ ��������� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as IdSpeciality
					--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ������������ ��������� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as IdPosition
				--/Doctor/Person	 	1..1	 	���������� � �������
					--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156) --�� ������������
					--/Person	BirthDate	 	0..1	Datetime	���� �������� --�� ������������
					--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
					--/Person/HumanName	 	1..1	 	��� ������������ ���������
						--/HumanName	FamilyName	 	1..1	String	������� ������������ ���������
						,(select ltrim(rtrim(MED.NOM))) AS FamilyName
						--/HumanName	GivenName	 	1..1	String	��� ������������ ���������
						,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
						--/HumanName	MiddleName	 	0..1	String	�������� ������������ ���������
						,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
					--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ������������ ��������� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
						--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
						,'223' as IdDocumentType -- ��� ��������� - �����
						--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
						,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
						--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
						,'���' as ProviderName -- �����������, �������� ��������	
			--/CaseDto/LegalAuthenticator	 	0..1	 	� �������� ����������� ���������� � ����, ����������� ���������� � ������ ������������ (������� ����������� ���������������)
				--/LegalAuthenticator	IdRole	 	0..1	unsignedByte	���� � �������� ������ (OID �����������: 1.2.643.5.1.13.2.7.1.30)
				,'4' AS IdRole -- ����� "������� ����"
				--/LegalAuthenticator/Doctor	 	1..1	 	���������� � ����������� ���������
					--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����������� ��������
					,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ������������ ��������� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as IdSpeciality
					--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ������������ ��������� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as IdPosition
					--/Doctor/Person	 	1..1	 	���������� � �������
						--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	���� ��������
						--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
						,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
						--/Person/HumanName	 	1..1	 	��� ������������ ���������
							--/HumanName	FamilyName	 	1..1	String	������� ������������ ���������
							,(select ltrim(rtrim(MED.NOM))) AS FamilyName
							--/HumanName	GivenName	 	1..1	String	��� ������������ ���������
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
							--/HumanName	MiddleName	 	0..1	String	�������� ������������ ���������
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ������������ ��������� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
							,'223' as IdDocumentType -- ��� ��������� - �����
							--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
							,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
							--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
							,'���' as ProviderName -- �����������, �������� ��������	
			--/CaseDto/Guardian	 	0..1	 	���������� � ������ ��������� ������ (��������/ �������)
				-- �������� ������� ��� ���������, � ������� ���� �������� �������������
				--/Guardian	IdRelationType	 	1..1	unsignedByte	��� ��������� � �������� (���������� ��������� � ��������, OID 1.2.643.5.1.13.2.7.1.15)
				--/Guardian	UnderlyingDocument	 	1..1	String	��������� ���������, �������������� ����� ������������ ��������
				--/Guardian/Person	 	1..1	 	���������� � �������
					--/Person	Sex	 	1..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
					--/Person	BirthDate	 	1..1	Datetime	���� ��������
					--/Person	IdPersonMis	 	1..1	String	������������� ������� ��������� ������ � ���
					--/Person/HumanName	 	1..1	 	��� ������� ��������� ������ (��������/ �������)
						--/HumanName	FamilyName	 	1..1	String	�������
						--/HumanName	GivenName	 	1..1	String	���
						--/HumanName	MiddleName	 	0..1	String	��������
					--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ������� ��������� ������ (������ ����������� ���������� ���������� ��������)
						--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
						--,'223' as IdDocumentType -- ��� ��������� - �����
						--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
						--,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
						--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
						--,'���' as ProviderName -- �����������, �������� ��������	
			--/CaseDto/Steps/StepAmb	 	1..*	 	���������� �� ������� ������ ������������ ������������
				-- ������ ������ ������� ������
				--/StepAmb	DateStart	 	1..1	Datetime	���� ������ �������
				,(cast (MOT.DATE_CONSULTATION as Date)) AS DateStart --����� ���� ��� �������, �� ������� ����������� ������������
				--/StepAmb	DateEnd	 	1..1	Datetime	���� ��������� �������
				,(cast (MOT.DATE_CONSULTATION as Date)) AS DateEnd --����� �� �� ����, ��� ��� ��� ������ ������������ � ����������� - �����
				--/StepAmb	Comment	 	0..1	String	�����������
				,(CAST(convert(DATE, MOT.DATE_CONSULTATION, 104) as varchar) + ' / ' + MOT.REC_NAME ) AS Comment --������� ���� ������������ � ���������
				--/StepAmb	IdStepMis	 	1..1	String	������������� ������� ������ ������������ ������������ � ���������� ���
				,MOT.MOTCONSU_ID AS IdStepMis
				--/StepAmb	IdPaymentType	 	0..1	unsignedByte	������������� ��������� �������������� (OID �����������: 1.2.643.2.69.1.1.1.32)
				,'1' AS IdPaymentType -- ������ ������ ���. � ���������� ����������� �� ������������ � �������� ����������� ��������� ��������������
				--/StepAmb	IdVisitPlace	 	1..1	unsignedByte	������������� ����� ��������� (������������� ���� ������������, OID �����������: 1.2.643.2.69.1.1.1.18) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/9/FilterTree
				,(CASE WHEN DMB.ED_RECEPTION_PLACE_ID = 1 THEN 1
						WHEN DMB.ED_RECEPTION_PLACE_ID = 2 THEN 2
						WHEN DMB.ED_RECEPTION_PLACE_ID = 3 THEN 4
						WHEN DMB.ED_RECEPTION_PLACE_ID = 4 THEN 3
						WHEN DMB.ED_RECEPTION_PLACE_ID = 5 THEN 5
						ELSE 6 END) as IdVisitPlace
				--/StepAmb	IdVisitPurpose	 	1..1	unsignedByte	������������� ���� ��������� (������������� ����� ��������� �����������-��������������� �����������, OID �����������: 1.2.643.2.69.1.1.1.19) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/10/FilterTree
				,'1' as IdVisitPurpose --���� ���� �������-���������������, ����� ����� ��������� �� ���������
				--/StepAmb/Doctor	 	1..1	 	���������� � �����
					--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����
					,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ����� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as IdSpeciality
					--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ����� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as IdPosition
					--/Doctor/Person	 	1..1	 	���������� � �������
						--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	���� ��������
						--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
						,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
						--/Person/HumanName	 	1..1	 	��� �����
							--/HumanName	FamilyName	 	1..1	String	������� �����
							,(select ltrim(rtrim(MED.NOM))) AS FamilyName
							--/HumanName	GivenName	 	1..1	String	��� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
							--/HumanName	MiddleName	 	0..1	String	�������� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
							,'223' as IdDocumentType -- ��� ��������� - �����
							--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
							,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
							--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
							,'���' as ProviderName -- �����������, �������� ��������	
-- ������� ������ � �������� � ���� �������� �� ����������� ������
			--/StepAmb/MedRecords	 	0..1	 	������ MedRecord, ��������� ��� ������� ������������� ������ ������������
			-- ����� � ��������� �������
			--/CaseDto/MedRecords	 	1..1	 	������ MedRecord, ��������� ��� ������������� ������ ������������

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
	MOT.PUBLISHED = 1 -- �������� ������ �������������� ������
	AND MOT.REC_STATUS = 'A' -- �������� ������ ����������� ������ ������
	AND MOT.MOTCONSU_ID = MOT.MOTCONSU_EV_ID -- �������� ������, ����������� ������� ���� ��������� ������ ��� ������ ������
	--and MOT.CHANGED <> 1 --��������� ������ �� ������������ �����, ��� ��� ��������� ����� "�����������" ��� ����� ��������� �����
	--and MOT.SEMD is not null -- ������� ������ ������ � ������� ��������� ���� Comment �� ������� ���� (����������� ����� �������� ������)
ORDER BY MOT.MOTCONSU_ID DESC -- ��� �������� �������, ����� ����� ������


END


GO


