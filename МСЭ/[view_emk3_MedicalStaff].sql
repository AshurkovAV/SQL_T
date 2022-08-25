CREATE VIEW [dbo].[view_emk3_MedicalStaff]
 AS
SELECT SPEC.Nsi_specialisation_ID as [IdSpeciality]
				--/DoctorInCharge	IdPosition	 	1..1	unsignedShort	������������� ��������� ����� (������������ ���������� ����������� ���������� � ���������������� ����������, OID 1.2.643.5.1.13.2.1.1.607)
				,SPEC.DOLZGNOST as [IdPosition] -- �������� � ������� SPECIALISATION ����� ������� DOLZGNOST int, �������� ������������� �� ������������ 1.2.643.5.1.13.2.1.1.607 -- ������� ������ �� ���������� �������� � �������� � ��

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



