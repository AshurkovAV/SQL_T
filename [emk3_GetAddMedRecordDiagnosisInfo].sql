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
						,CASE WHEN instrum.DATA_W438_PROTOKOL_ISSLED_ID IS NOT NULL THEN cast(instrum.DATE_CONSULTATION as DATE)
                              ELSE (cast(DD.DATE_CONSULTATION as DATE)) END as DiagnosedDate
						--IdDiagnosisType	1..1	unsignedByte	������������� ������� �������� (��������� OID: 1.2.643.2.69.1.1.1.26)
						,1 AS IdDiagnosisType -- ��� ���� ���� ����� ��������
						--Comment	1..1	String	����������� � ��������
						,CASE WHEN instrum.DATA_W438_PROTOKOL_ISSLED_ID IS NOT NULL THEN instrum.PROTOKOL
                              ELSE MKB.DESCRIPTION END  AS Comment
						--DiagnosisChangeReason	0..1	unsignedByte	������� ��������� �������� (��� ����� ������������������� ��������) (���������� OID: 1.2.643.2.69.1.1.1.9)
						--DiagnosisStage	0..1	unsignedByte	������������� ����� ������������ �������� (���������� OID: 1.2.643.2.69.1.1.1.10)
						--IdDispensaryState	0..1	unsignedByte	������������� ��������� ������������� ����� �� ������� �������� (�����������) (���������� OID: 1.2.643.2.69.1.1.1.11)
						--IdTraumaType	0..1	unsignedByte	������������� ���� ����� (���������� OID: 1.2.643.2.69.1.1.1.12)
						--MESImplementationFeature	0..1	unsignedByte	������������� ����������� ���������� ��������� (���������� OID: 1.2.643.2.69.1.1.1.13)
						--MedicalStandard	0..1	int	��� ��������� ����� �������� ����������� ������ (���������� OID: 1.2.643.2.69.1.1.1.29
						--MkbCode	1..1	String	��� ����������� �� ���-10 (���������� OID: 1.2.643.2.69.1.1.1.2)
						,CASE WHEN instrum.DATA_W438_PROTOKOL_ISSLED_ID IS NOT NULL THEN MKB1.CODE
             ELSE MKB.CODE END AS MkbCode
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
LEFT JOIN DATA_W438_PROTOKOL_ISSLED instrum ON instrum.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN PATIENTS PAT on PAT.PATIENTS_ID = MOT.PATIENTS_ID
LEFT JOIN MEDECINS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH
LEFT JOIN SPECIALISATION SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID
LEFT JOIN DATA_MOTCONSU_BILLDET DMB on DMB.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOT.MOTCONSU_ID
LEFT JOIN CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
LEFT JOIN CIM10 MKB1 on MKB1.CIM10_ID = instrum.NAPRAVITEL_NYY_DIAGNOZ
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


