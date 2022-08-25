--UPDATE dso SET PROFIL = ysme.PROFIL_ID, PRVS = ysme.PRVS_ID, PRVS21 = ysme.PRVS_ID, DET = ysme.DET_ID
UPDATE dzo SET VIDPOM = ysme.VID_POM_ID, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
WHERE dzo.D3_SCID = 4209 AND dzo.EXP_COMENT LIKE '%Нет лицензии на профиль%'


 UPDATE dso SET p_cel25 = '2.1'
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3035 AND p_cel25 = '3.1' AND ds1 LIKE 'z%'
 
  UPDATE dso SET p_cel25 = '1.0'
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3035 AND p_cel25 = '2.1' AND ds1 NOT LIKE 'z%'
 
UPDATE s SET dn=1
FROM [D3_SCHET_OMS] sch									
join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.id=3035 
join D3_ZSL_OMS zs on zs.D3_PID=p.id
join D3_SL_OMS s on s.D3_ZSLID=zs.ID	
WHERE zs.EXP_COMENT LIKE '%Некорректно заполнено поле DN%' AND s.P_CEL = '1.3' AND dn=3
 
 UPDATE dzo SET FOR_POM = 2
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 2897 AND p_cel25 = '1.1' AND dzo.FOR_POM != 2
 
 UPDATE dzo SET FOR_POM = 3
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3035 AND p_cel25 = '1.3' AND dzo.FOR_POM = 2
 
 UPDATE dso SET p_cel25 = '1.0'
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3035 AND p_cel25 = '1.1' AND dzo.FOR_POM = 2
 
  
 UPDATE dzo SET FOR_POM = 3
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3035 AND p_cel25 = '3.0' AND dzo.FOR_POM = 2
 
  UPDATE dzo SET FOR_POM = 3
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3035 AND p_cel25 = '2.1' AND dzo.FOR_POM = 2 AND dso.DS1 LIKE 'Z%'
 
 UPDATE dso SET dn=1
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3035 AND p_cel25 = '1.3' AND dn = '3'
 
 
 UPDATE dso SET ED_COL = 5
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 8005 
--AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
----AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')
AND dzo.EXP_COMENT LIKE '%Количество единиц оплаты в случае не совпадает с количеством блоков услуг по случаю%'
 
 
 UPDATE dso SET p_cel25 = '1.0'
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 8029 AND dzo.EXP_COMENT LIKE '%В обращении менее двух посещений%'
 
 UPDATE dso SET p_cel25 = '2.1'
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 8014 AND dzo.EXP_COMENT LIKE '%Код МКБ10 только для профилактических случаев%'
 
  UPDATE dzo SET NPR_MO = 460026, NPR_DATE = DATEADD(DAY, -1, dzo.DATE_Z_1 ), EXP_COMENT = NULL
 --SELECT *
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 8029 AND dzo.EXP_COMENT LIKE '%Поля NPR_MO,NPR_DATE обязательны для заполнения%'
 
UPDATE dso SET C_ZAB = 3
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 8029 AND dzo.EXP_COMENT LIKE '%Характер заболевания не соответствует установленному диагнозу%'
AND dso.C_ZAB = 1

UPDATE dso SET C_ZAB = 1
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 8029 AND dzo.EXP_COMENT LIKE '%Характер заболевания не соответствует установленному диагнозу%'
AND dso.C_ZAB = 3

UPDATE dzo SET ISHOD = 304, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 8014 AND dzo.EXP_COMENT LIKE '%Несоответствие между установленным характером заболевания и исходом заболевания (С характером заболевания Острое - не может быть исход%'
AND dso.C_ZAB = 1 AND dzo.ISHOD = 302

UPDATE dzo SET ISHOD = 303, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 8014 AND dzo.EXP_COMENT LIKE '%Несоответствие между установленным характером заболевания и исходом заболевания (С характером заболевания "Хроническое" - не может быть исход заболевания "Выздоровление"%'
AND dso.C_ZAB = 3 AND dzo.ISHOD = 301
 

UPDATE dzo SET EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 6628 AND dzo.EXP_COMENT LIKE '%в АПП при диагнозе Z поле характер заболевания не заполняется%'

UPDATE dso SET P_CEL = '3.0', P_CEL25 = '3.0'
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 8005 AND dzo.EXP_COMENT LIKE '%Цель посещения по стоматологии не соответствует диагнозу%'
AND dso.P_CEL25='1.0'
 
 UPDATE dso SET P_CEL = '1.1', P_CEL25 = '1.1'
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 8014 AND dzo.EXP_COMENT LIKE  '%Форма помощи не соответствует цели%'
AND dso.P_CEL25 = '1.0'
AND dzo.FOR_POM = 2

 UPDATE dzo SET FOR_POM = 3, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 8014 AND dzo.EXP_COMENT LIKE  '%Форма помощи не применяется при данном условии оказания МП%'
AND dso.P_CEL25 IN( '1.0', '3.0')
AND dzo.FOR_POM = 1


--Lpu не равено коду CODE_MO
UPDATE dzo SET lpu = 460026
FROM D3_ZSL_OMS AS dzo
WHERE dzo.LPU <> 460026

UPDATE dzo SET FOR_POM = 3, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 8014 AND dzo.EXP_COMENT LIKE  '%Форма помощи не соответствует цели%'
AND dso.P_CEL25 = '3.0'
AND dzo.FOR_POM = 2

--для стоматологии лучше конечно изменить в медиалоге
UPDATE dzo SET VIDPOM = 11
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 4348 
AND dzo.EXP_COMENT LIKE  '%Вид МП не соответствует профилю лечения при заданном условии оказания МП(3,4%'
AND dso.PROFIL = 85
AND dzo.VIDPOM = 13
 
 UPDATE dpo SET VPOLIS = 3
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 8005 AND dzo.EXP_COMENT LIKE '%Не заполнено обязательное поле вид полиса VPOLIS в ПАЦИЕНТЕ%'
 
 UPDATE dpo SET SMO = 46002
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
WHERE dzo.D3_SCID = 4209 AND dzo.EXP_COMENT LIKE '%Некорректный код СМО%'

 UPDATE dzo SET LPU = 460026, EXP_COMENT = NULL
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
WHERE dzo.D3_SCID = 8029 AND dzo.EXP_COMENT LIKE '%LPU не равен CODE_MO;%'


UPDATE dzo SET LPU = 460026, EXP_COMENT = NULL
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
WHERE dzo.D3_SCID = 8045 AND LPU != 460026

UPDATE duo SET LPU = 460026
FROM D3_PACIENT_OMS AS dpo 
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 8045 AND duo.LPU != 460026


update dpo SET DOCTYPE = NULL, DOCSER = NULL, DOCNUM = NULL, DOCDATE = NULL, DOCORG = NULL
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dzo.D3_SCID = 7850 AND dzo.EXP_COMENT LIKE '%Серия паспорта РФ не соответствует маске 99 99 (из справочника НСИ F011)%'
AND dpo.VPOLIS = 3

 UPDATE dso SET DS0 = null
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 4345 AND dso.DS0 = ''
 
  UPDATE dso SET DS_ONK = 0
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 4345 AND dzo.EXP_COMENT LIKE '%Не заполнено поле подозрение на онкозаболевание DS_ONK%'
  AND dso.DS1 LIKE 'C%'
  
  
  UPDATE duo SET CODE_USL = REPLACE(duo.CODE_USL, '_d', ''), VID_VME = REPLACE(duo.VID_VME, '_d', '')
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 7850 AND dzo.EXP_COMENT LIKE '%Некорректный код услуги (значение поля VID_VME отсутствует в справочнике V001)%'
AND duo.CODE_USL LIKE '%_d'


UPDATE duo SET LPU = 460026
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 8005 AND dzo.EXP_COMENT LIKE '%Не заполнено обязательное поле LPU Код мед организации В УСЛУГЕ%'

  
    UPDATE dso SET DN = 1
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 6628 AND dzo.EXP_COMENT LIKE '%Не заполнено поле диспансерное наблюдение при цели посещения 1.3 или 2.2 DN%'
  
    UPDATE dzo SET NPR_MO = 460026, NPR_DATE = DATEADD(day, -2, dzo.DATE_Z_1), EXP_COMENT = NULL
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 8029 AND dzo.EXP_COMENT LIKE '%Поля NPR_MO,NPR_DAT%'
 
 UPDATE DZO SET LPU = 460026
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 7850 AND dzo.EXP_COMENT LIKE '%lpu%'
 
 INSERT INTO D3_CONS_OMS (D3_SLID, D3_SLGID, PR_CONS)
SELECT s.ID, s.SL_ID, 0
FROM [D3_SCHET_OMS] sch									
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.month=11
  and sch.id=@p1
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID	
 left join 	D3_DSS_OMS sd on sd.D3_SLID=s.id and sd.DS_TYPE=2	
 left join 	D3_CONS_OMS c on c.D3_SLID=s.id		
 --join 	D3_USL_OMS u on u.d3_slid=s.id 
WHERE 
  sch.SchetType like '%C%' --AND zs.usl_ok<>4
       AND (S.DS1 LIKE 'C%' OR S.DS1 between 'D00' AND 'D09.z' --OR (S.DS1 LIKE 'd70%' AND SD.DS LIKE 'C%')
	   )  
	and c.D3_SLID is null 
 
 

UPDATE dzo SET ISHOD = 304
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 3782 
AND dzo.EXP_COMENT LIKE '%ISHOD=306 поле RSLT%'
AND dzo.ISHOD = 306 AND dzo.RSLT = 304

UPDATE dzo SET RSLT = 314
--SELECT *
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 3782 
AND dzo.EXP_COMENT LIKE 'МЭК - Взаимное несоответствие исхода заболевания%'
AND dzo.ISHOD = 306 AND dzo.RSLT = 332
 
 --Диагноз не начинается на Z (кроме z03) при цели 2.1 медосмотр
 UPDATE sl SET P_CEL25 = '1.0'
 FROM [D3_SCHET_OMS] sch
       inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID] --AND sch.year=2019 AND sch.month=3
                     --AND sch.SchetType LIKE '%c%' --онко реестр
       inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID] 
       inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
 WHERE 
 	2861=zs.D3_SCID
 	-----
 	and p_cel25 LIKE '2.1' 
 	AND  (sl.ds1 NOT LIKE 'Z%' OR (sl.ds1 LIKE 'Z03%')) 
 	AND ISNULL(zs.MEK_COUNT,0)=0
 	
 	
 	--SELECT dzo.RSLT, dzo.ISHOD, *
 UPDATE dzo SET ISHOD = 304
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 8005
 AND dzo.EXP_COMENT LIKE '%несоответствие исхода заболевания, результата обращения%'
 AND dzo.RSLT = 304 AND ds1 NOT LIKE 'Z%'
 
 UPDATE dzo SET ISHOD = 301
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3033
 AND dzo.EXP_COMENT LIKE '%несоответствие исхода заболевания, результата обращения%'
 AND dzo.RSLT = 301 AND ds1 NOT LIKE 'Z%'
 
 UPDATE dzo SET RSLT = 314
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3033
 AND dzo.EXP_COMENT LIKE '%несоответствие исхода заболевания, результата обращения%'
 AND dzo.ISHOD = 306 AND ds1 LIKE 'Z%'
 
 
  UPDATE dzo SET FOR_POM = 3
-- SELECT *
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = 3033
 AND dzo.EXP_COMENT LIKE '%Форма помощи не соответствует цели%'
 AND dso.PROFIL = 68 AND dzo.FOR_POM = 2
 
 DECLARE @p1 INT=2189
 UPDATE zs SET VBR = 0
     from 
       D3_ZSL_oms zs
         join D3_SCHET_OMS sc on sc.id=zs.D3_SCID AND sc.id=@p1
         join D3_PACIENT_OMS p on p.ID = zs.D3_PID
        	
 WHERE  zs.vbr IS null AND  zs.OS_SLUCH_REGION IN (7,8,9,11,12,17,18,22,23,37,38,47,48,49)
 
 
 
 DECLARE @idschet INT = 4184
 --руденко
 UPDATE dso SET PROFIL = 85, PRVS = 208, DET = 0
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-012 65' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE duo SET PROFIL = 85, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-012 65' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE dzo SET VIDPOM = 11
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-012 65' AND dzo.OS_SLUCH_REGION IS NULL
 
 
 
 
 156-093-466 47
 
 UPDATE dso SET PROFIL = 20, PRVS = 21, DET = 1
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '171-630-886 68' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE dzo SET VIDPOM = 13
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '171-630-886 68' AND dzo.OS_SLUCH_REGION IS NULL


DECLARE  @idschet INT = 4184
--Горяйнова стоматолог
 UPDATE dso SET PROFIL = 89, PRVS = 71, DET = 0
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '130-622-063 01' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE duo SET PROFIL = 89, PRVS = 71
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '130-622-063 01' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE dzo SET VIDPOM = 13
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '130-622-063 01' AND dzo.OS_SLUCH_REGION IS NULL


 --80,'Павлова В. В.', 85, 208, '030-492-841 33', 0, 11, 
 UPDATE duo SET PROFIL = 85, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-008 69' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE dso SET PROFIL = 85, PRVS21 = 208, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-008 69' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE dzo SET VIDPOM = 11
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-008 69' AND dzo.OS_SLUCH_REGION IS NULL
 
 --84,'Токарева Н. В.', 85, 208, '029-198-009 70', 0, 11, 
 UPDATE duo SET PROFIL = 85, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-009 70' AND dzo.OS_SLUCH_REGION IS NULL
 
  UPDATE dso SET PROFIL = 85, PRVS21 = 208, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-009 70' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE dzo SET VIDPOM = 11
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-009 70' AND dzo.OS_SLUCH_REGION IS NULL
 
 --83,'Лысенко И. В.', 85, 208, '029-198-010 63', 0, 11, 
 UPDATE duo SET PROFIL = 85, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-010 63' AND dzo.OS_SLUCH_REGION IS NULL
 
   UPDATE dso SET PROFIL = 85, PRVS21 = 208, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
 WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-010 63' AND dzo.OS_SLUCH_REGION IS NULL
 
 UPDATE dzo SET VIDPOM = 11
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '029-198-010 63' AND dzo.OS_SLUCH_REGION IS NULL

--229,'Солодухина Т. А.', 85, 208, '037-931-145 61', 0, 11, 
UPDATE duo SET PROFIL = 85, PRVS = 208
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '037-931-145 61' AND dzo.OS_SLUCH_REGION IS NULL

   UPDATE dso SET PROFIL = 85, PRVS21 = 208, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '037-931-145 61' AND dzo.OS_SLUCH_REGION IS NULL

UPDATE dzo SET VIDPOM = 11
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '037-931-145 61' AND dzo.OS_SLUCH_REGION IS NULL

--267,'Татаренкова О. А.', 85, 208, '048-795-700 14', 0, 11, 
UPDATE duo SET PROFIL = 85, PRVS = 208
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '048-795-700 14' AND dzo.OS_SLUCH_REGION IS NULL

 UPDATE dso SET PROFIL = 85, PRVS21 = 208, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '048-795-700 14' AND dzo.OS_SLUCH_REGION IS NULL

UPDATE dzo SET VIDPOM = 11
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '048-795-700 14' AND dzo.OS_SLUCH_REGION IS NULL

--281,'Кондратьева Г. В.', 85, 208, '084-994-527 31', 0, 11, 
UPDATE duo SET PROFIL = 85, PRVS = 208
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '084-994-527 31' AND dzo.OS_SLUCH_REGION IS NULL

 UPDATE dso SET PROFIL = 85, PRVS21 = 208, PRVS = 208
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '084-994-527 31' AND dzo.OS_SLUCH_REGION IS NULL

UPDATE dzo SET VIDPOM = 11
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '084-994-527 31' AND dzo.OS_SLUCH_REGION IS NULL

--376,'Аскеров Р. С.', 89, 71, '136-172-011 26', 0, 13, 
UPDATE duo SET PROFIL = 89, PRVS = 71
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '136-172-011 26' AND dzo.OS_SLUCH_REGION IS NULL

 UPDATE dso SET PROFIL = 89, PRVS21 = 71, PRVS = 71, DET = 0
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '136-172-011 26' AND dzo.OS_SLUCH_REGION IS NULL

UPDATE dzo SET VIDPOM = 13
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '136-172-011 26' AND dzo.OS_SLUCH_REGION IS NULL

--525,'Хачатурова Л. Э.', 89, 71, '144-753-775 87', 0, 13, 
UPDATE duo SET PROFIL = 89, PRVS = 71
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '144-753-775 87' AND dzo.OS_SLUCH_REGION IS NULL

 UPDATE dso SET PROFIL = 89, PRVS21 = 71, PRVS = 71, DET = 0
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '144-753-775 87' AND dzo.OS_SLUCH_REGION IS NULL

UPDATE dzo SET VIDPOM = 13
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '144-753-775 87' AND dzo.OS_SLUCH_REGION IS NULL

--319,'Яцкий А. Г.', 90, 72, '107-381-134 32', 0, 13, 
UPDATE duo SET PROFIL = 90, PRVS = 72
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '107-381-134 32' AND dzo.OS_SLUCH_REGION IS NULL

 UPDATE dso SET PROFIL = 90, PRVS21 = 72, PRVS = 72, DET = 0
 FROM D3_ZSL_OMS AS dzo
 JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '107-381-134 32' AND dzo.OS_SLUCH_REGION IS NULL

UPDATE dzo SET VIDPOM = 13
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @idschet AND dso.IDDOKT = '107-381-134 32' AND dzo.OS_SLUCH_REGION IS NULL