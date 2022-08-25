
CREATE PROCEDURE [dbo].[emk5_AddMedRecordEpikriz]
@IdCaseMis INT
AS
BEGIN
	--exec [[emk5_AddMedRecordNapr057]]
	

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
									,(SELECT sd.BODY FROM SIGN_DATA AS sd WHERE sd.MOTCONSU_ID = MOT.MOTCONSU_ID AND sd.SIGN_ROLE = 'ORG' AND sd.SIGN_TYPE = 'EPIKRIZ')as Base64binary
									--,MOT.MSE_BodyPreparedReport as Base64binary
									,(SELECT sd.SIGN_BODY FROM SIGN_DATA AS sd WHERE sd.MOTCONSU_ID = MOT.MOTCONSU_ID AND sd.SIGN_ROLE = 'ORG' AND sd.SIGN_TYPE = 'EPIKRIZ')as OrganizationSign
									--,MOT.MSE_ECP_SIGN_DATA_ORG as OrganizationSign
									,(SELECT sd.SIGN_BODY FROM SIGN_DATA AS sd WHERE sd.MOTCONSU_ID = MOT.MOTCONSU_ID AND sd.SIGN_ROLE = 'DOCTOR' AND sd.SIGN_TYPE = 'EPIKRIZ')as PersonalSigns
									--,MOT.MSE_ECP_SIGN_DATA as PersonalSigns
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
						--Header	1..1	string	������� �� ��������� (������� ��������)
						,(CASE WHEN isnull(DOC.Description, '') = '' THEN '������� �� ������������ ������ ������������ ' + convert(varchar(19), MOT.DATE_CONSULTATION, 121) ELSE DOC.Description END) AS Header
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
