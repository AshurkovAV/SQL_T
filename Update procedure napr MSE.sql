ALTER PROCEDURE [dbo].[emk3_AddMedRecordConsultNote]
@IdCaseMis INT
AS
BEGIN
	--exec [emk3_AddMedRecordConsultNote]
	
					/*������ �� ���������� ����������� ������ � ������ ������������
			��� ������������ ���� N3.���������������
			�� 10.10.2018
			�����: ��������� �.*/

--AddMedRecord------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	SELECT TOP 100
	--/guid	 	1..1	GUID	��������������� ����� --------------------------------------------------------------
		--������� ����� GUID 
	--/IdLpu	 	1..1	guid	������������� ��
	(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
	--/IdPatientMis	 	1..1	String	������������� �������� � ���������� �������
	,PAT.KRN_GUID as IdPatientMis
	,pat.PATIENTS_ID
	--/IdCaseMis	 	1..1	String	������������� ������ � ���������� ���
	,MOT.MOTCONSU_ID AS IdCaseMis
		--/medRecord	 	1..1	 	����������� ������. ��� �������� xsi:type ����������� ��������������� ��� ������������ �������. �������� ����� ������� ��������� � ������� "��� MedRecord"
					--/ConsultNote
						--CreationDate	1..1	dateTime	���� �������� ���������
						,(cast(MOT.DATE_CONSULTATION as DATE)) as CreationDate
						--FhirMedDocumentType	0..0	string	������������� ���� ��������� (�� ������������ ��� �������� ������)
						--IdDocumentMis	0..1	string	������������� ��������� � �������-��������� (���)
						
						--IdMedDocument	0..0	int	������������� ��������� � �� (�� ������������ ��� �������� ������)
						--Attachment	0..1	DocumentAttachment	������������������� (��������) ���������� ���������
							--DocumentAttachment
							--Data	0..1	base64Binary	C�������� SignData � ������� base64binary
								--SignData ���� ���������� ������������� ��������, �� ���� PublicKey, Hash � Sign �� �����������.
									--Data	1..1	Base64binary	������ �������� (�����, pdf, html,xml) � ������� base64binary
									,MOT.REMD_BodyPreparedReport as Base64binary
									,MOT.REMD_ECP_SIGN_DATA_ORG as OrganizationSign
									,MOT.REMD_ECP_SIGN_DATA as PersonalSigns
														--,(select cast(N'' as xml).value('xs:base64Binary(sql:column("plain_text"))', 'varchar(max)') as [encoded_value] 
														--	from (select cast(((CASE WHEN isnull(DOC.Description, '') = '' 
														--							THEN '����������� �������� ' + convert(varchar(19), MOT.DATE_CONSULTATION, 121) 
														--							ELSE 
														--							CAST(MOT.SEMD as varchar(max)) 
														--							END)) as varbinary(max)) as [plain_text]) as tmp) as Base64binary -- ���������, ��� ������� ���� ������ � �����
									--PublicKey	0..1	String	��������� ���� ����������� ���
									--Hash	0..1	String	���-����� ������. ������ ���-����� ������������ �� ��������� ���� � 34.10-2012 (���� � 34.10-2001). �������� ���-����� ������ ��������������� ������, ������������ � �������� Data � ������� base64binary
									--Sign	0..1	String	��� �� ���� � 34.10-2012 (���� � 34.10-2001)
								--SignData
							--Hash	0..1	base64Binary	��� ������ (�� ������������ ��� �������� � ������)
							--MimeType	�������-���������� (���� �������� Data ��������)	string --MIME-��� ������ �����-��������, ������������ � �������� Data ��������� SignData. �������������� MIME-����: text/html � HTML; text/plain � �����; application/pdf � PDF; text/xml � XML.
							,'application/pdf' AS MimeType
							--Url	0..1	anyURI	����� (������), ��� ��������� ������ (���������� ��������).
								,VD.PHYSICAL_PATH + '\' + LET.FOLDER + '\' + LET.FileName AS Url	-- ����� �������� � ����������� ��� ������� ������ ������ �� ��������... ���� ����� ����� �� MOTCONSU_XML
						--Author	1..1	MedicalStaff	�������� � ����, ��������� ��������
							--Person	0..1	PersonWithIdentity	�������� � � �������� ������������ ���������
								--/Person/HumanName	 	1..1	 	��� �����
									--/HumanName	FamilyName	 	1..1	String	������� �����
									,(select ltrim(rtrim(MED.NOM))) AS FamilyName
									--/HumanName	GivenName	 	1..1	String	��� �����
									,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
									--/HumanName	MiddleName	 	0..1	String	�������� �����
									,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
								--/Person	IdPersonMis	 	1..1	String	������������� ����� � ���
								,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
								--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
									--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
									,223 as IdDocumentType -- ��� ��������� - �����
									--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
									,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
									--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
									,'���' as ProviderName -- �����������, �������� ��������
							--Person
							--IdLpu	0..1	string	������������� ��
							,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
							--IdSpeciality	1..1	unsignedShort	������������� ������������� ������������ ���������
							,SPEC.Nsi_specialisation_ID as IdSpeciality
							--IdPosition	1..1	unsignedShort	������������� ��������� ������������ ���������
							,SPEC.DOLZGNOST as IdPosition
						
						--Header	1..1	string	��������� ��������� (������� ��������)
						,(CASE WHEN isnull(DOC.Description, '') = '' THEN '����������� �������� ' + convert(varchar(19), MOT.DATE_CONSULTATION, 121) ELSE DOC.Description END) AS Header
					
FROM MOTCONSU MOT with (nolock)
LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
--LEFT JOIN ED_TREATMENT_FORM ETF ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID
--LEFT JOIN ED_LEVEL_ACCESS ELA ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD
LEFT JOIN PATIENTS PAT on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
--LEFT JOIN DATA_MOTCONSU_BILLDET DMB on DMB.MOTCONSU_ID = MOT.MOTCONSU_ID
--LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOT.MOTCONSU_ID
--LEFT JOIN CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
--LEFT JOIN MOTCONSU_XML MOTXML on MOTXML.MOTCONSU_ID = MOT.MOTCONSU_ID 
LEFT JOIN LETTERS DOC ON DOC.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_GENERAL_EXAM DGE ON DGE.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN (SELECT * FROM LETTERS WHERE D_Type = 1) LET ON LET.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN VIRTUAL_DISKS VD ON VD.VIRTUAL_DISKS_ID = LET.VIRTUAL_DISKS_ID

where 
--��� ��� ����� � ���, ��� � �� ����� �� ����������� � �� ���������� ��� ���������....
--MOT.PUBLISHED = 1 -- �������� ������ �������������� ������
--and MOT.REC_STATUS = 'A' -- �������� ������ ����������� ������ ������


--and MOT.CHANGED <> 1 --��������� ������ �� ������������ �����, ��� ��� ��������� ����� "�����������" ��� ����� ��������� �����
--and MOT.MOTCONSU_ID <> MOT.MOTCONSU_EV_ID -- �������� ������, ������� �� ��������� �������, � ������� � ������ ������������ ������
--and MOT.ZAPIS_ZAKR_VAYHAQ_SOB_TIE <> 1 -- ��� �� ������ ���� ��������� ������, ������������ �������, ��� ��� ��� ����� �������� � CloseCase
--AND
 MOT.MOTCONSU_ID = @IdCaseMis
ORDER BY MOT.MOTCONSU_ID DESC -- ��� �������� �������, ����� ����� ������
END

GO





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
		--��������� ashur 17.11.2021 � IdPosition �������� ��������� spec.DOLZGNOST �� SPEC.CODE_NSI_DOLZGNOST (������� �� iemk 5)
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
				,SPEC.CODE_NSI_DOLZGNOST as [CaseDto_DoctorInCharge_IdPosition] -- �������� � ������� SPECIALISATION ����� ������� DOLZGNOST int, �������� ������������� �� ������������ 1.2.643.5.1.13.2.1.1.607 -- ������� ������ �� ���������� �������� � �������� � ��

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
						,SPEC.CODE_NSI_DOLZGNOST as [Authenticator_Doctor_IdPosition]
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
					,SPEC.CODE_NSI_DOLZGNOST as [Author_Doctor_IdPosition]
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
					,SPEC.CODE_NSI_DOLZGNOST as [LegalAuthenticator_Doctor_IdPosition]
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
					,SPEC.CODE_NSI_DOLZGNOST as [StepAmb_Doctor_IdPosition]
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






ALTER PROCEDURE [dbo].[emk3_GetAddMedRecordDiagnosisInfo]
@IdCaseMis INT
AS
BEGIN
	--exec emk3_GetAddMedRecordDiagnosisInfo
	
			/*������ �� ���������� ����������� ������ � ������ ������������
			��� ������������ ���� N3.���������������
			�� 10.10.2018
			�����: ��������� �.*/

--AddMedRecord------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	SELECT TOP 100
	--/guid	 	1..1	GUID	��������������� ����� --------------------------------------------------------------
		--������� ����� GUID 
	--/IdLpu	 	1..1	guid	������������� ��
	(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
	--/IdPatientMis	 	1..1	String	������������� �������� � ���������� �������
	,PAT.KRN_GUID as IdPatientMis
	--/IdCaseMis	 	1..1	String	������������� ������ � ���������� ���
	,MOT.MOTCONSU_ID AS IdCaseMis
		--/medRecord	 	1..1	 	����������� ������. ��� �������� xsi:type ����������� ��������������� ��� ������������ �������. �������� ����� ������� ��������� � ������� "��� MedRecord"
					--/DiagnosisInfo	1..1	DiagnosisInfo	�������
						--IdDiseaseType	0..1	unsignedByte	������������� ���������� ����������� (���������� OID: 1.2.643.2.69.1.1.1.8)
						--DiagnosedDate	1..1	Datetime	���� ���������� ��������
						,(cast(DD.DATE_CONSULTATION as DATE)) as DiagnosedDate
						--IdDiagnosisType	1..1	unsignedByte	������������� ������� �������� (��������� OID: 1.2.643.2.69.1.1.1.26)
						,1 AS IdDiagnosisType -- ��� ���� ���� ����� ��������
						--Comment	1..1	String	����������� � ��������
						,MKB.DESCRIPTION AS Comment
						--DiagnosisChangeReason	0..1	unsignedByte	������� ��������� �������� (��� ����� ������������������� ��������) (���������� OID: 1.2.643.2.69.1.1.1.9)
						--DiagnosisStage	0..1	unsignedByte	������������� ����� ������������ �������� (���������� OID: 1.2.643.2.69.1.1.1.10)
						--IdDispensaryState	0..1	unsignedByte	������������� ��������� ������������� ����� �� ������� �������� (�����������) (���������� OID: 1.2.643.2.69.1.1.1.11)
						--IdTraumaType	0..1	unsignedByte	������������� ���� ����� (���������� OID: 1.2.643.2.69.1.1.1.12)
						--MESImplementationFeature	0..1	unsignedByte	������������� ����������� ���������� ��������� (���������� OID: 1.2.643.2.69.1.1.1.13)
						--MedicalStandard	0..1	int	��� ��������� ����� �������� ����������� ������ (���������� OID: 1.2.643.2.69.1.1.1.29
						--MkbCode	1..1	String	��� ����������� �� ���-10 (���������� OID: 1.2.643.2.69.1.1.1.2)
						,MKB.CODE AS MkbCode
					--/DiagnosisInfo 
				--/Doctor	1..1	MedicalStaff	�������� � ����������� ���������
						--Person	0..1	PersonWithIdentity	�������� � � �������� ������������ ���������
							--/Person/HumanName	 	1..1	 	��� �����
								--/HumanName	FamilyName	 	1..1	String	������� �����
								,(select ltrim(rtrim(MED.NOM))) AS FamilyName
								--/HumanName	GivenName	 	1..1	String	��� �����
								,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
								--/HumanName	MiddleName	 	0..1	String	�������� �����
								,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
							,med.DATA_ROGDENIQ  [BirthDate]
							--/Person	IdPersonMis	 	1..1	String	������������� ����� � ���
							,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
							--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
								--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
								,223 as IdDocumentType -- ��� ��������� - �����
								--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
								,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
								--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
								,'���' as ProviderName -- �����������, �������� ��������
					--IdLpu	0..1	string	������������� ��
					,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
					--IdSpeciality	1..1	unsignedShort	������������� ������������� ������������ ���������
					,SPEC.Nsi_specialisation_ID as IdSpeciality
					--IdPosition	1..1	unsignedShort	������������� ��������� ������������ ���������
					,SPEC.DOLZGNOST as IdPosition
				--/Doctor
	
	
FROM MOTCONSU MOT with (nolock)
LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
--LEFT JOIN ED_TREATMENT_FORM ETF ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID
--LEFT JOIN ED_LEVEL_ACCESS ELA ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD
LEFT JOIN PATIENTS PAT on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
LEFT JOIN DATA_MOTCONSU_BILLDET DMB on DMB.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
--LEFT JOIN MOTCONSU_XML MOTXML on MOTXML.MOTCONSU_ID = MOT.MOTCONSU_ID 

where 
--MOT.PUBLISHED = 1 -- �������� ������ �������������� ������
--and MOT.REC_STATUS = 'A' -- �������� ������ ����������� ������ ������
--AND 
MOT.MOTCONSU_ID = @IdCaseMis
--and MOT.CHANGED <> 1 --��������� ������ �� ������������ �����, ��� ��� ��������� ����� "�����������" ��� ����� ��������� �����
--and MOT.MOTCONSU_ID <> MOT.MOTCONSU_EV_ID -- �������� ������, ������� �� ��������� �������, � ������� � ������ ������������ ������
--and MOT.ZAPIS_ZAKR_VAYHAQ_SOB_TIE <> 1 -- ��� �� ������ ���� ��������� ������, ������������ �������, ��� ��� ��� ����� �������� � CloseCase

ORDER BY MOT.MOTCONSU_ID DESC -- ��� �������� �������, ����� ����� ������
END


GO





ALTER PROCEDURE [dbo].[emk3_GetAddMedRecordService]
@IdCaseMis INT
AS
BEGIN
	--exec [emk3_GetAddMedRecordService]
	
					/*������ �� ���������� ����������� ������ � ������ ������������
			���������� ������
			��� ������������ ���� N3.���������������
			�� 10.10.2018
			�����: ��������� �.*/

--AddMedRecord------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	SELECT TOP 100
	--/guid	 	1..1	GUID	��������������� ����� --------------------------------------------------------------
		--������� ����� GUID 
	--/IdLpu	 	1..1	guid	������������� ��
	(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
	--/IdPatientMis	 	1..1	String	������������� �������� � ���������� �������
	,PAT.KRN_GUID as IdPatientMis
	--/IdCaseMis	 	1..1	String	������������� ������ � ���������� ���
	,MOT.MOTCONSU_ID AS IdCaseMis
		--/medRecord	 	1..1	 	����������� ������. ��� �������� xsi:type ����������� ��������������� ��� ������������ �������. �������� ����� ������� ��������� � ������� "��� MedRecord"
					--/Service 1..1 ����������� ��� Service ������������ ��� �������� ������ � ����������� (���������) ������� � ������ ������� ������ ������������.
						--DateEnd	1..1	dateTime	���� ��������� �������� ������
						,cast(DMB.DATE_CONSULTATION as DATE) as DateEnd
						--DateStart	1..1	dateTime	���� ������ �������� ������
						,cast(DMB.DATE_CONSULTATION as DATE) as DateStart
						--IdServiceType	1..1	string	��� ������ �� ������������ ������������(���������� OID: 1.2.643.2.69.1.1.1.88)
						,SERV.MINZDRAV_CODE as IdServiceType -- ���� ���� ���� ����, ����� ���������, ��� ����������� �� ��� ��������� ���� "�..�����" ������������ ������������
						--PaymentInfo	0..1	PaymentInfo	���������� �� ������ ������
							--HealthCareUnit	1..1	unsignedByte	������������� ������� ����� ����������� ������ (���������� OID: 1.2.643.5.1.13.2.1.1.80)
							--IdPaymentType	1..1	unsignedByte	������������� ��������� �������������� (���������� OID: 1.2.643.5.1.13.2.1.1.104)
							--PaymentState	1..1	unsignedByte	������������� ������� ������ ������ (���������� OID: 1.2.643.5.1.13.2.7.1.41)
							--Quantity	1..1	int	���������� ����������� (���������) ����� ������� ����
							--Tariff	1..1	decimal	�������� � ������ (�������� ������ ���� ������ 0)
						--Performer	1..1	Participant	�������� �� ����������� ������
							--Doctor	0..1 (����������� ������ ��� Service)	MedicalStaff	������ ������������ ���������
										--/Doctor	1..1	MedicalStaff	�������� � ����������� ���������
											--Person	0..1	PersonWithIdentity	�������� � � �������� ������������ ���������
												--/Person/HumanName	 	1..1	 	��� �����
													--/HumanName	FamilyName	 	1..1	String	������� �����
													,(select ltrim(rtrim(MED.NOM))) AS FamilyName
													--/HumanName	GivenName	 	1..1	String	��� �����
													,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
													--/HumanName	MiddleName	 	0..1	String	�������� �����
													,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
												,med.DATA_ROGDENIQ  [BirthDate]
												--/Person	IdPersonMis	 	1..1	String	������������� ����� � ���
												,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
													--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
														--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
														,223 as IdDocumentType -- ��� ��������� - �����
														--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
														,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
														--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
														,'���' as ProviderName -- �����������, �������� ��������
												--IdLpu	0..1	string	������������� ��
												,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
												--IdSpeciality	1..1	unsignedShort	������������� ������������� ������������ ���������
												,SPEC.Nsi_specialisation_ID as IdSpeciality
												--IdPosition	1..1	unsignedShort	������������� ��������� ������������ ���������
												,SPEC.DOLZGNOST as IdPosition
										--/Doctor
										--IdRole	0..1 (����������� ������ ��� Service)	unsignedByte	���� ��������� � �������� ������ (���������� OID: 1.2.643.5.1.13.2.7.1.30) http://r46-rc.zdrav.netrika.ru/nsiui/Dictionary/92/FilterTree
											,3 AS IdRole -- �������, ��� �������� "����"
						--ServiceName	1..1	string	������������ ������
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
--MOT.PUBLISHED = 1 -- �������� ������ �������������� ������
--AND MOT.REC_STATUS = 'A' -- �������� ������ ����������� ������ ������
--AND 
MOT.MOTCONSU_ID = @IdCaseMis
--and MOT.CHANGED <> 1 --��������� ������ �� ������������ �����, ��� ��� ��������� ����� "�����������" ��� ����� ��������� �����
--and MOT.MOTCONSU_ID <> MOT.MOTCONSU_EV_ID -- �������� ������, ������� �� ��������� �������, � ������� � ������ ������������ ������
--and MOT.ZAPIS_ZAKR_VAYHAQ_SOB_TIE <> 1 -- ��� �� ������ ���� ��������� ������, ������������ �������, ��� ��� ��� ����� �������� � CloseCase

ORDER BY MOT.MOTCONSU_ID DESC -- ��� �������� �������, ����� ����� ������

END


GO




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





ALTER PROCEDURE [dbo].[emk4_AddMedRecordReferralMse]
@IdCaseMis INT
AS
BEGIN
	--exec [emk4_AddMedRecordReferralMse]
	
					/*������ �� ���������� ����������� ������ � ������ ������������
			��� ������������ ���� N3.���������������
			�� 10.10.2018
			�����: ��������� �.*/

--AddMedRecord------------------------------------------------------------------------------------------------------------
	--Root	 	1..1
	SELECT TOP 100
	--/guid	 	1..1	GUID	��������������� ����� --------------------------------------------------------------
		--������� ����� GUID 
	--/IdLpu	 	1..1	guid	������������� ��
	(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
	--/IdPatientMis	 	1..1	String	������������� �������� � ���������� �������
	,PAT.KRN_GUID as IdPatientMis
	,pat.PATIENTS_ID
	--/IdCaseMis	 	1..1	String	������������� ������ � ���������� ���
	,MOT.MOTCONSU_ID AS IdCaseMis
		--/medRecord	 	1..1	 	����������� ������. ��� �������� xsi:type ����������� ��������������� ��� ������������ �������. �������� ����� ������� ��������� � ������� "��� MedRecord"
					--/ConsultNote
						--CreationDate	1..1	dateTime	���� �������� ���������
						,(cast(MOT.DATE_CONSULTATION as DATE)) as CreationDate
						--FhirMedDocumentType	0..0	string	������������� ���� ��������� (�� ������������ ��� �������� ������)
						--IdDocumentMis	0..1	string	������������� ��������� � �������-��������� (���)
						
						--IdMedDocument	0..0	int	������������� ��������� � �� (�� ������������ ��� �������� ������)
						--Attachment	0..1	DocumentAttachment	������������������� (��������) ���������� ���������
							--DocumentAttachment
							--Data	0..1	base64Binary	C�������� SignData � ������� base64binary
								--SignData ���� ���������� ������������� ��������, �� ���� PublicKey, Hash � Sign �� �����������.
									--Data	1..1	Base64binary	������ �������� (�����, pdf, html,xml) � ������� base64binary
									,MOT.MSE_BodyPreparedReport as Base64binary
									,MOT.MSE_ECP_SIGN_DATA_ORG as OrganizationSign
									,MOT.MSE_ECP_SIGN_DATA as PersonalSigns
														--,(select cast(N'' as xml).value('xs:base64Binary(sql:column("plain_text"))', 'varchar(max)') as [encoded_value] 
														--	from (select cast(((CASE WHEN isnull(DOC.Description, '') = '' 
														--							THEN '����������� �������� ' + convert(varchar(19), MOT.DATE_CONSULTATION, 121) 
														--							ELSE 
														--							CAST(MOT.SEMD as varchar(max)) 
														--							END)) as varbinary(max)) as [plain_text]) as tmp) as Base64binary -- ���������, ��� ������� ���� ������ � �����
									--PublicKey	0..1	String	��������� ���� ����������� ���
									--Hash	0..1	String	���-����� ������. ������ ���-����� ������������ �� ��������� ���� � 34.10-2012 (���� � 34.10-2001). �������� ���-����� ������ ��������������� ������, ������������ � �������� Data � ������� base64binary
									--Sign	0..1	String	��� �� ���� � 34.10-2012 (���� � 34.10-2001)
								--SignData
							--Hash	0..1	base64Binary	��� ������ (�� ������������ ��� �������� � ������)
							--MimeType	�������-���������� (���� �������� Data ��������)	string --MIME-��� ������ �����-��������, ������������ � �������� Data ��������� SignData. �������������� MIME-����: text/html � HTML; text/plain � �����; application/pdf � PDF; text/xml � XML.
							,'text/xml' AS MimeType
							--Url	0..1	anyURI	����� (������), ��� ��������� ������ (���������� ��������).
								,VD.PHYSICAL_PATH + '\' + LET.FOLDER + '\' + LET.FileName AS Url	-- ����� �������� � ����������� ��� ������� ������ ������ �� ��������... ���� ����� ����� �� MOTCONSU_XML
						--Author	1..1	MedicalStaff	�������� � ����, ��������� ��������
							--Person	0..1	PersonWithIdentity	�������� � � �������� ������������ ���������
								--/Person/HumanName	 	1..1	 	��� �����
									--/HumanName	FamilyName	 	1..1	String	������� �����
									,(select ltrim(rtrim(MED.NOM))) AS FamilyName
									--/HumanName	GivenName	 	1..1	String	��� �����
									,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as GivenName
									--/HumanName	MiddleName	 	0..1	String	�������� �����
									,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS MiddleName --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
								--/Person	IdPersonMis	 	1..1	String	������������� ����� � ���
								,MED.KRN_GUID as IdPersonMis -- ��������� ������������ GUID, ����� � MEDECINS_ID
								--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
									--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
									,223 as IdDocumentType -- ��� ��������� - �����
									--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
									,MED.SYS_SNILS as DocN -- ����� ������ ������� ��� �������� � ����
									--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
									,'���' as ProviderName -- �����������, �������� ��������
							--Person
							--IdLpu	0..1	string	������������� ��
							,(SELECT TOP 1 IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) AS IdLpu
							--IdSpeciality	1..1	unsignedShort	������������� ������������� ������������ ���������
							,118 IdSpeciality--,SPEC.Nsi_specialisation_ID as IdSpeciality
							--IdPosition	1..1	unsignedShort	������������� ��������� ������������ ���������
							--,SPEC.DOLZGNOST as IdPosition
						,182 as IdPosition
						--Header	1..1	string	��������� ��������� (������� ��������)
						,(CASE WHEN isnull(DOC.Description, '') = '' THEN '����������� �� ��� ' + convert(varchar(19), MOT.DATE_CONSULTATION, 121) ELSE DOC.Description END) AS Header
					
FROM MOTCONSU MOT with (nolock)
LEFT JOIN DATA_AMBULAT_PATIENT_COUPON DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID
LEFT JOIN DATA_W438_MSE_NAPRAV napr ON napr.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN PATIENTS PAT on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
LEFT JOIN LETTERS DOC ON DOC.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_GENERAL_EXAM DGE ON DGE.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN (SELECT * FROM LETTERS WHERE D_Type = 1) LET ON LET.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN VIRTUAL_DISKS VD ON VD.VIRTUAL_DISKS_ID = LET.VIRTUAL_DISKS_ID

WHERE napr.MOTCONSU_ID = @IdCaseMis
END





GO





ALTER PROCEDURE [dbo].[emk4_GetReferralMse]  
--@AF_CURRENT_FILIAL INT, 
@AF_CURRENT_PATIENT INT,
@AF_CURRENT_MOTCONSU INT
AS
BEGIN

declare @effectiveTime_value datetime = (select DATE_CONSULTATION from MOTCONSU where MOTCONSU_ID = (select SLUCHAI_ZABOL from DATA_W438_MSE_NAPRAV where MOTCONSU_ID = @AF_CURRENT_MOTCONSU))
  		 ---------------------------------------------------------------------------------------------------------------
		 ------------------ ClinicalDocument ---------------------------------------------------------------------------
		 ---------------------------------------------------------------------------------------------------------------
SELECT
(SELECT IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1) as [MO_OID],
motconsu_id as [MOTCONSU_ID],
CONVERT(VARCHAR(MAX), REPLACE((convert(varchar(10),ISNULL(mse.DATE_PROTOKOLA_VK, @effectiveTime_value),112) + CONVERT(varchar(5), convert(time, @effectiveTime_value))), ':','') + '+0300') AS [effectiveTime_value],
CONVERT(varchar(MAX), mse.KRN_GUID) AS [PATIENTS_ID],
CONVERT(varchar(MAX), mse.SYS_SNILS) AS [PATIENTS_SNILS],
CONVERT(VARCHAR(MAX),CASE WHEN mse.VID_DOKUMENTA = 21 THEN '1' WHEN mse.VID_DOKUMENTA = 10 THEN '6' ELSE '1' END) AS [PATIENTS_DOC_ID],
CONVERT(VARCHAR(MAX),CASE WHEN mse.VID_DOKUMENTA = 21 THEN '������� ���������� ���������� ���������' WHEN mse.VID_DOKUMENTA = 10 THEN '������������� � ��������' ELSE '������� ���������� ���������� ���������' END) AS [PATIENTS_DOC_NAME],
CONVERT(VARCHAR(MAX),REPLACE(ISNULL(mse.SERIQ_DOKUMENTA, ''), ' ', '') )AS [PATIENTS_DOC_SERIYA],
CONVERT(VARCHAR(MAX),REPLACE(ISNULL(mse.PASPORT_N,''), ' ', '')) AS [PATIENTS_DOC_NUMBER],
CASE WHEN mse.VID_DOKUMENTA = 10 THEN CONVERT(varchar(250), mse.KEM_V_DAN) WHEN mse.VID_DOKUMENTA = 21 THEN CONVERT(varchar(250), mse.KEM_V_DAN)  + '. ��� �������������: ' + ISNULL(mse.kod_podrazdeleniya, '') END AS [PATIENTS_DOC_KEM_VIDAN],
CONVERT(VARCHAR(MAX),ISNULL(mse.kod_podrazdeleniya, '')) AS [PATIENTS_DOC_KOD_PODRAZDELENIYA],
CONVERT(VARCHAR(10), mse.KOGDA_V_DAN, 112) AS [PATIENTS_DOC_KOGDA_VIDAN],
CONVERT(VARCHAR(MAX),mse.NOM) AS [NOM],
CONVERT(VARCHAR(MAX),mse.PRENOM )AS [PATIENTS_PRENOM],
CONVERT(VARCHAR(MAX),mse.PATRONYME )AS [PATIENTS_PATRONYME],
CONVERT(VARCHAR(MAX),CASE WHEN mse.pol = N'�������' THEN '1' WHEN mse.pol = N'�������' THEN '2' ELSE '3' END) AS [PATIENTS_SEX_CODE],
CONVERT(VARCHAR(MAX),mse.pol) AS [PATIENTS_SEX_NAME],
CONVERT(VARCHAR(10), mse.ne_le, 112) AS [PATIENTS_BIRTH_DATE],
------------------------------------------------------------------------------------
-- [0..1] ����� ���������� ����������� ��������
  
  ISNULL(mse.KOD_TERRITORII, '') AS 'H_KOD_TERRITORII',
  --   [1..1] ����� -->
  --'���' AS 'CD/recordTarget/patientRole/addr[1]/county',	-- ����� �������� ����������� ������� �� ������ ���� �������		UPD!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
  --   [1..1] ������������ ���������� ������ -->
  ISNULL(mse.NASELENN_J_PUNKT, '') AS 'H_NASELENNJ_PUNKT',
  --   [1..1] �������� ������ -
  ISNULL(mse.INDEKS_STREET, '') AS 'H_INDEKS_STREET',
  --   [1..1] ����� ������� -->
  '� ���, ' + ISNULL(mse.INDEKS_STREET, '') + ', ' + ISNULL(mse.NASELENN_J_PUNKT, '') + ', ' + ISNULL(mse.ULICA, '') + ', �. ' + ISNULL(mse.DOM, '') + ', ����. ' + isnull(mse.KORPUS, '') + ', ���. ' + ISNULL(mse.STROENIE, '') + ', ��. ' + ISNULL(mse.KVARTIRA, '') AS 'H_StreetAddressLine',
  --   [1..1] ��� -->
  '�. ' + ISNULL(mse.DOM, '') + ', ����. ' + isnull(mse.KORPUS, '') + ', ���. ' + ISNULL(mse.STROENIE, '')  AS 'H_HouseNumber',
  --   [1..1] ����� -->
  ISNULL(mse.ULICA, '') AS 'H_StreetName',
  --   [1..1] �������� -->
  ISNULL(mse.KVARTIRA, '') AS 'H_unitID',
 
 -- [0..1] ����� ������������ ����� ���������� �������� -->
 
  ISNULL(mse.REG_TERRITORY, '') AS 'HP_REG_TERRITORY',
  --   [1..1] ����� -->
 -- '���' AS 'CD/recordTarget/patientRole/addr[2]/county',	-- ����� �������� ����������� ������� �� ������ ���� �������		UPD!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
  --   [1..1] ������������ ���������� ������ -->
  ISNULL(mse.REG_SETTLEMENT_TEXT, '') AS 'HP_NASELENNJ_PUNKT',
  --   [1..1] �������� ������ -
  ISNULL(mse.REG_INDEKS_STREET, '') AS 'HP_REG_INDEKS_STREET',
  --   [1..1] ����� ������� -->
  '� ���, ' + ISNULL(mse.REG_INDEKS_STREET, '') + ', ' + ISNULL(mse.REG_SETTLEMENT_TEXT, '') + ', ' + ISNULL(mse.REG_STREET_TEXT, '') + ', �. ' + ISNULL(mse.REG_HOUSE, '') + ', ����. ' + isnull(mse.REG_HOUSING, '') + ', ���. ' + ISNULL(mse.REG_BUILDING, '') + ', ��. ' + ISNULL(mse.REG_FLAT, '') AS 'HP_StreetAddressLine',
  --   [1..1] ��� -->
  '�. ' + ISNULL(mse.REG_HOUSE, '') + ', ����. ' + isnull(mse.REG_HOUSING, '') + ', ���. ' + ISNULL(mse.REG_BUILDING, '')  AS 'HP_HouseNumber',
  --   [1..1] ����� -->
  ISNULL(mse.REG_STREET_TEXT, '')  AS 'HP_StreetName',
  --   [1..1] �������� -->
  ISNULL(mse.REG_FLAT, '') AS 'HP_unitID',
  --------------------------------------------------------------------------
  --<!-- [0..1] ����������� ������������ -->
		 --                           <!-- R [1..1] ������������ -->
CASE WHEN ISNULL(mse.INVALID, '') = 0 THEN '1' WHEN ISNULL(mse.INVALID, '') = 1 THEN '2' WHEN ISNULL(mse.INVALID, '') = 2 THEN '3' WHEN ISNULL(mse.INVALID, '') = 3 THEN '4' END AS 'GROUP_INVALID_CODE',
CASE WHEN ISNULL(mse.INVALID, '') = 0 THEN '1 ������' WHEN ISNULL(mse.INVALID, '') = 1 THEN '2 ������' WHEN ISNULL(mse.INVALID, '') = 2 THEN '3 ������' WHEN ISNULL(mse.INVALID, '') = 3 THEN '�������-�������' END  AS 'GROUP_INVALID_NAME',
 --                               <!-- [1..1] ����\�����, �� ������� ����������� ������������ -->
CONVERT(varchar, ISNULL(mse.OKONCH_DEISTVIYA, ''), 112) AS 'DATA_UTRATI',
--										<!-- R [1..1] ����, �� ������� ����������� ������� ������ ���������������� ���������������� -->
CASE WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 0 THEN '1' WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 1 THEN '2' WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 2 THEN '3' WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 3 THEN '4' END AS 'SROK_UTRATY_CODE',
CASE WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 0 THEN '�� ���� ���' WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 1 THEN '�� ��� ����' WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 2 THEN '�� ���� ���' WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 3 THEN '�� 14 ���'  WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 4 THEN '�� 18 ���' WHEN ISNULL(mse.POVTOR_SROK_UTRATI_1, '') = 5 THEN '���������' END  AS 'SROK_UTRATY_NAME',
--  <!-- R [1..1] ����, �� ������� ����������� ������� ������ ���������������� ���������������� -->
CASE WHEN ISNULL(mse.PERIOD_INVALID, '') = 0 THEN 1 WHEN ISNULL(mse.PERIOD_INVALID, '') = 1 THEN 2 WHEN ISNULL(mse.PERIOD_INVALID, '') = 2 THEN 3 WHEN ISNULL(mse.PERIOD_INVALID, '') = 3 THEN 4 END AS 'PERIOD_NAHODITSYA_NA_INV' ,
CASE WHEN ISNULL(mse.PERIOD_INVALID, '') = 0 THEN '���� ���' WHEN ISNULL(mse.PERIOD_INVALID, '') = 1 THEN '��� ����' WHEN ISNULL(mse.PERIOD_INVALID, '') = 2 THEN '��� ����' WHEN ISNULL(mse.PERIOD_INVALID, '') = 3 THEN '������ � ����� ���' END AS 'PERIOD_NAHODITSYA_NA_INV_NAME',
 --                           <!-- [0..1] ����������� ... ������� ������������ -->
CONVERT(varchar, ISNULL(mse.PRICHINA_INVALID, '')) AS 'MSE_MISSION_INVALID', 
CONVERT(nvarchar, ISNULL(mse.FORMULIROVKA_PRICHINY, '')) AS 'MSE_MISSION_DisplayName',

  ---------------------------------------------------------------------------
--<!-- [0..1] �������� (��������������) ������������� -->
-- <!-- [0..1] ����� ������������� -->
 ISNULL(mse.DATA_FOR_LEGAL_REPRESENT_SNILS, '') AS 'GUARD_SNILS',
    --						<!--   [1..1] ����� ��������� -->
 REPLACE(ISNULL(mse.DATA_FOR_LEGAL_REPRESENT_SERIQ_, ''), ' ', '') AS 'GUARD_DOC_SERIES',
    --						<!-- R [1..1] ����� ��������� -->
 REPLACE(ISNULL(mse.NOMER_DOKUMENTA, ''), ' ', '')  AS 'GUARD_DOC_NOMER',
     --						<!--   [1..1] ��� ����� �������� -->
 ISNULL(mse.KEM_V_DAN, '') + '. ��� �������������: ' + ISNULL(mse.KOD_PODRAZDELENIYA, '') AS 'GUARD_DOC_KEM_VYDAN',
   --						<!--   [1..1] ��� ����� ��������, ��� ������������� -->
 ISNULL(mse.KOD_PODRAZDELENIYA, '')  AS 'GUARD_KOD_PODRAZDELENIYA',
  --                          <!-- R [1..1] ���� ������ ��������� -->
 CONVERT(VARCHAR(10), mse.KOGDA_V_DAN, 112) AS 'GUARD_DOC_DATE',
  --					</f88:IdentityDoc>
  --					<!-- [0..1] ��������� �������: ��������, �������������� ���������� �������������, �����, �����, ��� �����. -->
  --					<f88:AuthorityDoc>
  --						<!-- R [1..1] ��� ��������� -->
 CASE WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 0 THEN '1' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 1 THEN '2' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 2 THEN '3' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 3 THEN '4' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 4 THEN '5' END AS 'PRED_DOC_CODE',
 CASE WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 0 THEN '������������� � ��������' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 1 THEN '������� � ���������� ���� ��������' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 2 THEN '������� � ���������� ���� �����������' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 3 THEN '������������' WHEN ISNULL(mse.DOKUM_PREDSTAV_, '') = 4 THEN '������������� �� ����������� (����������)' END AS 'PRED_DOC_NAME',
	--						<!--   [1..1] ����� ��������� -->
 CONVERT(varchar, (ISNULL(convert(varchar(20), mse.SERIYA_DOC_PODTV), ''))) AS 'GUARD_ADD_SERYA_DOCUMENTA',
    --						<!-- R [1..1] ����� ��������� -->
 ISNULL(mse.PASPORT, '') AS 'GUARD_ADD_NOMER_DOCUMENTA',
    --						<!--   [1..1] ��� ����� �������� -->
 ISNULL(mse.VYDAN_KEM_KOGDA, '')  AS 'GUARD_ADD_KEM_VIDAN',
    --						<!-- R [1..1] ���� ������ ��������� -->
 CONVERT(varchar(10), ISNULL(mse.KOGDA_VIDAN_DOC_PODTV, ''), 112) AS GUARD_ADD_KOGDA_VIDAN,
 --                           <!-- R [1..1] ������� -->
  mse.FAMILIYA AS 'GUARD_FAMILIYA',
  --                            <!-- R [1..1] ��� -->
  mse.IMYA AS 'GUARD_IMYA',
  --                            <!-- [1..1] �������� -->
  mse.OTCHESTVO AS 'GUARD_OTCHESTVO',
  

---------------------------------------------------------

CONVERT(VARCHAR(MAX),(SELECT ORGN FROM FM_ORG WHERE FM_ORG_ID = 1)) AS [ORG_OGRN],
CONVERT(VARCHAR(MAX),(SELECT LABEL FROM FM_ORG WHERE FM_ORG_ID = 1) )AS [ORG_NAME],
CONVERT(VARCHAR(MAX),(SELECT LN_ADDRESS FROM FM_ORG WHERE FM_ORG_ID = 1)) AS [ORG_ADDRESS],
CONVERT(VARCHAR(MAX),REPLACE((convert(varchar(10),mse.KRN_MODIFY_DATE,112) + convert(varchar(5), convert(time, mse.KRN_MODIFY_DATE))), ':','') + '+0300' )AS [AUTHOR_DATE_SIGN],
CONVERT(varchar(MAX), mse.MEDECINS_CREATOR_ID) AS [AUTHOR_ID],
CONVERT(varchar(MAX), mse.CODE_NSI_DOLZGNOST) AS [AUTHOR_DOLZGNOST_CODE],
CONVERT(VARCHAR(MAX),ISNULL(mse.DOLZGNOST_MED_PERSONALA, '')) AS [AUTHOR_DOLZGNOST_NAME],
CONVERT(VARCHAR(MAX),ltrim(rtrim(mse.MEDECINS_CREATOR_NOM))) AS [AUTHOR_NOM],
CONVERT(VARCHAR(MAX),CASE WHEN LEN (ltrim(rtrim(substring(mse.MEDECINS_CREATOR_PRENOM, 0, charindex(' ', mse.MEDECINS_CREATOR_PRENOM))))) = 0 THEN mse.MEDECINS_CREATOR_PRENOM ELSE (ltrim(rtrim(substring(mse.MEDECINS_CREATOR_PRENOM, 0, charindex(' ', mse.MEDECINS_CREATOR_PRENOM))))) END )AS [AUTHOR_PRENOM],
CONVERT(VARCHAR(MAX),ltrim(rtrim(substring(mse.MEDECINS_CREATOR_PRENOM, charindex(' ', mse.MEDECINS_CREATOR_PRENOM) +1, (len(mse.MEDECINS_CREATOR_PRENOM) + charindex(' ', mse.MEDECINS_CREATOR_PRENOM))))) )AS [AUTHOR_PATRONYME],
CONVERT(VARCHAR(MAX),mse.PREDSEDATEL_VK_ID )AS [SIGNED_DOCTOR_ID],
CONVERT(VARCHAR(MAX),ltrim(rtrim(mse.PREDSEDATEL_NOM))) AS [SIGNED_DOCTOR_NOM],
CONVERT(VARCHAR(MAX),CASE WHEN LEN (ltrim(rtrim(substring(mse.PREDSEDATEL_PRENOM, 0, charindex(' ', mse.PREDSEDATEL_PRENOM))))) = 0 THEN mse.PREDSEDATEL_PRENOM ELSE (ltrim(rtrim(substring(mse.PREDSEDATEL_PRENOM, 0, charindex(' ', mse.PREDSEDATEL_PRENOM))))) END) AS [SIGNED_DOCTOR_PRENOM],
CONVERT(VARCHAR(MAX),ltrim(rtrim(substring(mse.PREDSEDATEL_PRENOM, charindex(' ', mse.PREDSEDATEL_PRENOM) +1, (len(mse.PREDSEDATEL_PRENOM) + charindex(' ', mse.PREDSEDATEL_PRENOM)))))) AS [SIGNED_DOCTOR_PATRONYME],
CONVERT(VARCHAR(MAX),CASE WHEN mse.GRAZDANIN_NAHODITSYA = 0 THEN '7' WHEN mse.GRAZDANIN_NAHODITSYA = 1 THEN '10' WHEN mse.GRAZDANIN_NAHODITSYA = 2 THEN '11' WHEN mse.GRAZDANIN_NAHODITSYA = 3 THEN '9' WHEN mse.GRAZDANIN_NAHODITSYA = 4 THEN '2' END) AS [PATIENTS_SITUATED_CODE],
CONVERT(VARCHAR(MAX),CASE WHEN mse.GRAZDANIN_NAHODITSYA = 0 THEN '���������' WHEN mse.GRAZDANIN_NAHODITSYA = 1 THEN '����������� ����������� ������������, ����������� ���������� ������ � ������������ ����� ����������� ������������' WHEN mse.GRAZDANIN_NAHODITSYA = 2 THEN '�������������� ����������' WHEN mse.GRAZDANIN_NAHODITSYA = 3 THEN '���� ����������� �����������' WHEN mse.GRAZDANIN_NAHODITSYA = 4 THEN '�� ����' END) AS [PATIENTS_SITUATED_NAME],
CONVERT(VARCHAR(MAX),CASE WHEN mse.PERV_POVTORN = 0 THEN '���������' WHEN mse.PERV_POVTORN = 1 THEN '���������' END) AS [DIRECTION_TYPE],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.MISSION, '') = 14 THEN (ISNULL(mse.NAIMENOVANIE, '') + ' ' + ISNULL(mse.ANOTHER_MISSION, '')) ELSE ISNULL(mse.NAIMENOVANIE, '') END) AS [DIRECTION_TARGET],
CONVERT(VARCHAR(MAX),'� ' + CONVERT(VARCHAR, ISNULL(mse.nomer_protokola_vk, '')) + ' �� ' + CONVERT(varchar(10), mse.DATE_PROTOKOLA_VK, 104) + ' �.') AS  [DIRECTION_NUM_DATE],
convert(varchar(10), mse.DATE_PROTOKOLA_VK, 104) +' �.' AS [DIRECTION_DATE],
CONVERT(VARCHAR(MAX),CASE WHEN mse.GRAGDANSTVO = 0 THEN '��������� ���������� ���������' WHEN mse.GRAGDANSTVO = 1 THEN '��������� ���������� ��������� � ������������ ����������� (������� �����������)' WHEN mse.GRAGDANSTVO = 2 THEN '����������� ���������' WHEN mse.GRAGDANSTVO = 3 THEN '���� ��� �����������' END) AS [PATIENTS_GRAZGDANSTVO],
CONVERT(VARCHAR(MAX),CASE WHEN mse.VOIN_OBYAZ = 0 THEN '���������, ��������� �� �������� �����' WHEN mse.VOIN_OBYAZ = 1 THEN '���������, �� ��������� �� �������� �����, �� ��������� �������� �� �������� �����' WHEN mse.VOIN_OBYAZ = 2 THEN '���������, ����������� �� �������� ����' WHEN mse.VOIN_OBYAZ = 3 THEN '���������, �� ��������� �� �������� �����' END) AS [PATIENTS_VOIN_OBYAZ],
CONVERT(VARCHAR(MAX),ISNULL(convert(varchar, mse.MISSION), '')) AS [DIRECTION_TARGET_CODE],
CASE WHEN mse.PERV_POVTORN=0 THEN 1 WHEN mse.PERV_POVTORN=1 THEN 2 END AS [DIRECTION_TYPE_CODE],
CONVERT(VARCHAR(MAX),REPLACE((convert(varchar(10), mse.DATE_PROTOKOLA_VK,112) + convert(varchar(5), convert(time, mse.DATE_PROTOKOLA_VK))), ':','') + '+0300' )AS [DIRECTION_DATETIME],
CONVERT(VARCHAR(MAX), ISNULL(mse.nomer_protokola_vk, '')) AS [DIRECTION_NUMBER],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.PALLIAT_MED_POM, '') = 0 THEN 'false' WHEN ISNULL(mse.PALLIAT_MED_POM, '') = 1 THEN 'true' END ) AS [DIRECTION_PALLIAT_HELP],
CONVERT(VARCHAR(MAX),CASE WHEN mse.GRAGDANSTVO = 0 THEN '1' WHEN mse.GRAGDANSTVO = 1 THEN '2' WHEN mse.GRAGDANSTVO = 2 THEN '3' WHEN mse.GRAGDANSTVO = 3 THEN '4' END) AS [PATIENTS_GRAZGDANSTVO_CODE],
CONVERT(VARCHAR(MAX),CASE WHEN mse.VOIN_OBYAZ = 0 THEN '1' WHEN mse.VOIN_OBYAZ = 1 THEN '3' WHEN mse.VOIN_OBYAZ = 2 THEN '2' WHEN mse.VOIN_OBYAZ = 3 THEN '4' END) AS [PATIENTS_VOIN_OBYAZ_CODE],
replace(CONVERT(VARCHAR(MAX),ISNULL(mse.PROFESSIYA, '��� ������')), '>', '������') AS [PATIENTS_WORK],
CONVERT(VARCHAR(MAX),ISNULL( (ISNULL(mse.NAIMENOVAN_ADRES_OBR_ORG, ' ') + ' ' + ISNULL(mse.KURS_KLASS, ' ') + ' ' + ISNULL(mse.OBUCH_SPECIALNOST_PROFESSIYA, ' ')) , '��� ������')) AS [PATIENTS_LEARNING],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.NABLUDAETSYA, '') = '' THEN '��� ������' ELSE 'c ' + CONVERT(nvarchar, ISNULL(mse.NABLUDAETSYA, ''), 104) + ' �.' END) AS [PATIENTS_ANAM_DATE_FROM],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.ANAMNEZ_ZABOL, '') = '' THEN '��� ������' ELSE REPLACE(REPLACE(CONVERT(nvarchar(max), ISNULL(mse.ANAMNEZ_ZABOL, '')), '>', ' ������ '), '<', ' ������ ') END) AS [PATIENTS_ANAM_ZABOL],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.ANAMNEZ_ZHIZNI, '') = '' THEN '��� ������' ELSE REPLACE(REPLACE(CONVERT(nvarchar(max), ISNULL(mse.ANAMNEZ_ZHIZNI, '')), '>', ' ������ '), '<', ' ������ ') END) AS [PATIENTS_ANAM_ZGIZN],
CONVERT(VARCHAR(MAX), ISNULL(mse.VES,'')) AS [PATIENTS_VITAL_VES],
CONVERT(VARCHAR(MAX), ISNULL(mse.ROST,'')) AS  [PATIENTS_VITAL_ROST],
CONVERT(VARCHAR(MAX), ISNULL(mse.INDEX_MT,'')) AS [PATIENTS_VITAL_IMT],
CONVERT(VARCHAR(MAX), ISNULL(mse.TELOSLOGENIE,'����������������')) AS [PATIENTS_VITAL_TELO],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.TELOSLOGENIE, '') like '%�����%' THEN '1' WHEN ISNULL(mse.TELOSLOGENIE, '') like '%�����%' THEN '2' WHEN ISNULL(mse.TELOSLOGENIE, '') like '�����%' THEN '3' ELSE '1' END) AS [PATIENTS_VITAL_TELO_CODE],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.SOST_ZDOROV, '') = '' THEN '��� ������' ELSE REPLACE(REPLACE(ISNULL(mse.SOST_ZDOROV, ''), '>', ' ������ '), '<', ' ������ ') END) AS [PATIENTS_DIRECTION_SOSTOYANIE],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(convert(nvarchar(max),mse.SVED_O_OBSLED_INSTR), '') = '' AND ISNULL(convert(nvarchar(max),mse.SVED_O_OBSLED_LAB), '') = '' AND ISNULL(convert(nvarchar(max), mse.SVED_O_OBSLED_KONSULT), '') = '' THEN '������ �����������' ELSE '���������������� ������������: ' + REPLACE(REPLACE(ISNULL(convert(nvarchar(max),mse.SVED_O_OBSLED_INSTR), ''), '>', ' ������ '), '<', ' ������ ') + ' ������������ ������������: ' + REPLACE(REPLACE(ISNULL(convert(nvarchar(max),mse.SVED_O_OBSLED_LAB), ''), '>', ' ������ '), '<', ' ������ ') + ' ������������ ������������: ' + REPLACE(REPLACE(ISNULL(convert(nvarchar(max), mse.SVED_O_OBSLED_KONSULT), ''), '>', ' ������ '), '<', ' ������ ') END) AS [PATIENTS_DIRECTION_MEDICAL_EXAMINATIONS],
CONVERT(VARCHAR(MAX),ISNULL((select TOP 1 MKB10_CODE from (SELECT TOP 10
	DATA_DIAGNOSIS.MOTCONSU_ID MOTCONSU_ID, 
	DATA_DIAGNOSIS.VID_ZABOLEVANIQ VID_ZABOLEVANIQ, 
	CIM10.CODE MKB10_CODE, 
	CIM10.DESCRIPTION MKB10_NAME, 
	DATA_DIAGNOSIS.DIAGNOZ DS_VRACH, 
	DATA_DIAGNOSIS.DATA_NAHALA_ZABOLEVANIQ DATA_DIAGNOS
	FROM DATA_DIAGNOSIS DATA_DIAGNOSIS
	left join CIM10 CIM10 ON CIM10.CIM10_ID = DATA_DIAGNOSIS.SS_LKA_CIM10
	WHERE DATA_DIAGNOSIS.MOTCONSU_ID = @AF_CURRENT_MOTCONSU) d where VID_ZABOLEVANIQ = 0), '')) AS [PATIENTS_DIRECTION_DIAGNOSIS_MAIN_CODE],
REPLACE(REPLACE(CONVERT(VARCHAR(MAX),ISNULL((select TOP 1 DS_VRACH from (SELECT TOP 10
	DATA_DIAGNOSIS.MOTCONSU_ID MOTCONSU_ID, 
	DATA_DIAGNOSIS.VID_ZABOLEVANIQ VID_ZABOLEVANIQ, 
	CIM10.CODE MKB10_CODE, 
	CIM10.DESCRIPTION MKB10_NAME, 
	DATA_DIAGNOSIS.DIAGNOZ DS_VRACH, 
	DATA_DIAGNOSIS.DATA_NAHALA_ZABOLEVANIQ DATA_DIAGNOS
	FROM DATA_DIAGNOSIS DATA_DIAGNOSIS
	left join CIM10 CIM10 ON CIM10.CIM10_ID = DATA_DIAGNOSIS.SS_LKA_CIM10
	WHERE DATA_DIAGNOSIS.MOTCONSU_ID = @AF_CURRENT_MOTCONSU) d where VID_ZABOLEVANIQ = 0), '')), '>', ' ������ '), '<', ' ������ ') AS [PATIENTS_DIRECTION_DIAGNOSIS_MAIN_DESCRIPTION],
CONVERT(VARCHAR(MAX),ISNULL((select TOP 1 MKB10_NAME from (SELECT TOP 10
	DATA_DIAGNOSIS.MOTCONSU_ID MOTCONSU_ID, 
	DATA_DIAGNOSIS.VID_ZABOLEVANIQ VID_ZABOLEVANIQ, 
	CIM10.CODE MKB10_CODE, 
	CIM10.DESCRIPTION MKB10_NAME, 
	DATA_DIAGNOSIS.DIAGNOZ DS_VRACH, 
	DATA_DIAGNOSIS.DATA_NAHALA_ZABOLEVANIQ DATA_DIAGNOS
	FROM DATA_DIAGNOSIS DATA_DIAGNOSIS
	left join CIM10 CIM10 ON CIM10.CIM10_ID = DATA_DIAGNOSIS.SS_LKA_CIM10
	WHERE DATA_DIAGNOSIS.MOTCONSU_ID = @AF_CURRENT_MOTCONSU) d where VID_ZABOLEVANIQ = 0), '') ) AS [PATIENTS_DIRECTION_DIAGNOSIS_MAIN_DESCRIPTION_MKB],
CONVERT(varchar(MAX), ISNULL((select TOP 1 DATA_DIAGNOS from (SELECT TOP 10
	DATA_DIAGNOSIS.MOTCONSU_ID MOTCONSU_ID, 
	DATA_DIAGNOSIS.VID_ZABOLEVANIQ VID_ZABOLEVANIQ, 
	CIM10.CODE MKB10_CODE, 
	CIM10.DESCRIPTION MKB10_NAME, 
	DATA_DIAGNOSIS.DIAGNOZ DS_VRACH, 
	DATA_DIAGNOSIS.DATA_NAHALA_ZABOLEVANIQ DATA_DIAGNOS
	FROM DATA_DIAGNOSIS DATA_DIAGNOSIS
	left join CIM10 CIM10 ON CIM10.CIM10_ID = DATA_DIAGNOSIS.SS_LKA_CIM10
	WHERE DATA_DIAGNOSIS.MOTCONSU_ID = @AF_CURRENT_MOTCONSU) d where VID_ZABOLEVANIQ = 0), ''), 112) AS [PATIENTS_DIRECTION_DIAGNOSIS_MAIN_DATE],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.KLINICH_PROGNOZ, '') = 0 THEN '����������� ������� �������������' WHEN ISNULL(mse.KLINICH_PROGNOZ, '') = 1 THEN '����������� ������� ������������ �������������' WHEN ISNULL(mse.KLINICH_PROGNOZ, '') = 2 THEN '����������� ������� ������������ (��������������)' WHEN ISNULL(mse.KLINICH_PROGNOZ, '') = 3 THEN '����������� ������� ���������������' ELSE '��� ������' END) AS [PATIENTS_DIRECTION_OBJECTIVE_CLINICAL_PROGNOSIS],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.REABILIT_POTENC, '') = 0 THEN '���������������� ��������� �������' WHEN ISNULL(mse.REABILIT_POTENC, '') = 1 THEN '���������������� ��������� ������������������' WHEN ISNULL(mse.REABILIT_POTENC, '') = 2 THEN '���������������� ��������� ������' WHEN ISNULL(mse.REABILIT_POTENC, '') = 3 THEN '���������������� ��������� �����������' ELSE '��� ������' END) AS [PATIENTS_DIRECTION_OBJECTIVE_REABILITATION_POTENCIAL],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.REABILIT_PROGNOZ, '') = 0 THEN '���������������� ������� �������������' WHEN ISNULL(mse.REABILIT_PROGNOZ, '') = 1 THEN '���������������� ������� ������������ �������������' WHEN ISNULL(mse.REABILIT_PROGNOZ, '') = 2 THEN '���������������� ������� ������������ (��������������)' WHEN ISNULL(mse.REABILIT_PROGNOZ, '') = 3 THEN '���������������� ������� ���������������' ELSE '��� ������' END) AS [PATIENTS_DIRECTION_OBJECTIVE_REABILITATION_PROGNOSIS],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.MEROPR_HIRURG, '') = '' AND ISNULL(mse.MEROPR_PROTEZ, '') = '' AND ISNULL(mse.SAN_KUR, '') = '' THEN '��� ������' ELSE '������������� ����������� �� ���������������� ��������: ' + ISNULL(mse.MEROPR_HIRURG, '��� ������') + ' ������������� ����������� �� �������������� � �������������: ' + ISNULL(mse.MEROPR_PROTEZ, '��� ������') + ' ���������-��������� �������: ' + ISNULL(mse.SAN_KUR, '��� ������') END) AS [PATIENTS_DIRECTION_RECOMEND_CURE],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.MEROPR_HIRURG, '')='' THEN '��� ������' ELSE REPLACE(REPLACE(ISNULL(mse.MEROPR_HIRURG, ''), '>', ' ������ '), '<', ' ������ ') END) AS [PATIENTS_DIRECTION_RECOMEND_HIR],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.MEROPR_PROTEZ, '')='' THEN '��� ������' ELSE REPLACE(REPLACE(ISNULL(mse.MEROPR_PROTEZ, ''), '>', ' ������ '), '<', ' ������ ') END) AS [PATIENTS_DIRECTION_RECOMEND_PROTEZ],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.SAN_KUR, '')='' THEN '��� ������' ELSE ISNULL(mse.SAN_KUR, '') END) AS [PATIENTS_DIRECTION_RECOMEND_SANKUR],
CONVERT(VARCHAR(MAX),CASE WHEN ISNULL(mse.MEROPR_REAB, '') = '' THEN '��� ������' ELSE REPLACE(REPLACE(ISNULL(mse.MEROPR_REAB, ''), '>', ' ������ '), '<', ' ������ ') END) AS [PATIENTS_DIRECTION_RECOMEND_ANOTHER]
--,mse.CREATE_DATE_TIME



FROM
  (SELECT
  DATA_W438_MSE_NAPRAV.KRN_CREATE_DATE KRN_CREATE_DATE,
  DATA_W438_MSE_NAPRAV.KRN_MODIFY_DATE KRN_MODIFY_DATE,
  (SELECT LABEL FROM FM_ORG WHERE FM_ORG_ID = 1)  lpu,
  (SELECT FM_ADR.ADR FROM FM_ADR WHERE FM_ADR.FM_ADR_ID = (SELECT    FM_ORG_ADR.FM_ADR_ID  FROM fm_org_adr  WHERE FM_ORG_ADR.FM_ORG_ID = 1))  adres_lpu,
  (SELECT FM_ORG.ORGN FROM FM_ORG WHERE FM_ORG_ID = 1) ogrn_mo,
  DATA_W438_MSE_NAPRAV.MOTCONSU_ID motconsu_id,
  DATA_W438_MSE_NAPRAV.NOMER_PROTOKOLA_VK NOMER_PROTOKOLA_VK,
  DATA_W438_MSE_NAPRAV.DATE_PROTOKOLA_VK DATE_PROTOKOLA_VK,
  DATA_W438_MSE_NAPRAV.NA_DOMU NA_DOMU,
  DATA_W438_MSE_NAPRAV.PALLIAT_MED_POM PALLIAT_MED_POM,
  DATA_W438_MSE_NAPRAV.DATE_CONSULTATION DATE_CONSULTATION,
  DATA_W438_MISSION_MSE.NAIMENOVANIE NAIMENOVANIE,
  DATA_W438_MSE_NAPRAV.MISSION MISSION,
  DATA_W438_MSE_NAPRAV.ANOTHER_MISSION ANOTHER_MISSION,
  PATIENTS.NOM NOM,
  PATIENTS.PRENOM PRENOM,
  PATIENTS.PATRONYME PATRONYME,
  PATIENTS.NE_LE NE_LE,
  (SELECT DATEDIFF(YEAR,(SELECT NE_LE FROM PATIENTS WHERE PATIENTS_ID = @AF_CURRENT_PATIENT), GETDATE())) Age,
  (LOWER(CASE WHEN PATIENTS.POL = 0 THEN '�������' ELSE '�������' END)) pol,
  DATA_W438_MSE_NAPRAV.GRAGDANSTVO,
  DATA_W438_MSE_NAPRAV.VOIN_OBYAZ,
  PATIENTS.DOM,
  PATIENTS.KORPUS,
  PATIENTS.STROENIE,
  PATIENTS.NASELENN_J_PUNKT,
  PATIENTS.KVARTIRA,
  PATIENTS.INDEKS,
  ADR_STREET.INDEKS AS INDEKS_STREET,
  PATIENTS.ULICA,
  PATIENTS.ULICA_MOSKVA,
  OMI_COUNTRY.NAME,
  ADR_OBLAST.NAME ADR_OBLAST_NAME,
  PATIENTS.RAJON,
  ADR_OBLAST.SOCR,
  PATIENTS.KOD_TERRITORII,
  PATIENTS.REG_TERRITORY,
  PATIENTS.REG_SETTLEMENT_TEXT,
  ADR_STREET_REG.INDEKS AS REG_INDEKS_STREET,
  PATIENTS.REG_STREET_TEXT,
  PATIENTS.REG_HOUSE,
  PATIENTS.REG_HOUSING,
  PATIENTS.REG_BUILDING,
  PATIENTS.REG_FLAT,
  DATA_W438_MSE_NAPRAV.BOMG,
  DATA_W438_MSE_NAPRAV.GRAZDANIN_NAHODITSYA,
  DATA_W438_MSE_NAPRAV.ADRESS_ORG,
  DATA_W438_MSE_NAPRAV.OGRN_ORG,
  PATIENTS.MOBIL_TELEFON,
  PATIENTS.E_MAIL,
  PATIENTS.SYS_SNILS,
  OMI_DOCTYPE.LABEL,
  PATIENTS.VID_DOKUMENTA,
  PATIENTS.SERIQ_DOKUMENTA,
  PATIENTS.PASPORT_N,
  PATIENTS.KOGDA_V_DAN,
  PATIENTS.KEM_V_DAN,
  PATIENTS.KOD_PODRAZDELENIYA,
  DATA_FOR_LEGAL_REPRESENT.FAMILIYA,
  DATA_FOR_LEGAL_REPRESENT.IMYA,
  DATA_FOR_LEGAL_REPRESENT.OTCHESTVO,
  DATA_FOR_LEGAL_REPRESENT.DOKUM_PREDSTAV_,
  DATA_FOR_LEGAL_REPRESENT.VYDAN_KEM_KOGDA,
  DATA_FOR_LEGAL_REPRESENT.NOMER_DOKUMENTA,
  DATA_FOR_LEGAL_REPRESENT.SERIYA_DOC_PODTV,
  DATA_FOR_LEGAL_REPRESENT.KOGDA_VIDAN_DOC_PODTV,
  OMI_DOCTYPE_1.LABEL OMI_DOCTYPE_LABEL,
  DATA_FOR_LEGAL_REPRESENT.PASPORT,
  DATA_FOR_LEGAL_REPRESENT.SERIQ_DOKUMENTA DATA_FOR_LEGAL_REPRESENT_SERIQ_,
  DATA_FOR_LEGAL_REPRESENT.KOGDA_V_DAN DATA_FOR_LEGAL_REPRESENT_KOGDA_,
  DATA_FOR_LEGAL_REPRESENT.KEM_VYDAN,
  DATA_FOR_LEGAL_REPRESENT.TELEFON,
  DATA_FOR_LEGAL_REPRESENT.E_MAIL DATA_FOR_LEGAL_REPRESENT_E_MAIL,
  DATA_FOR_LEGAL_REPRESENT.SNILS DATA_FOR_LEGAL_REPRESENT_SNILS,
  DATA_FOR_LEGAL_REPRESENT.NAME_FIRMA,
  DATA_FOR_LEGAL_REPRESENT.ADRES_FIRMA,
  DATA_FOR_LEGAL_REPRESENT.OGRN_FIRMA,
  DATA_W438_MSE_NAPRAV.PERV_POVTORN,
  DATA_W438_MSE_NAPRAV.INVALID,
  DATA_W438_MSE_NAPRAV.OKONCH_DEISTVIYA,
  DATA_W438_PRICHINA_INVALID.FORMULIROVKA_PRICHINY,
  DATA_W438_MSE_NAPRAV.PERIOD_INVALID,
  DATA_W438_MSE_NAPRAV.ANOTHER_PRICHINA,
  DATA_W438_MSE_NAPRAV.FORMULIROVKA_PRICHIN_INVALID,
  DATA_W438_MSE_NAPRAV.PRICHINA_INVALID,
  DATA_W438_MSE_NAPRAV.STEPEN_UTRATI,
  DATA_W438_MSE_NAPRAV.SROK_UTRATI,
  DATA_W438_MSE_NAPRAV.DATA_UTRATI,
    DATA_W438_MSE_NAPRAV.POVTOR_STEP_UTRATI_PROC_1 POVTOR_STEP_UTRATI_PROC_1,
  DATA_W438_MSE_NAPRAV.POVTOR_STEP_UTRATI_PROC_2 POVTOR_STEP_UTRATI_PROC_2,
  DATA_W438_MSE_NAPRAV.POVTOR_STEP_UTRATI_PROC_3 POVTOR_STEP_UTRATI_PROC_3,
  DATA_W438_MSE_NAPRAV.POVTOR_SROK_UTRATI_1 POVTOR_SROK_UTRATI_1,
  DATA_W438_MSE_NAPRAV.POVTOR_SROK_UTRATI_2 POVTOR_SROK_UTRATI_2,
  DATA_W438_MSE_NAPRAV.POVTOR_SROK_UTRATI_3 POVTOR_SROK_UTRATI_3,
  DATA_W438_MSE_NAPRAV.POVTOR_DATA_UTRATI_1 POVTOR_DATA_UTRATI_1,
  DATA_W438_MSE_NAPRAV.POVTOR_DATA_UTRATI_2 POVTOR_DATA_UTRATI_2,
  DATA_W438_MSE_NAPRAV.POVTOR_DATA_UTRATI_3 POVTOR_DATA_UTRATI_3,
  DATA_W438_MSE_NAPRAV.UCHEBA,
  DATA_W438_MSE_NAPRAV.NAIMENOVAN_ADRES_OBR_ORG NAIMENOVAN_ADRES_OBR_ORG,
  DATA_W438_MSE_NAPRAV.KURS_KLASS,
  DATA_W438_MSE_NAPRAV.OBUCH_SPECIALNOST_PROFESSIYA,
  DATA_W438_MSE_NAPRAV.RABOTA,
  DATA_W438_MSE_NAPRAV.SVEDENIYA_RABOTA,
  DATA_W438_MSE_NAPRAV.PROFESSIYA,
  DATA_W438_MSE_NAPRAV.KVALIFIKACIYA,
  DATA_W438_MSE_NAPRAV.STAG_RABOTI,
  DATA_W438_MSE_NAPRAV.VIPOLNYAEMAYA_RABOTA,
  DATA_W438_MSE_NAPRAV.USLOVIYA_RABOTI,
  DATA_W438_MSE_NAPRAV.MESTO_RABOTI,
  DATA_W438_MSE_NAPRAV.ADRES_RABOTI,
  DATA_W438_MSE_NAPRAV.NABLUDAETSYA,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.ANAMNEZ_ZHIZNI) ANAMNEZ_ZHIZNI,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.ANAMNEZ_ZABOL) ANAMNEZ_ZABOL,
  DATA_W438_MSE_NAPRAV.NALICH_ELN,
  DATA_W438_MSE_NAPRAV.NOMER_ELN,
  DATA_W438_MSE_NAPRAV.NOMER_PROG,
  DATA_W438_MSE_NAPRAV.NOMER_PROTOKOLA_K_PROGR,
  DATA_W438_MSE_NAPRAV.DATA_MSE_K_PROGR,
  DATA_W438_MSE_NAPRAV.VOSTANOVLENIE,
  DATA_W438_MSE_NAPRAV.VOSTANOVLENIE_VIBOR,
  DATA_W438_MSE_NAPRAV.DOSTIGENIE,
  DATA_W438_MSE_NAPRAV.DOSTIGENIE_VIBOR,
  DATA_W438_MSE_NAPRAV.ROST,
  DATA_W438_MSE_NAPRAV.VES,
  DATA_W438_MSE_NAPRAV.INDEX_MT,
  DATA_W438_MSE_NAPRAV.TELOSLOGENIE,
  DATA_W438_MSE_NAPRAV.ML_FIZ_OTPRAV,
  DATA_W438_MSE_NAPRAV.TALIYA_BEDRA,
  DATA_W438_MSE_NAPRAV.VES_DO_3,
  DATA_W438_MSE_NAPRAV.FIZ_RAZV,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SOST_ZDOROV) SOST_ZDOROV,
  --CONVERT(NVARCHAR(200), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED) SVED_O_OBSLED,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.OSNOVN_D) OSNOVN_D,
  DATA_W438_MSE_NAPRAV.KOD_OSNOVN_D,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.OSLOGN_OSNOVN_D) OSLOGN_OSNOVN_D,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SOPUT_D) SOPUT_D,
  DATA_W438_MSE_NAPRAV.KOD_SOPUT,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.OSLOGN_SOPUT_D) OSLOGN_SOPUT_D,
  DATA_W438_MSE_NAPRAV.KLINICH_PROGNOZ,
  DATA_W438_MSE_NAPRAV.REABILIT_POTENC,
  DATA_W438_MSE_NAPRAV.REABILIT_PROGNOZ,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.MEROPR_REAB) MEROPR_REAB,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.MEROPR_HIRURG) MEROPR_HIRURG,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.MEROPR_PROTEZ) MEROPR_PROTEZ,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SAN_KUR) SAN_KUR,
  DATA_W438_MSE_NAPRAV.REZULTAT_REAB_TEXT,
  CIM10_1.CODE CIM10_CODE,
  ((MEDECINS.NOM + ' '  + MEDECINS.PRENOM)) praedsedatel_vk,
  ((MEDECINS_1.NOM + ' ' + MEDECINS_1.PRENOM)) CHLEN_VK1,
  ((MEDECINS_2.NOM + ' ' + MEDECINS_2.PRENOM)) CHLEN_VK2,
  ((MEDECINS_3.NOM + ' ' + MEDECINS_3.PRENOM)) CHLEN_VK3,
  ((MEDECINS_4.NOM + ' ' + MEDECINS_4.PRENOM)) CHLEN_VK4,
  (CASE WHEN (DATEDIFF(mm,(SELECT NE_LE FROM PATIENTS WHERE PATIENTS_ID = @AF_CURRENT_PATIENT), GETDATE())) <= 12 THEN DATEDIFF(mm, (SELECT NE_LE FROM PATIENTS WHERE PATIENTS_ID = @AF_CURRENT_PATIENT), GETDATE()) ELSE '' END) AGE_1,
  PATIENTS.KRN_GUID ,
  MOTCONSU.LEHAHIJ_VRAH MEDECINS_CREATOR_ID,
  MEDECINS_CREATOR.SNILS MEDECINS_CREATOR_SNILS,
  NSI_DOLZGNOST.CODE_NSI_DOLZGNOST CODE_NSI_DOLZGNOST,
  NSI_DOLZGNOST.DOLZGNOST_MED_PERSONALA DOLZGNOST_MED_PERSONALA,
  MEDECINS_CREATOR.NOM MEDECINS_CREATOR_NOM,
  MEDECINS_CREATOR.PRENOM MEDECINS_CREATOR_PRENOM,
  DATA_INS_POLICIES_OMI.NOMER_POLISA NOMER_POLISA,
  SMO_TFOMS.OMS_SMORG_ID OMS_SMORG_ID,
  SMO_TFOMS.SHORT_LABEL SMO_LABEL,
  MEDECINS_4.MEDECINS_ID PREDSEDATEL_VK_ID,
  MEDECINS_4.SNILS PREDSEDATEL_SNILS,
  NSI_DOLZGNOST_PREDSEDATEL_VK.CODE_NSI_DOLZGNOST PREDSEDATEL_VK_CODE_DOLZGNOST,
  NSI_DOLZGNOST_PREDSEDATEL_VK.DOLZGNOST_MED_PERSONALA PREDSEDATEL_VK_DOLZGNOST,
  MEDECINS_4.NOM PREDSEDATEL_NOM,
  MEDECINS_4.PRENOM PREDSEDATEL_PRENOM,
  MEDECINS.MEDECINS_ID CHLEN_VK1_ID,
  MEDECINS.SNILS CHLEN_VK1_SNILS,
  NSI_DOLZGNOST_CHLEN_VK1.CODE_NSI_DOLZGNOST CHLEN_VK1_CODE_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK1.DOLZGNOST_MED_PERSONALA CHLEN_VK1_DOLZGNOST,
  MEDECINS.NOM CHLEN_VK1_NOM,
  MEDECINS.PRENOM CHLEN_VK1_PRENOM,
  MEDECINS_1.MEDECINS_ID CHLEN_VK2_ID,
  MEDECINS_1.SNILS CHLEN_VK2_SNILS,
  NSI_DOLZGNOST_CHLEN_VK2.CODE_NSI_DOLZGNOST CHLEN_VK2_CODE_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK2.DOLZGNOST_MED_PERSONALA CHLEN_VK2_DOLZGNOST,
  MEDECINS_1.NOM CHLEN_VK2_NOM,
  MEDECINS_1.PRENOM CHLEN_VK2_PRENOM,
  MEDECINS_2.MEDECINS_ID CHLEN_VK3_ID,
  MEDECINS_2.SNILS CHLEN_VK3_SNILS,
  NSI_DOLZGNOST_CHLEN_VK3.CODE_NSI_DOLZGNOST CHLEN_VK3_CODE_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK3.DOLZGNOST_MED_PERSONALA CHLEN_VK3_DOLZGNOST,
  MEDECINS_2.NOM CHLEN_VK3_NOM,
  MEDECINS_2.PRENOM CHLEN_VK3_PRENOM,
  MEDECINS_3.MEDECINS_ID CHLEN_VK4_ID,
  MEDECINS_3.SNILS CHLEN_VK4_SNILS,
  NSI_DOLZGNOST_CHLEN_VK4.CODE_NSI_DOLZGNOST CHLEN_VK4_CODE_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK4.DOLZGNOST_MED_PERSONALA CHLEN_VK4_DOLZGNOST,
  MEDECINS_3.NOM CHLEN_VK4_NOM,
  MEDECINS_3.PRENOM CHLEN_VK4_PRENOM,
  DATA_W438_MSE_NAPRAV.TALIYA,
  DATA_W438_MSE_NAPRAV.BEDRA,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED_LAB) SVED_O_OBSLED_LAB,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED_INSTR) SVED_O_OBSLED_INSTR,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED_KONSULT) SVED_O_OBSLED_KONSULT
--  ,convert(DATE,  motconsu.CREATE_DATE_TIME) CREATE_DATE_TIME
  
FROM DATA_W438_MSE_NAPRAV DATA_W438_MSE_NAPRAV WITH (NOLOCK)
LEFT OUTER JOIN DATA_W438_MISSION_MSE DATA_W438_MISSION_MSE WITH (NOLOCK)
  ON DATA_W438_MISSION_MSE.DATA_W438_MISSION_MSE_ID = DATA_W438_MSE_NAPRAV.MISSION
LEFT OUTER JOIN DATA_W438_PRICHINA_INVALID DATA_W438_PRICHINA_INVALID WITH (NOLOCK)
  ON DATA_W438_PRICHINA_INVALID.DATA_W438_PRICHINA_INVALID_ID = DATA_W438_MSE_NAPRAV.PRICHINA_INVALID
LEFT OUTER JOIN PATIENTS PATIENTS WITH (NOLOCK)
  ON PATIENTS.PATIENTS_ID = DATA_W438_MSE_NAPRAV.PATIENTS_ID
LEFT OUTER JOIN MOTCONSU MOTCONSU WITH (NOLOCK)
  ON PATIENTS.PATIENTS_ID = MOTCONSU.PATIENTS_ID AND MOTCONSU.MOTCONSU_ID = DATA_W438_MSE_NAPRAV.SLUCHAI_ZABOL
LEFT OUTER JOIN FM_ORG FM_ORG WITH (NOLOCK)
  ON FM_ORG.FM_ORG_ID = MOTCONSU.LPU
LEFT OUTER JOIN OMI_COUNTRY OMI_COUNTRY WITH (NOLOCK)
  ON OMI_COUNTRY.OMS_COUNTRY_ID = PATIENTS.STRANA1
LEFT OUTER JOIN ADR_OBLAST ADR_OBLAST WITH (NOLOCK)
  ON ADR_OBLAST.ADR_OBLAST_ID = PATIENTS.KOD_TERRITORII
LEFT OUTER JOIN DATA_FOR_LEGAL_REPRESENT DATA_FOR_LEGAL_REPRESENT WITH (NOLOCK)
  ON PATIENTS.PATIENTS_ID = DATA_FOR_LEGAL_REPRESENT.PATIENTS_ID
LEFT OUTER JOIN OMI_DOCTYPE OMI_DOCTYPE_1 WITH (NOLOCK)
  ON OMI_DOCTYPE_1.OMS_DOCTYPE_ID = DATA_FOR_LEGAL_REPRESENT.VID_DOKUMENTA
LEFT OUTER JOIN OMI_DOCTYPE OMI_DOCTYPE WITH (NOLOCK)
  ON OMI_DOCTYPE.OMS_DOCTYPE_ID = PATIENTS.VID_DOKUMENTA
LEFT OUTER JOIN CIM10 CIM10_1 WITH (NOLOCK)
  ON CIM10_1.CIM10_ID = DATA_W438_MSE_NAPRAV.KOD_OSNOVN_D
LEFT OUTER JOIN MEDECINS MEDECINS WITH (NOLOCK)
  ON MEDECINS.MEDECINS_ID = DATA_W438_MSE_NAPRAV.CHLEN_VK1
LEFT OUTER JOIN MEDECINS MEDECINS_1 WITH (NOLOCK)
  ON MEDECINS_1.MEDECINS_ID = DATA_W438_MSE_NAPRAV.CHLEN_VK2
LEFT OUTER JOIN MEDECINS MEDECINS_2 WITH (NOLOCK)
  ON MEDECINS_2.MEDECINS_ID = DATA_W438_MSE_NAPRAV.CHLEN_VK3
LEFT OUTER JOIN MEDECINS MEDECINS_3 WITH (NOLOCK)
  ON MEDECINS_3.MEDECINS_ID = DATA_W438_MSE_NAPRAV.CHLEN_VK4
LEFT OUTER JOIN MEDECINS MEDECINS_4 WITH (NOLOCK)
  ON MEDECINS_4.MEDECINS_ID = DATA_W438_MSE_NAPRAV.Predsedatel_VK
LEFT OUTER JOIN ADR_STREET ADR_STREET WITH (NOLOCK)
  ON ADR_STREET.ADR_STREET_ID = PATIENTS.ULICA_MOSKVA
LEFT OUTER JOIN ADR_STREET ADR_STREET_REG WITH (NOLOCK)
  ON ADR_STREET_REG.ADR_STREET_ID = PATIENTS.REG_STREET
LEFT OUTER JOIN MEDECINS MEDECINS_CREATOR WITH (NOLOCK)
  ON MEDECINS_CREATOR.MEDECINS_ID = MOTCONSU.LEHAHIJ_VRAH
LEFT OUTER JOIN SPECIALISATION SPECIALISATION WITH (NOLOCK)
  ON SPECIALISATION.SPECIALISATION_ID = MEDECINS_CREATOR.SPECIALISATION_ID
LEFT OUTER JOIN NSI_DOLZGNOST NSI_DOLZGNOST WITH (NOLOCK)
  ON SPECIALISATION.CODE_NSI_DOLZGNOST = NSI_DOLZGNOST.CODE_NSI_DOLZGNOST
LEFT OUTER JOIN DATA_INS_POLICIES_OMI DATA_INS_POLICIES_OMI WITH (NOLOCK)
  ON DATA_INS_POLICIES_OMI.PATIENTS_ID = PATIENTS.PATIENTS_ID
LEFT OUTER JOIN FM_ORG SMO_TFOMS WITH (NOLOCK)
  ON SMO_TFOMS.FM_ORG_ID = DATA_INS_POLICIES_OMI.SMO
LEFT OUTER JOIN SPECIALISATION SPECIALISATION_PREDSEDATEL_VK WITH (NOLOCK)
  ON SPECIALISATION_PREDSEDATEL_VK.SPECIALISATION_ID = MEDECINS_4.SPECIALISATION_ID
LEFT OUTER JOIN NSI_DOLZGNOST NSI_DOLZGNOST_PREDSEDATEL_VK WITH (NOLOCK)
  ON NSI_DOLZGNOST_PREDSEDATEL_VK.CODE_NSI_DOLZGNOST = NSI_DOLZGNOST.CODE_NSI_DOLZGNOST
LEFT OUTER JOIN SPECIALISATION SPECIALISATION_CHLEN_VK1 WITH (NOLOCK)
  ON SPECIALISATION_CHLEN_VK1.SPECIALISATION_ID = MEDECINS.SPECIALISATION_ID
LEFT OUTER JOIN NSI_DOLZGNOST NSI_DOLZGNOST_CHLEN_VK1 WITH (NOLOCK)
  ON NSI_DOLZGNOST_CHLEN_VK1.CODE_NSI_DOLZGNOST = NSI_DOLZGNOST.CODE_NSI_DOLZGNOST
LEFT OUTER JOIN SPECIALISATION SPECIALISATION_CHLEN_VK2 WITH (NOLOCK)
  ON SPECIALISATION_CHLEN_VK2.SPECIALISATION_ID = MEDECINS_1.SPECIALISATION_ID
LEFT OUTER JOIN NSI_DOLZGNOST NSI_DOLZGNOST_CHLEN_VK2 WITH (NOLOCK)
  ON NSI_DOLZGNOST_CHLEN_VK2.CODE_NSI_DOLZGNOST = NSI_DOLZGNOST.CODE_NSI_DOLZGNOST
LEFT OUTER JOIN SPECIALISATION SPECIALISATION_CHLEN_VK3 WITH (NOLOCK)
  ON SPECIALISATION_CHLEN_VK3.SPECIALISATION_ID = MEDECINS_2.SPECIALISATION_ID
LEFT OUTER JOIN NSI_DOLZGNOST NSI_DOLZGNOST_CHLEN_VK3 WITH (NOLOCK)
  ON NSI_DOLZGNOST_CHLEN_VK3.CODE_NSI_DOLZGNOST = NSI_DOLZGNOST.CODE_NSI_DOLZGNOST
LEFT OUTER JOIN SPECIALISATION SPECIALISATION_CHLEN_VK4 WITH (NOLOCK)
  ON SPECIALISATION_CHLEN_VK4.SPECIALISATION_ID = MEDECINS_3.SPECIALISATION_ID
LEFT OUTER JOIN NSI_DOLZGNOST NSI_DOLZGNOST_CHLEN_VK4 WITH (NOLOCK)
  ON NSI_DOLZGNOST_CHLEN_VK4.CODE_NSI_DOLZGNOST = NSI_DOLZGNOST.CODE_NSI_DOLZGNOST

  WHERE 
  DATA_W438_MSE_NAPRAV.PATIENTS_ID = @AF_CURRENT_PATIENT AND 
  DATA_W438_MSE_NAPRAV.MOTCONSU_ID = @AF_CURRENT_MOTCONSU

  GROUP BY DATA_W438_MSE_NAPRAV.DATE_CONSULTATION,
  DATA_W438_MSE_NAPRAV.NOMER_PROTOKOLA_VK,
  DATA_W438_MSE_NAPRAV.DATE_PROTOKOLA_VK,
  DATA_W438_MSE_NAPRAV.NA_DOMU,
  DATA_W438_MSE_NAPRAV.PALLIAT_MED_POM,
  DATA_W438_MSE_NAPRAV.DATE_CONSULTATION,
  DATA_W438_MISSION_MSE.NAIMENOVANIE,
  DATA_W438_MSE_NAPRAV.ANOTHER_MISSION,
  PATIENTS.NOM,
  PATIENTS.PRENOM,
  PATIENTS.PATRONYME,
  PATIENTS.NE_LE,
  PATIENTS.POL,
  DATA_W438_MSE_NAPRAV.GRAGDANSTVO,
  DATA_W438_MSE_NAPRAV.VOIN_OBYAZ,
  PATIENTS.DOM,
  PATIENTS.KORPUS,
  PATIENTS.STROENIE,
  PATIENTS.NASELENN_J_PUNKT,
  PATIENTS.KVARTIRA,
  PATIENTS.INDEKS,
  PATIENTS.ULICA,
  PATIENTS.ULICA_MOSKVA,
  OMI_COUNTRY.NAME,
  ADR_OBLAST.NAME,
  PATIENTS.RAJON,
  ADR_OBLAST.SOCR,
  DATA_W438_MSE_NAPRAV.BOMG,
  DATA_W438_MSE_NAPRAV.GRAZDANIN_NAHODITSYA,
  DATA_W438_MSE_NAPRAV.ADRESS_ORG,
  DATA_W438_MSE_NAPRAV.OGRN_ORG,
  PATIENTS.MOBIL_TELEFON,
  PATIENTS.E_MAIL,
  PATIENTS.SYS_SNILS,
  OMI_DOCTYPE.LABEL,
  PATIENTS.SERIQ_DOKUMENTA,
  PATIENTS.PASPORT_N,
  PATIENTS.KOGDA_V_DAN,
  PATIENTS.KEM_V_DAN,
  DATA_FOR_LEGAL_REPRESENT.FAMILIYA,
  DATA_FOR_LEGAL_REPRESENT.IMYA,
  DATA_FOR_LEGAL_REPRESENT.OTCHESTVO,
  DATA_FOR_LEGAL_REPRESENT.DOKUM_PREDSTAV_,
  DATA_FOR_LEGAL_REPRESENT.VYDAN_KEM_KOGDA,
  DATA_FOR_LEGAL_REPRESENT.NOMER_DOKUMENTA,
  DATA_FOR_LEGAL_REPRESENT.SERIYA_DOC_PODTV,
  DATA_FOR_LEGAL_REPRESENT.KOGDA_VIDAN_DOC_PODTV,
  OMI_DOCTYPE_1.LABEL,
  DATA_FOR_LEGAL_REPRESENT.PASPORT,
  DATA_FOR_LEGAL_REPRESENT.SERIQ_DOKUMENTA,
  DATA_FOR_LEGAL_REPRESENT.KOGDA_V_DAN,
  DATA_FOR_LEGAL_REPRESENT.KEM_VYDAN,
  DATA_FOR_LEGAL_REPRESENT.TELEFON,
  DATA_FOR_LEGAL_REPRESENT.E_MAIL,
  DATA_FOR_LEGAL_REPRESENT.SNILS,
  DATA_FOR_LEGAL_REPRESENT.NAME_FIRMA,
  DATA_FOR_LEGAL_REPRESENT.ADRES_FIRMA,
  DATA_FOR_LEGAL_REPRESENT.OGRN_FIRMA,
  DATA_W438_MSE_NAPRAV.PERV_POVTORN,
  DATA_W438_MSE_NAPRAV.INVALID,
  DATA_W438_MSE_NAPRAV.OKONCH_DEISTVIYA,
  DATA_W438_PRICHINA_INVALID.FORMULIROVKA_PRICHINY,
  DATA_W438_MSE_NAPRAV.PERIOD_INVALID,
  DATA_W438_MSE_NAPRAV.ANOTHER_PRICHINA,
  DATA_W438_MSE_NAPRAV.FORMULIROVKA_PRICHIN_INVALID,
  DATA_W438_MSE_NAPRAV.PRICHINA_INVALID,
  DATA_W438_MSE_NAPRAV.STEPEN_UTRATI,
  DATA_W438_MSE_NAPRAV.SROK_UTRATI,
  DATA_W438_MSE_NAPRAV.DATA_UTRATI,
  DATA_W438_MSE_NAPRAV.POVTOR_STEP_UTRATI_PROC_1,
  DATA_W438_MSE_NAPRAV.POVTOR_STEP_UTRATI_PROC_2,
  DATA_W438_MSE_NAPRAV.POVTOR_STEP_UTRATI_PROC_3,
  DATA_W438_MSE_NAPRAV.POVTOR_SROK_UTRATI_1,
  DATA_W438_MSE_NAPRAV.POVTOR_SROK_UTRATI_2,
  DATA_W438_MSE_NAPRAV.POVTOR_SROK_UTRATI_3,
  DATA_W438_MSE_NAPRAV.POVTOR_DATA_UTRATI_1,
  DATA_W438_MSE_NAPRAV.POVTOR_DATA_UTRATI_2,
  DATA_W438_MSE_NAPRAV.POVTOR_DATA_UTRATI_3,
  DATA_W438_MSE_NAPRAV.UCHEBA,
  DATA_W438_MSE_NAPRAV.NAIMENOVAN_ADRES_OBR_ORG,
  DATA_W438_MSE_NAPRAV.KURS_KLASS,
  DATA_W438_MSE_NAPRAV.OBUCH_SPECIALNOST_PROFESSIYA,
  DATA_W438_MSE_NAPRAV.RABOTA,
  DATA_W438_MSE_NAPRAV.SVEDENIYA_RABOTA,
  DATA_W438_MSE_NAPRAV.PROFESSIYA,
  DATA_W438_MSE_NAPRAV.KVALIFIKACIYA,
  DATA_W438_MSE_NAPRAV.STAG_RABOTI,
  DATA_W438_MSE_NAPRAV.VIPOLNYAEMAYA_RABOTA,
  DATA_W438_MSE_NAPRAV.USLOVIYA_RABOTI,
  DATA_W438_MSE_NAPRAV.MESTO_RABOTI,
  DATA_W438_MSE_NAPRAV.ADRES_RABOTI,
  DATA_W438_MSE_NAPRAV.NABLUDAETSYA,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.ANAMNEZ_ZHIZNI),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.ANAMNEZ_ZABOL),
  DATA_W438_MSE_NAPRAV.NALICH_ELN,
  DATA_W438_MSE_NAPRAV.NOMER_ELN,
  DATA_W438_MSE_NAPRAV.NOMER_PROG,
  DATA_W438_MSE_NAPRAV.NOMER_PROTOKOLA_K_PROGR,
  DATA_W438_MSE_NAPRAV.DATA_MSE_K_PROGR,
  DATA_W438_MSE_NAPRAV.VOSTANOVLENIE,
  DATA_W438_MSE_NAPRAV.VOSTANOVLENIE_VIBOR,
  DATA_W438_MSE_NAPRAV.DOSTIGENIE,
  DATA_W438_MSE_NAPRAV.DOSTIGENIE_VIBOR,
  DATA_W438_MSE_NAPRAV.ROST,
  DATA_W438_MSE_NAPRAV.VES,
  DATA_W438_MSE_NAPRAV.INDEX_MT,
  DATA_W438_MSE_NAPRAV.TELOSLOGENIE,
  DATA_W438_MSE_NAPRAV.ML_FIZ_OTPRAV,
  DATA_W438_MSE_NAPRAV.TALIYA_BEDRA,
  DATA_W438_MSE_NAPRAV.VES_DO_3,
  DATA_W438_MSE_NAPRAV.FIZ_RAZV,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SOST_ZDOROV),
  --CONVERT(NVARCHAR(200), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.OSNOVN_D),
  DATA_W438_MSE_NAPRAV.KOD_OSNOVN_D,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.OSLOGN_OSNOVN_D),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SOPUT_D),
  DATA_W438_MSE_NAPRAV.KOD_SOPUT,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.OSLOGN_SOPUT_D),
  DATA_W438_MSE_NAPRAV.KLINICH_PROGNOZ,
  DATA_W438_MSE_NAPRAV.REABILIT_POTENC,
  DATA_W438_MSE_NAPRAV.REABILIT_PROGNOZ,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.MEROPR_REAB),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.MEROPR_HIRURG),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.MEROPR_PROTEZ),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SAN_KUR),
  DATA_W438_MSE_NAPRAV.REZULTAT_REAB_TEXT,
  CIM10_1.CODE,
  MEDECINS.NOM,
  MEDECINS.PRENOM,
  MEDECINS_1.NOM,
  MEDECINS_1.PRENOM,
  MEDECINS_2.NOM,
  MEDECINS_2.PRENOM,
  MEDECINS_3.NOM,
  MEDECINS_3.PRENOM,
  MEDECINS_4.NOM,
  MEDECINS_4.PRENOM,
  PATIENTS.KRN_GUID,
  DATA_W438_MSE_NAPRAV.MOTCONSU_ID,
  DATA_W438_MSE_NAPRAV.KRN_CREATE_DATE,
  PATIENTS.VID_DOKUMENTA,
  PATIENTS.KOD_PODRAZDELENIYA,
  PATIENTS.REG_TERRITORY,
  PATIENTS.KOD_TERRITORII,
  ADR_STREET.INDEKS,
  PATIENTS.REG_SETTLEMENT_TEXT,
  ADR_STREET_REG.INDEKS,
  PATIENTS.REG_STREET_TEXT,
  PATIENTS.REG_HOUSE,
  PATIENTS.REG_HOUSING,
  PATIENTS.REG_BUILDING,
  PATIENTS.REG_FLAT,
  DATA_W438_MSE_NAPRAV.KRN_MODIFY_DATE,
  MOTCONSU.LEHAHIJ_VRAH,
  MEDECINS_CREATOR.SNILS,
  NSI_DOLZGNOST.CODE_NSI_DOLZGNOST,
  NSI_DOLZGNOST.DOLZGNOST_MED_PERSONALA,
  MEDECINS_CREATOR.NOM,
  MEDECINS_CREATOR.PRENOM,
  DATA_INS_POLICIES_OMI.NOMER_POLISA,
  SMO_TFOMS.OMS_SMORG_ID,
  SMO_TFOMS.SHORT_LABEL,
  MEDECINS_4.MEDECINS_ID,
  MEDECINS_4.SNILS,
  NSI_DOLZGNOST_PREDSEDATEL_VK.CODE_NSI_DOLZGNOST,
  NSI_DOLZGNOST_PREDSEDATEL_VK.DOLZGNOST_MED_PERSONALA,
  MEDECINS_4.NOM,
  MEDECINS_4.PRENOM,
  MEDECINS.MEDECINS_ID,
  MEDECINS.SNILS,
  NSI_DOLZGNOST_CHLEN_VK1.CODE_NSI_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK1.DOLZGNOST_MED_PERSONALA,
  MEDECINS.NOM,
  MEDECINS.PRENOM,
  MEDECINS_1.MEDECINS_ID,
  MEDECINS_1.SNILS,
  NSI_DOLZGNOST_CHLEN_VK2.CODE_NSI_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK2.DOLZGNOST_MED_PERSONALA,
  MEDECINS_1.NOM,
  MEDECINS_1.PRENOM,
  MEDECINS_2.MEDECINS_ID,
  MEDECINS_2.SNILS,
  NSI_DOLZGNOST_CHLEN_VK3.CODE_NSI_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK3.DOLZGNOST_MED_PERSONALA,
  MEDECINS_2.NOM,
  MEDECINS_2.PRENOM,
  MEDECINS_3.MEDECINS_ID,
  MEDECINS_3.SNILS,
  NSI_DOLZGNOST_CHLEN_VK4.CODE_NSI_DOLZGNOST,
  NSI_DOLZGNOST_CHLEN_VK4.DOLZGNOST_MED_PERSONALA,
  MEDECINS_3.NOM,
  MEDECINS_3.PRENOM,
  DATA_W438_MSE_NAPRAV.MISSION,
  DATA_W438_MSE_NAPRAV.TALIYA,
  DATA_W438_MSE_NAPRAV.BEDRA,
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED_LAB),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED_INSTR),
  CONVERT(NVARCHAR(4000), DATA_W438_MSE_NAPRAV.SVED_O_OBSLED_KONSULT)
--  ,convert(DATE,  motconsu.CREATE_DATE_TIME)
  

  ) mse
	

END

GO


ALTER VIEW [dbo].[view_emk3_MedicalStaff]
----��������� ashur 09.12.2021 � IdPosition �������� ��������� spec.DOLZGNOST �� SPEC.CODE_NSI_DOLZGNOST (������� �� iemk 5)
 AS
SELECT SPEC.Nsi_specialisation_ID as [IdSpeciality]
				--/DoctorInCharge	IdPosition	 	1..1	unsignedShort	������������� ��������� ����� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
				,SPEC.CODE_NSI_DOLZGNOST as [IdPosition] -- �������� � ������� SPECIALISATION ����� ������� DOLZGNOST int, �������� ������������� �� ������������ 1.2.643.5.1.13.2.1.1.607 -- ������� ������ �� ���������� �������� � �������� � ��

				--/DoctorInCharge/Person	 	1..1	 	���������� � ������� (�����)
					--/Person	Sex	 	0..1	unsignedByte	��� ���� (������������� ������� ��������������, OID 1.2.643.5.1.13.2.1.1.156)
					--�� ������������, ����� �������� ��� ���� ������
					--/Person	BirthDate	 	0..1	Datetime	���� ��������
					,med.DATA_ROGDENIQ  [BirthDate]
					--�� ������������, ����� ��������
					--/Person	IdPersonMis	 	1..1	String	������������� ����� � ���
					,MED.MEDECINS_ID as [IdPersonMis] -- ��������� ������������ GUID, ����� � MEDECINS_ID
						--/Person/HumanName	 	1..1	 	��� �����
							--/HumanName	FamilyName	 	1..1	String	������� �����
							,(select ltrim(rtrim(MED.NOM))) AS [FamilyName]
							--/HumanName	GivenName	 	1..1	String	��� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, 0, charindex(' ', MED.PRENOM))))) as [GivenName]
							--/HumanName	MiddleName	 	0..1	String	�������� �����
							,(select ltrim(rtrim(substring(MED.PRENOM, charindex(' ', MED.PRENOM) +1, (len(MED.PRENOM) + charindex(' ', MED.PRENOM)))))) AS [MiddleName] --�� ������������ - ������� ������� ����� ������� � MED.PRENOM
						--/Person/Documents/IdentityDocument	 	0..*	 	���������� � ���������� ��������� ������ � ����� (������ ����������� ���������� ���������� ��������). ���������� ���������� � ����� (��� �� ������� � ���).
							--/DocumentDto	IdDocumentType	 	1..1	unsignedByte	��� ���� ��������� (OID �����������: 1.2.643.2.69.1.1.1.6)
							,223 as [IdDocumentType] -- ��� ��������� - �����
							--/DocumentDto	DocN	 	1..1	String	����� ���������. �� ������ �������������� ����������� (�������, ���� � �.�.)
							,MED.SYS_SNILS as [DocN] -- ����� ������ ������� ��� �������� � ����
							--/DocumentDto	ProviderName	 	1..1	String	������������ �����������, �������� ��������
							,'���' as [ProviderName] -- �����������, �������� ��������
							,sd.MEDECINS_ID
							,sd.SIGN_TYPE
							,sd.MOTCONSU_ID
							,sd.SIGN_ROLE
							,sd.SIGN_BODY
FROM MEDECINS MED 
JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
JOIN SIGN_DATA AS sd ON sd.MEDECINS_ID = MED.MEDECINS_ID

GO


GRANT INSERT ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO
use [R_EMISZKO_PONYROVSKAYA]
GO
GRANT SELECT ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO
use [R_EMISZKO_PONYROVSKAYA]
GO
GRANT ALTER ON [dbo].[view_emk3_MedicalStaff] TO [iemk_user]
GO





