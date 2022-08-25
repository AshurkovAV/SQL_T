--DECLARE @schet INT = 2068
--SELECT * FROM ReestrMedOrgDb AS rmod

DECLARE @ReestrMedOrgID INT = 5151 ---ID ������ ������� �� c����� �����
DECLARE @docTab TABLE (id INT, NAME NVARCHAR(50))
--INSERT INTO @docTab(id,NAME)VALUES(331,'������')
INSERT INTO @docTab(id,NAME)VALUES(444,'��������� �.�.')
INSERT INTO @docTab(id,NAME)VALUES(50,'����������')
INSERT INTO @docTab(id,NAME)VALUES(443,'�����������') 
--INSERT INTO @docTab(id,NAME)VALUES(88,'���������� �') --��������� ������
INSERT INTO @docTab(id,NAME)VALUES(406,'���������� �')
INSERT INTO @docTab(id,NAME)VALUES(216,'������ �')
INSERT INTO @docTab(id,NAME)VALUES(13,'������� �')
INSERT INTO @docTab(id,NAME)VALUES(365,'������ �.�.')
INSERT INTO @docTab(id,NAME)VALUES(77,'�������� �.�.')
INSERT INTO @docTab(id,NAME)VALUES(69,'�������� �.�.')
INSERT INTO @docTab(id,NAME)VALUES(350,'��������� �.�.')
INSERT INTO @docTab(id,NAME)VALUES(314,'�������� �.�.')


UPDATE pv SET pv.Doctor = 314 FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor = 766

/*******************************************
 * ������ ��� ������
 *******************************************/
UPDATE pv SET TypeHelp = sd.VID_POM_ID
from PacientVisit pv 
LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON pv.Doctor = sd.ID
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab)
/*******************************************
  * ������ ������� � ������������� � ������� �������
  *******************************************/
UPDATE pv SET MSPID = sd.PRVS_ID, Profil = sd.PROFIL_ID, DetProfil = sd.DET_ID
from PacientVisit pv 
LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON pv.Doctor = sd.ID
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab)

/*******************************************
 * ������ ��� ������
 *******************************************/
UPDATE pv SET TypeSluch = CASE WHEN pv.TypeSluch = 3 THEN 1 
							   WHEN pv.TypeSluch = 2 THEN 3
						  ELSE 2 END 
FROM PacientVisit pv 
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab)

/*******************************************
 * ������ ��� ������
 *******************************************/
UPDATE pv SET pv.TypeSluch = 2
from PacientVisit pv 
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab) 
AND pv.MKB IN ('Z00.1', 'Z00.2', 'Z00.3', 'Z00.0', 'Z01.1', 'Z01.2', 'Z01.3', 'Z01.0', 'Z01.4', 'Z32.0','Z32.1','Z34.0','Z35.8', 'Z39.0','Z39.1') AND pv.TypeSluch = 1



--DECLARE @schet INT = 2076
--DECLARE @docTab TABLE (id INT, NAME NVARCHAR(50))
--INSERT INTO @docTab(id,NAME)VALUES(365,'������ �.�.')

/*******************************************
 * ������ ��� ������
 *******************************************/
--UPDATE ds SET P_CEL = '1.1'
--FROM D3_ZSL AS dz
--JOIN D3_SL AS ds ON ds.D3_ZSLID = dz.id
--LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON ds.IDDOKT = sd.SNILS
--WHERE dz.D3_SCID = @schet AND ds.P_CEL IN ('1.3') AND ds.DS1 IN ('Z00.1', 'Z00.2', 'Z00.3', 'Z00.0', 'Z01.1', 'Z01.2', 'Z01.3', 'Z01.0') 
--and sd.ID IN (SELECT id FROM @docTab)


-------- ������ ������� � �������������--------
--UPDATE ds SET PRVS = sd.PRVS_ID, PROFIL = sd.PROFIL_ID, DET = sd.DET_ID
--FROM D3_ZSL AS dz
--JOIN D3_SL AS ds ON ds.D3_ZSLID = dz.id
--LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON ds.IDDOKT = sd.SNILS
--WHERE dz.D3_SCID = @schet AND dz.OS_SLUCH_REGION IS NULL and sd.ID IN (SELECT id FROM @docTab)
--------������ ��� ������--------
--UPDATE dz SET VIDPOM = sd.VID_POM_ID
--FROM D3_ZSL AS dz
--JOIN D3_SL AS ds ON ds.D3_ZSLID = dz.id
--LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON ds.IDDOKT = sd.SNILS
--WHERE dz.D3_SCID = @schet AND dz.OS_SLUCH_REGION IS NULL and sd.ID IN (SELECT id FROM @docTab)