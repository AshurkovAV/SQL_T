
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



CREATE PROCEDURE [dbo].[Getepicriz_po_zak_sluch] 
	@motconsu_id int
AS
BEGIN
	--DECLARE @motconsu INT = 1496975
  SELECT
	--������ ��������
	  da.MOTCONSU_ID 'MOTCONSU_ID ',
		REPLACE((convert(varchar(10),da.DATE_CONSULTATION,112) + convert(varchar(5), convert(time,
		da.DATE_CONSULTATION))), ':','') + '+0300' AS'effectiveTime_value',
    da.PATIENTS_ID as 'PATIENTS_ID',
    da.SNILS_PACIENTA AS 'SNILS_PATIENTS',
		pat.NOM AS 'PATIENTS_NOM',
    pat.PRENOM AS 'PATIENTS_PRENOM',
     pat.PATRONYME AS 'PATIENTS_PATRONYME',
	  CONVERT(VARCHAR(10), pat.ne_le, 112) AS 'BirthTime_Value',
		(select case 
		when pat.POL=0 THEN '1'
		when pat.POL=1 THEN '2'
		ELSE '�� ���������' 
		END) AS 'PATIENTS_POL_CODE',
		(select case 
		when pat.POL=0 THEN '�������'
		when pat.POL=1 THEN '�������'
		ELSE '�� ���������' 
		END) AS 'PATIENTS_POL',
		-- ������ �����������
		'nullFlavor="NI"' AS 'NI_nullFlavor',
	(SELECT IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1)  AS 'MO_OID',
	(SELECT ORGN FROM FM_ORG WHERE FM_ORG_ID = 1)  AS 'ORG_OGRN',
	'8(4712)-54-57-35' AS 'ORG_TELEFON',
		da.NAIMENOVANIE_MO AS 'ORG_NAME',
		da.ADRES_MO AS 'ADDRESS_ORG',
	 '46' AS 'providerOrganization_addr_state',
		--������ �����
   REPLACE((convert(varchar(10), da.DATE_CONSULTATION ,112) + convert(varchar(5), convert(time, da.DATE_CONSULTATION ))), ':','') + '+0300' AS 'AUTHOR_DATE_SIGN',
	 da.SNILS_VRACHA AS 'AUTHOR_SNILS',
		da.vrach AS 'AUTHOR_ID', 
		da.DOLZHNOST_VRACHA AS 'AUTHOR_DOLZGNOST_CODE',
    n.DOLZGNOST_MED_PERSONALA AS 'AUTHOR_DOLZGNOST_NAME',
		ltrim(rtrim(med.NOM)) AS 'AUTHOR_NOM',
    CASE WHEN LEN (ltrim(rtrim(substring(med.PRENOM, 0, charindex(' ', med.PRENOM))))) = 0 THEN med.PRENOM ELSE (    ltrim(rtrim(substring(med.PRENOM, 0, charindex(' ', med.PRENOM))))) END AS 'AUTHOR_PRENOM',
    ltrim(rtrim(substring(med.PRENOM, charindex(' ', med.PRENOM) +1, (len(med.PRENOM) + charindex(' ', med.PRENOM))))) AS 'AUTHOR_PATRONYME',
		 
			--������ ����������� �����
			REPLACE((convert(varchar(10), da.DATE_CONSULTATION ,112) + convert(varchar(5), convert(time, da.DATE_CONSULTATION))), ':','') + '+0300' AS 'SIGNED_DOCTOR_DATE_SIGN',
		da.ZAVEDUYUSCHIY AS 'SIGNED_DOCTOR_ID',
	     da.SNILS_ZAV_ AS 'SIGNED_DOCTOR_SNILS',
			da.DOLZHNOST_ZAV_ AS 'SIGNED_DOCTOR_ZAVEDUYSHII',
			nsz.DOLZGNOST_MED_PERSONALA AS 'NAME_DOCTOR_ZAVEDUYSHII',
	    ltrim(rtrim(meds.NOM)) AS 'DOCTOR_ZAVEDUYSHII_NOM',
    --                <!-- R [1..1] ��� -->
    CASE WHEN LEN (ltrim(rtrim(substring(meds.PRENOM, 0, charindex(' ', meds.PRENOM))))) = 0 THEN meds.PRENOM ELSE (ltrim(rtrim(substring(meds.PRENOM, 0, charindex(' ', meds.PRENOM))))) END AS 'DOCTOR_ZAVEDUYSHII_PRENOM',
    --                <!-- [1..1] �������� -->
    ltrim(rtrim(substring(meds.PRENOM, charindex(' ', meds.PRENOM) +1, (len(meds.PRENOM) + charindex(' ', meds.PRENOM))))) AS 'DOCTOR_ZAVEDUYSHII_PATRONYME',
		
   --����������� ��������� ������
	 da.ISTOCHNIK_OPLATY AS 'CODE_IST_OPL',
   nip.FULL_NAME AS 'NAME_IST_OPL',
	 
	 -- ��� ���������
	 	da.TIP_DOKUMENTA_OSNOVANIYA AS 'TYPE_OMS',
  ndo.NAME AS 'NAME_OMS',
	
	 -- ��� ������ ���
	 da.VID_POLISA_OMS AS  'TYPE_POLICE',
	 npt.NAME AS 'TYPE_POLICE_NAME',
	 
	 --- ����� 
	dipo.NOMER_POLISA AS 'PATIENTS_NOMER_POLISA',
	da.NAIMENOVANIE_SMO as 'ORG_NAME_STRAH',
	 convert(varchar(10), dipo.DATA_V_DAHI ,112) AS 'DATE_START',
	 --�������� � �������
		da.TIP_DOKUMENTIRUEMOGO_SOBY AS 'TYPE_CODE_SOB',
	  nts.TYPE AS 'NAME_DOC_SOB',
		REPLACE((convert(varchar(10), da.DATA_OTKRYTIYA_SLUCHAYA ,112) + convert(varchar(5), convert(time, da.DATA_OTKRYTIYA_SLUCHAYA ))), ':','') + '+0300' AS 'DATE_SLUCHAYA_START',
		REPLACE((convert(varchar(10), da.DATA_ZAKRYTIYA_SLUCHAYA ,112) + convert(varchar(5), convert(time, da.DATA_ZAKRYTIYA_SLUCHAYA ))), ':','') + '+0300' AS 'DATE_SLUCHAYA_END',
							
				--����� �������� ����������� ������
				da.FORMA_OKAZANIYA_MP AS 'CODE_FORM_POM',
				o14.FRMMPNAME AS 'NAME_FORM_POM',

				-- ��� ����������� ������
				da.VID_OKAZANIYA_MP AS 'CODE_VID_MP',
				o8.VMPNAME AS 'NAME_VID_MP',
				
				--������� �������� ����������� ������
				da.USLOVIYA_OKAZANIYA_MP AS 'CODE_USL_OK',
				o6.UMPNAME AS 'NAME_USL_OK',
				
				--�������� � ������ �������� ����������� ������
				da.MKB_SLUCHAYA AS 'CODE_MKB',
				(select case 
		      when da.PORYADOK_OBRASCHENIYA = 0 THEN '��������'
		      when da.PORYADOK_OBRASCHENIYA = 1 THEN '��������'
		      ELSE '�� ���������' 
		         END) AS  'NAME_P_OBR',
				da.CEL_ AS 'NAME_CEL_',
				ndo.NAME AS 'NAME_OMS',
				convert(varchar(10),da.DATE_CONSULTATION,112) AS 'DATE_SLUCHAYA',
				
				-- ������� ���������
				da.PORYADOK_OBRASCHENIYA AS 'CODE_P_OBR',
				da.DIAGNOZ_TEKST AS 'NAME_MKB'
				
FROM DATA_W438_EPIK_ZAK_AMB   da
LEFT JOIN MOTCONSU AS m ON m.MOTCONSU_ID = da.MOTCONSU_ID
LEFT JOIN PATIENTS AS pat ON pat.PATIENTS_ID = da.PATIENTS_ID
LEFT JOIN (SELECT * FROM DATA_INS_POLICIES_OMI WHERE IS_MAIN = 1 AND DEYSTVUYUSCHIY = 1) 
dipo ON dipo.PATIENTS_ID = pat.PATIENTS_ID
LEFT JOIN MEDECINS AS med ON med.MEDECINS_ID = da.vrach
LEFT JOIN NSI_DOLZGNOST AS n ON n.CODE_NSI_DOLZGNOST = da.DOLZHNOST_VRACHA
LEFT JOIN MEDECINS AS meds ON meds.MEDECINS_ID = da.ZAVEDUYUSCHIY
LEFT JOIN NSI_DOLZGNOST AS nsz ON nsz.CODE_NSI_DOLZGNOST=da.DOLZHNOST_ZAV_
LEFT JOIN  NSI_ISTOCHNIK_OPLATY AS nip ON nip.ID=da.ISTOCHNIK_OPLATY
LEFT JOIN NSI_DOCS_OSNOVANIE AS ndo ON ndo.ID = da.TIP_DOKUMENTA_OSNOVANIYA
LEFT JOIN NSI_OMS_POLICE_TYPE AS npt ON npt.ID = da.VID_POLISA_OMS
LEFT JOIN NSI_TYPE_SOBITIE AS nts ON nts.ID=da.TIP_DOKUMENTIRUEMOGO_SOBY
LEFT JOIN OMS_V014 AS o14 ON o14.OMS_V014_ID = da.FORMA_OKAZANIYA_MP
LEFT JOIN OMS_V008 AS o8 ON o8.OMS_V008_ID = da.VID_OKAZANIYA_MP
LEFT JOIN OMS_V006 AS o6 ON o6.OMS_V006_ID = 	da.USLOVIYA_OKAZANIYA_MP


WHERE da.MOTCONSU_ID = @motconsu_id
END

GO



GRANT EXECUTE ON [dbo].[Getepicriz_po_zak_sluch] TO [iemk_user]

GRANT ALTER ON [dbo].[Getepicriz_po_zak_sluch] TO [iemk_user]

GRANT CONTROL ON [dbo].[Getepicriz_po_zak_sluch] TO [iemk_user]
GO
