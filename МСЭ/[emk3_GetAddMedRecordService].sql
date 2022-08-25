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


