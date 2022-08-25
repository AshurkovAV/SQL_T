--DECLARE @schet INT = 2068
--SELECT * FROM ReestrMedOrgDb AS rmod

DECLARE @ReestrMedOrgID INT = 5151 ---ID номера реестра из cтарой проги
DECLARE @docTab TABLE (id INT, NAME NVARCHAR(50))
--INSERT INTO @docTab(id,NAME)VALUES(331,'Плохих')
INSERT INTO @docTab(id,NAME)VALUES(444,'Алексеева Е.К.')
INSERT INTO @docTab(id,NAME)VALUES(50,'Новомлинец')
INSERT INTO @docTab(id,NAME)VALUES(443,'Бобровников') 
--INSERT INTO @docTab(id,NAME)VALUES(88,'Позднякова Ю') --дикретный отпуск
INSERT INTO @docTab(id,NAME)VALUES(406,'Афанасьева Л')
INSERT INTO @docTab(id,NAME)VALUES(216,'Савина С')
INSERT INTO @docTab(id,NAME)VALUES(13,'Лубкова С')
INSERT INTO @docTab(id,NAME)VALUES(365,'Грицай Ю.В.')
INSERT INTO @docTab(id,NAME)VALUES(77,'Шукорова Н.А.')
INSERT INTO @docTab(id,NAME)VALUES(69,'Любицкая Р.В.')
INSERT INTO @docTab(id,NAME)VALUES(350,'Прокопова О.С.')
INSERT INTO @docTab(id,NAME)VALUES(314,'Корокина Т.Ф.')


UPDATE pv SET pv.Doctor = 314 FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor = 766

/*******************************************
 * Меняем вид помощи
 *******************************************/
UPDATE pv SET TypeHelp = sd.VID_POM_ID
from PacientVisit pv 
LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON pv.Doctor = sd.ID
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab)
/*******************************************
  * Меняем профиль и специальность и детский профиль
  *******************************************/
UPDATE pv SET MSPID = sd.PRVS_ID, Profil = sd.PROFIL_ID, DetProfil = sd.DET_ID
from PacientVisit pv 
LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON pv.Doctor = sd.ID
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab)

/*******************************************
 * Меняем тип случая
 *******************************************/
UPDATE pv SET TypeSluch = CASE WHEN pv.TypeSluch = 3 THEN 1 
							   WHEN pv.TypeSluch = 2 THEN 3
						  ELSE 2 END 
FROM PacientVisit pv 
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab)

/*******************************************
 * Меняем тип случая
 *******************************************/
UPDATE pv SET pv.TypeSluch = 2
from PacientVisit pv 
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.Doctor IN (SELECT id FROM @docTab) 
AND pv.MKB IN ('Z00.1', 'Z00.2', 'Z00.3', 'Z00.0', 'Z01.1', 'Z01.2', 'Z01.3', 'Z01.0', 'Z01.4', 'Z32.0','Z32.1','Z34.0','Z35.8', 'Z39.0','Z39.1') AND pv.TypeSluch = 1



--DECLARE @schet INT = 2076
--DECLARE @docTab TABLE (id INT, NAME NVARCHAR(50))
--INSERT INTO @docTab(id,NAME)VALUES(365,'Грицай Ю.В.')

/*******************************************
 * Меняем тип случая
 *******************************************/
--UPDATE ds SET P_CEL = '1.1'
--FROM D3_ZSL AS dz
--JOIN D3_SL AS ds ON ds.D3_ZSLID = dz.id
--LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON ds.IDDOKT = sd.SNILS
--WHERE dz.D3_SCID = @schet AND ds.P_CEL IN ('1.3') AND ds.DS1 IN ('Z00.1', 'Z00.2', 'Z00.3', 'Z00.0', 'Z01.1', 'Z01.2', 'Z01.3', 'Z01.0') 
--and sd.ID IN (SELECT id FROM @docTab)


-------- меняем профиль и специальность--------
--UPDATE ds SET PRVS = sd.PRVS_ID, PROFIL = sd.PROFIL_ID, DET = sd.DET_ID
--FROM D3_ZSL AS dz
--JOIN D3_SL AS ds ON ds.D3_ZSLID = dz.id
--LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON ds.IDDOKT = sd.SNILS
--WHERE dz.D3_SCID = @schet AND dz.OS_SLUCH_REGION IS NULL and sd.ID IN (SELECT id FROM @docTab)
--------меняем вид помощи--------
--UPDATE dz SET VIDPOM = sd.VID_POM_ID
--FROM D3_ZSL AS dz
--JOIN D3_SL AS ds ON ds.D3_ZSLID = dz.id
--LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON ds.IDDOKT = sd.SNILS
--WHERE dz.D3_SCID = @schet AND dz.OS_SLUCH_REGION IS NULL and sd.ID IN (SELECT id FROM @docTab)