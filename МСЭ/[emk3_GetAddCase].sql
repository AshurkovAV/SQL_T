ALTER PROCEDURE [dbo].[emk3_GetAddCase] 
@dateStart NVARCHAR(8), 
@dateEnd NVARCHAR(8),
@flag INT, -- 0 ����������, 1 ����������, 2 �� ����� ������
@IdCaseMic NVARCHAR(36) = NULL
AS
BEGIN

	--exec [emk3_GetAddCase] '20190201', '20190228'
	
			/*������ �� ����� ������������ ������ ������������� ������������
			��� ������������ ���� N3.���������������
			�� 10.10.2018
			�����: ��������� �.*/
		--��������� 13.02.2019 � IdPosition �������� ��������� spec.DOLZGNOST �� SPEC.DOLZGNOST
		--��������� ashur 28.03.2020  IdCaseResult IdAmbResult
		--��������� ashur 30.09.2020 ������� idLpu �������������
		--������� ashur 13.04.2021 ������� AND mot.MEDDEP_ID = m.MEDDEP_ID

		-- ���������� ������� ��� ������ � ������ ������ ���� �� ���� ������ ������ �� ��������� �������
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
	--/	guid	 	1..1	GUID	��������������� ����� --------------------------------------------------------------
		--������� ����� GUID 
	--/CaseAmb ---------------------------------------------------------------------------------------------------------
		--/CaseDto	 	1..1	 	���������� � ������ ������������ ������������. ��� �������� xsi:type ����������� CaseAmb
			SELECT 
			--top 100
			--/CaseDto	OpenDate	 	1..1	Datetime	���� �������� ������
			( cast((select TOP 1 SVOD.DATE_CONSULTATION from (select MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE from MOTCONSU where EV_DATE_CLOSE is not null
			group by MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE) SVOD where SVOD.MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID) as date )) AS OpenDate -- ���, ������, ��� �� ���������� ������������ � ������� �������� �������� � �������� ������, � �� �������
			--/Cas�Dto	CloseDate	 	1..1	Datetime	���� �������� ������
			,( cast((select TOP 1 SVOD.EV_DATE_CLOSE from (select MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE from MOTCONSU where EV_DATE_CLOSE is not null
			group by MOTCONSU_EV_ID, motconsu_id, DATE_CONSULTATION, EV_DATE_CLOSE) SVOD where SVOD.MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID) as date )) AS CloseDate -- ���, ������, ��� �� ���������� ������������ � ������� �������� �������� � �������� ������, � �� �������
			--/CaseDto	HistoryNumber	 	1..1	String	����� ������� �������/ ������������� ������
			,MOT.MOTCONSU_EV_ID AS HistoryNumber
			--/CaseDto	IdCaseMis	 	1..1	String	������������� ������ � ���������� ���
			,MOT.MOTCONSU_EV_ID AS IdCaseMis		
			,MOT.MOTCONSU_ID --��� ���������� ������	
			--/CaseDto	IdCaseAidType	 	0..1	unsignedByte	������������� ���� ������������ ������������ (OID �����������: 1.2.643.2.69.1.1.1.16) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/7/FilterTree
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
			--/CaseDto	IdPaymentType	 	1..1	unsignedByte	������������� ��������� �������������� (OID �����������: 1.2.643.2.69.1.1.1.32) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/25/FilterTree
			,1 AS IdPaymentType -- ������ ������ ���. � ���������� ����������� �� ������������ � �������� ����������� ��������� ��������������
			--/CaseDto	Confidentiality	 	1..1	unsignedByte	������� ������������������ ������������ ���������� (OID �����������: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			--,ELA.CODE 
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 2
				ELSE ELA.CODE END) AS Confidentiality -- �������� �� ������� ���� ������� ED_LEVEL_ACCESS ��� ��������� � ������ ������������ ������������������	
			--/CaseDto	DoctorConfidentiality	 	1..1	unsignedByte	������� ������������������ ������������ ���������� ��� ����� (OID �����������: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 2
				ELSE ELA.CODE END) AS DoctorConfidentiality -- ������ ���� ����� �� ��� ������� ED_LEVEL_ACCESS ��� ��������� � ������ ������������ ������������������
			--/CaseDto	CuratorConfidentiality	 	1..1	unsignedByte	������� ������������������ ������������ ���������� ��� ������������� ��������/������� (OID �����������: 1.2.643.5.1.13.2.7.1.9) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/96/FilterTree
			,(CASE WHEN ISNULL(ELA.CODE, '') = '' THEN 2
				ELSE ELA.CODE END) AS CuratorConfidentiality -- ������ ���� ����� �� ��� ������� ED_LEVEL_ACCESS ��� ��������� � ������ ������������ ������������������		
			--/CaseDto	IdLpu	 	1..1	guid	������������� ��
			,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu -- ������� ���� � ������� FM_ORG ��� �������� GUID MO (�������� ��������) ���� ����������� ������ �� OID ������������, �� ���� ������� ����������� ����� ������������ OID ���������
			--/CaseDto	IdCaseResult	 	1..1	unsignedByte	������������� ������ ����������� (OID �����������: 1.2.643.5.1.13.2.1.1.688) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/88/FilterTree ���������� �� ������������� ������. ��������� ������������� ����� ����������
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
			--/CaseDto	Comment	 	1..1	String	����� ���������� �� �������� �/��� ������ ������ ����������� ���������� � ������������������� ����, ��������, ����� ������������ ���������
			--,(convert (VARCHAR(8000), MOT.SEMD)) as Comment	-- ������� ���� ����������� ����� ��������� �������� ������ ������
			,MOT.REC_NAME AS [Comment] --��������� ������� �. 20102018 ��� ������������ �������� ������
			--/CaseDto	IdPatientMis	 	1..1	String	������������� �������� � ���������� �������
			,PAT.KRN_GUID AS IdPatientMis
			--/CaseDto	IdCasePurpose	 	0..1	unsignedByte	������������� ���� ��������� (������������� ������� ��������� �� ����������� �������, OID �����������: 1.2.643.5.1.13.2.1.1.106)
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
        END) as IdCasePurpose -- �������� �� ������� ED_RECEPTION_TYPE ����������, ��� ��� ����� �����������
			--/CaseDto	IdCaseType	 	1..1	unsignedByte	������������� ���� ������ ������������: ������������, ��������������� (OID �����������: 1.2.643.2.69.1.1.1.35)
			,(CASE WHEN ISNULL(DAPC.OMS_V006_ID, '') != ''
      THEN
			(CASE WHEN DAPC.OMS_V006_ID = 3 OR DAPC.OMS_V006_ID = 4 THEN 2
					WHEN DAPC.OMS_V006_ID = 1 THEN 3 ELSE 2 END)
				ELSE
			(CASE WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 3 OR DAPC.ED_MED_PROVISION_CONDITIONS_ID = 4 THEN 2
					WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 1 THEN 3 ELSE 2 END)
				END)	as IdCaseType -- ������� ED_MEDPROVISION_CONDITIONS
			--/CaseDto	IdAmbResult	 	0..1	unsignedByte	��� ���������� ��������� (OID �����������: 1.2.643.2.69.1.1.1.17)
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
      END	as IdAmbResult -- ������� ED_OUTCOMES		
			--/CaseDto	IsActive	 	0..1	Boolean	������� ������. ������� ���������������, ���� ������� ��� ��������� �� ���� � �����
			,1 as IsActive -- ���� �������, ��� ��� �������� ���������� � �����, ����� ������ ���������
			--/CaseDto/DoctorInCharge	 	1..1	 	���������� � ������� ����� -------------------------------------
				--/DoctorInCharge	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����
				,fm.depart_oid AS [CaseDto_DoctorInCharge_IdLpu] -- ������� ���� � ������� FM_ORG ��� �������� GUID MO (�������� ��������) ���� ����������� ������ �� OID ������������, �� ���� ������� ����������� ����� ������������ OID ���������
				--/DoctorInCharge	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ����� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
				,SPEC.Nsi_specialisation_ID as [CaseDto_DoctorInCharge_IdSpeciality]
				--/DoctorInCharge	IdPosition	 	1..1	unsignedShort	������������� ��������� ����� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
				,SPEC.DOLZGNOST as [CaseDto_DoctorInCharge_IdPosition] -- �������� � ������� SPECIALISATION ����� ������� DOLZGNOST int, �������� ������������� �� ������������ 1.2.643.5.1.13.2.1.1.607 -- ������� ������ �� ���������� �������� � �������� � ��

				--/DoctorInCharge/Person	 	1..1	 	���������� � ������� (�����)
					--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
					--�� ������������, ����� �������� ��� ���� ������
					--/Person	BirthDate	 	0..1	Datetime	���� ��������
					,med.DATA_ROGDENIQ  [DoctorInCharge_Person_BirthDate]
					--�� ������������, ����� ��������
					--/Person	IdPersonMis	 	1..1	String	������������� ����� � ���
					,MED.KRN_GUID as [DoctorInCharge_Person_IdPersonMis] -- ��������� ������������ GUID, ����� � MEDECINS_ID
						--/Person/HumanName	 	1..1	 	��� �����
							--/HumanName	FamilyName	 	1..1	String	������� �����
							,(select ltrim(rtrim(MED.NOM))) AS [Person_HumanName_FamilyName]
							--/HumanName	GivenName	 	1..1	String	��� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [Person_HumanName_GivenName]
							--/HumanName	MiddleName	 	0..1	String	�������� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [Person_HumanName_MiddleName] --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
							,223 as [Person_Documents_IdentityDocument_IdDocumentType] -- ��� ��������� - �����
							--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
							,MED.SYS_SNILS as [Person_Documents_IdentityDocument_DocN] -- ����� ������ ������� ��� �������� � ����
							--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
							,'���' as [Person_Documents_IdentityDocument_ProviderName] -- �����������, �������� ��������
			--/CaseDto/Authenticator	 	1..1	 	����, ������������� ��� ���������� ����������� ����� ����������� ����������
				--/Authenticator	IdRole	 	0..1	unsignedByte	���� � �������� ������ (OID �����������: 1.2.643.5.1.13.2.7.1.30) �� ������������
					--/Authenticator/Doctor	 	1..1	 	���������� � ����������� ���������
						--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����������� ��������
						,--(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) 
						fm.depart_oid AS [Authenticator_Doctor_IdLpu]
						--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ������������ ��������� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
						,SPEC.Nsi_specialisation_ID as [Authenticator_Doctor_IdSpeciality]
						--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ������������ ��������� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
						,SPEC.DOLZGNOST as [Authenticator_Doctor_IdPosition]
							--/Doctor/Person	 	1..1	 	���������� � ������� --�� ������������
								--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156) --�� ������������
								--/Person	BirthDate	 	0..1	Datetime	���� �������� --�� ������������
								,med.DATA_ROGDENIQ [Doctor_Person_BirthDate]
								--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
								,MED.KRN_GUID as [Doctor_Person_IdPersonMis] -- ��������� ������������ GUID, ����� � MEDECINS_ID
								--/Person/HumanName	 	1..1	 	��� ������������ ���������
									--/HumanName	FamilyName	 	1..1	String	������� ������������ ���������
									,(select ltrim(rtrim(MED.NOM))) AS [Doctor_Person_HumanName_FamilyName]
									--/HumanName	GivenName	 	1..1	String	��� ������������ ���������
									,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [Doctor_Person_HumanName_GivenName]
									--/HumanName	MiddleName	 	0..1	String	�������� ������������ ���������
									,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [Doctor_Person_HumanName_MiddleName] --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
								--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ������������ ��������� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
									--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
									,223 as [Doctor_Person_Documents_IdentityDocument_IdDocumentType] -- ��� ��������� - �����
									--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
									,MED.SYS_SNILS as [Doctor_Person_Documents_IdentityDocument_DocN] -- ����� ������ ������� ��� �������� � ����
									--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
									,'���' as [Doctor_Person_Documents_IdentityDocument_ProviderName] -- �����������, �������� ��������
			--/CaseDto/Author	 	1..1	 	����, ���������� ������� ������������� ������ ����������� ���������� (��� �������, ������� ����)
				--/Author	IdRole	 	0..1	unsignedByte	���� � �������� ������ (OID �����������: 1.2.643.5.1.13.2.7.1.30)
				,4 AS IdRole -- �������� �������� "������� ����"
				--/Author/Doctor	 	1..1	 	���������� � ����������� ���������
					--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����������� ��������
					,fm.depart_oid AS [Author_Doctor_IdLpu]
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ������������ ��������� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as [Author_Doctor_IdSpeciality]
					--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ������������ ��������� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as [Author_Doctor_IdPosition]
				--/Doctor/Person	 	1..1	 	���������� � �������
					--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156) --�� ������������
					--/Person	BirthDate	 	0..1	Datetime	���� �������� --�� ������������
					,med.DATA_ROGDENIQ  [Author_Doctor_Person_BirthDate]
					--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
					,MED.KRN_GUID as [Author_Doctor_Person_IdPersonMis] -- ��������� ������������ GUID, ����� � MEDECINS_ID
					--/Person/HumanName	 	1..1	 	��� ������������ ���������
						--/HumanName	FamilyName	 	1..1	String	������� ������������ ���������
						,(select ltrim(rtrim(MED.NOM))) AS [Author_Doctor_Person_HumanName_FamilyName]
						--/HumanName	GivenName	 	1..1	String	��� ������������ ���������
						,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [Author_Doctor_Person_HumanName_GivenName]
						--/HumanName	MiddleName	 	0..1	String	�������� ������������ ���������
						,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [Author_Doctor_Person_HumanName_MiddleName] --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
					--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ������������ ��������� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
						--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
						,223 as [Author_Doctor_Person_IdDocumentType] -- ��� ��������� - �����
						--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
						,MED.SYS_SNILS as [Author_Doctor_Person_DocN] -- ����� ������ ������� ��� �������� � ����
						--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
						,'���' as [Author_Doctor_Person_ProviderName] -- �����������, �������� ��������	
			--/CaseDto/LegalAuthenticator	 	0..1	 	� �������� ����������� ���������� � ����, ����������� ���������� � ������ ������������ (������� ����������� ���������������)
				--/LegalAuthenticator	IdRole	 	0..1	unsignedByte	���� � �������� ������ (OID �����������: 1.2.643.5.1.13.2.7.1.30)
				--/LegalAuthenticator/Doctor	 	1..1	 	���������� � ����������� ���������
					--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����������� ��������
					,fm.depart_oid AS [LegalAuthenticator_Doctor_IdLpu]
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ������������ ��������� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as [LegalAuthenticator_Doctor_IdSpeciality]
					--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ������������ ��������� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as [LegalAuthenticator_Doctor_IdPosition]
					--/Doctor/Person	 	1..1	 	���������� � �������
						--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	���� ��������
						,med.DATA_ROGDENIQ  [LegalAuthenticator_Doctor_Person_BirthDate]
						--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
						,MED.KRN_GUID as [LegalAuthenticator_Doctor_Person_IdPersonMis] -- ��������� ������������ GUID, ����� � MEDECINS_ID
						--/Person/HumanName	 	1..1	 	��� ������������ ���������
							--/HumanName	FamilyName	 	1..1	String	������� ������������ ���������
							,(select ltrim(rtrim(MED.NOM))) AS [LegalAuthenticator_Doctor_Person_FamilyName]
							--/HumanName	GivenName	 	1..1	String	��� ������������ ���������
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [LegalAuthenticator_Doctor_Person_GivenName]
							--/HumanName	MiddleName	 	0..1	String	�������� ������������ ���������
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [LegalAuthenticator_Doctor_Person_MiddleName] --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ������������ ��������� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
							,223 as [LegalAuthenticator_Doctor_Person_IdDocumentType] -- ��� ��������� - �����
							--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
							,MED.SYS_SNILS as [LegalAuthenticator_Doctor_Person_DocN] -- ����� ������ ������� ��� �������� � ����
							--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
							,'���' as [LegalAuthenticator_Doctor_Person_ProviderName] -- �����������, �������� ��������	
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
-------------/CaseDto/Steps/StepAmb	 	1..*	 	���������� �� ������� ������ ������������ ������������
				-- ���������� ������� ��� ������ � ������ ������ ���� �� ���� ������ ������

				--/StepAmb	DateStart	 	1..1	Datetime	���� ������ �������
				,MOT.DATE_CONSULTATION AS DateStart --����� ����, �� ������� ����������� ������������
				--/StepAmb	DateEnd	 	1..1	Datetime	���� ��������� �������
				,MOT.DATE_CONSULTATION AS DateEnd --����� �� �� ����, ��� ��� ��� ������ ������������ � ����������� - �����
				--/StepAmb	Comment	 	0..1	String	�����������
				,MOT.REC_NAME AS [Steps_Comment]
				--/StepAmb	IdStepMis	 	1..1	String	������������� ������� ������ ������������ ������������ � ���������� ���
				,MOT.MOTCONSU_ID AS IdStepMis
				--/StepAmb	IdPaymentType	 	0..1	unsignedByte	������������� ��������� �������������� (OID �����������: 1.2.643.2.69.1.1.1.32)
				,1 AS [Steps_IdPaymentType] -- ������ ������ ���. � ���������� ����������� �� ������������ � �������� ����������� ��������� ��������������
				--/StepAmb	IdVisitPlace	 	1..1	unsignedByte	������������� ����� ��������� (������������� ���� ������������, OID �����������: 1.2.643.2.69.1.1.1.18) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/9/FilterTree
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
				--/StepAmb	IdVisitPurpose	 	1..1	unsignedByte	������������� ���� ��������� (������������� ����� ��������� �����������-��������������� �����������, OID �����������: 1.2.643.2.69.1.1.1.19) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/10/FilterTree
				,1 as IdVisitPurpose --���� ���� �������-���������������, ����� ����� ��������� �� ���������
				--/StepAmb/Doctor	 	1..1	 	���������� � �����
					--/Doctor	IdLpu	 	0..1	guid	������������� ��, � �������� ��������� ����
					--/Doctor	IdSpeciality	 	1..1	unsignedShort	������������� ������������� ����� (������������ �������������� ������������ � ������ � �������������� ����������� � ���������������� ������������ � ����� ���������������, OID 1.2.643.5.1.13.2.1.1.181)
					,SPEC.Nsi_specialisation_ID as [StepAmb_Doctor_IdSpecialit]
					--/Doctor	IdPosition	 	1..1	unsignedShort	������������� ��������� ����� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
					,SPEC.DOLZGNOST as [StepAmb_Doctor_IdPosition]
					--/Doctor/Person	 	1..1	 	���������� � �������
						--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
						--/Person	BirthDate	 	0..1	Datetime	���� ��������
						,med.DATA_ROGDENIQ  [StepAmb_Doctor_BirthDate]
						--/Person	IdPersonMis	 	1..1	String	������������� ��������� ������ � ���
						,MED.KRN_GUID as [StepAmb_Doctor_IdPersonMis] -- ��������� ������������ GUID, ����� � MEDECINS_ID
						--/Person/HumanName	 	1..1	 	��� �����
							--/HumanName	FamilyName	 	1..1	String	������� �����
							,(select ltrim(rtrim(MED.NOM))) AS [StepAmb_Doctor_FamilyName]
							--/HumanName	GivenName	 	1..1	String	��� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [StepAmb_Doctor_GivenName]
							--/HumanName	MiddleName	 	0..1	String	�������� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [StepAmb_Doctor_MiddleName] --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
							,223 as [StepAmb_Doctor_IdDocumentType] -- ��� ��������� - �����
							--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
							,MED.SYS_SNILS as [StepAmb_Doctor_DocN] -- ����� ������ ������� ��� �������� � ����
							--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
							,'���' as [StepAmb_Doctor_ProviderName] -- �����������, �������� ��������	
							
	--/StepAmb/MedRecords	 	0..1	 	������ MedRecord, ��������� ��� ������� ������������� ������ ������������

--/CaseDto/MedRecords	 	1..1	 	������ MedRecord, ��������� ��� ������������� ������ ������������
--CaseVisitType 	1..1 	byte 	������� ��������� (OID �����������: 1.2.643.5.1.13.13.11.1007 ) 
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
		-- ������ ������� ��� �������, � ������� ������ 1 �����
		MOT.MOTCONSU_ID in (select MOTCONSU_ID FROM ( SELECT MOTCONSU_ID, MOTCONSU_EV_ID FROM MOTCONSU GROUP BY MOTCONSU_ID, MOTCONSU_EV_ID HAVING COUNT(*) = 1 ) E)
		-- ������ ������� ������ �� �������� ������� ���������
		and MOT.EV_CLOSE = 1 
		-- ������, ������� ��������� �������
		and MOT.ZAPIS_ZAKR_VAYHAQ_SOB_TIE = 1 
		-- �������� ������ �������������� ������
		--and MOT.PUBLISHED = 1 
		-- �������� ������ ����������� ������ ������
		--and MOT.REC_STATUS = 'A'
		--��������� ������ �� ������������ �����, ��� ��� ��������� ����� "�����������" ��� ����� ��������� �����
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


		--and MOT.SEMD is not null -- ������� ������ ������ � ������� ��������� ���� Comment �� ������� ���� (����������� ����� �������� ������)
ORDER BY MOT.MOTCONSU_ID DESC  -- ��� �������� �������, ����� ����� ������

END






GO


