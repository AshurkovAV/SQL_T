-- DROP TABLE ZreestrEkonom092023_sank
 DECLARE @schetTab TABLE (id INT) 

INSERT INTO @schetTab(id)
SELECT id
FROM D3_SCHET_OMS AS dso
WHERE dso.[YEAR] = 2025 AND dso.[MONTH] = 6-- AND dso.NSCHET LIKE '%+%'

 
 DECLARE @d DATETIME = GETDATE()
 DECLARE @uet numeric(10,2)
 SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')
 
 --SELECT *
 --FROM ztemp_sankdop2025
	-- DROP TABLE ztemp_sankdop2025
										 --SELECT *
										 --INTO ztemp_sankdop2025
											--				FROM D3_SANK_OMS AS dso
											--				WHERE s_tip in (10,12) AND dso.S_DATE = '20250814' 
											--				AND  dso.ID IN (
											--								SELECT MAX(s.ID)
											--								FROM D3_SANK_OMS s 
											--								GROUP BY s.D3_ZSLGID)
 
-- DROP TABLE ztemp_sankdop2025
 
 SELECT *
 INTO ZreestrEkonom_sank06025_27
 FROM (
 

 SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV , sc.[YEAR] [Год], 
 CASE WHEN sc.[MONTH] IN (1,2,3) THEN 'Первый'
      WHEN sc.[MONTH] IN (4,5,6) THEN 'Второй'
      WHEN sc.[MONTH] IN (7,8,9) THEN 'Третий'
      WHEN sc.[MONTH] IN (10,11,12) THEN 'Четвертый' ELSE 'Что-то пошло не так' END [Квартал],
 sc.ID[номер счета], zsl.ID [номер законченного случая],  sl.ID[номер случая], 
 --pa.FAM + ' ' + im + ' ' + ot [Пациент], 
 pa.FAM, im, ot, 
 CASE WHEN pa.W = 1 THEN 'Мужской' ELSE 'Женский' END [пол],
 CASE 
 	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN 'муж 65+'
 	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN 'жен 60+'
 ELSE 'Все остальные' END [Пенсионеры],
 CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
 ELSE 'Дети' END [ВзДети],	
 (SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [Код смо], 
 pa.NPOLIS [Номер полиса], pa.DR [Дата рож.], DATEDIFF(dd, DR, @d)/365.2524 [Возраст на момент выписки], CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия], CAST(sc.DSCHET AS DATE) [Дата счета],
 NULL ksg, NULL [Вид высокотехнологичной медицинской помощи], 'ОМС' [Вид оплаты],
 (SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [Вид помощи],
 (SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [форма помощи],
 (SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
 NULL [Врач приемного отделения],
 NULL [В случае смерти указать основную причину],	
 NULL [Госпитализирован по поводу данного заболевания в текущем году],	
 NULL [Дата направления],
 NULL [Дефект догоспитального этапа],
 (SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз клинический заключительный], 
 NULL [Диагноз направившего учреждения],
 NULL [Диагноз патолого-анатомический],	
 NULL [Диагноз приемного отделения],	
 NULL [Доставлен в состоянии опьянения],	
NULL [Доставлен в стационар от начала заболевания],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [Профиль],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [Исход],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [Результат обследования],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[Кем направлен],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[Цель посящения],
NULL [Вид исследования],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[Код способа оплаты],
CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[Отделение],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[Региональный признак особого случая], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [Количество ед], 
1 [Количество], sl.TARIF [Тариф],
 
zsl.SUMV [Сумма выставленная], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS Койкодни, 2 OPLATA,
dso.S_SUM [Удержания], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' ') [комент],-- CASE WHEN dso.S_COM LIKE 'Терапевт <18 в пол. или <16 в стац%' THEN 'Терапевт <18 в пол. или <16 в стац. Некорректное выставление профиля' ELSE dso.S_COM END AS [Комментарий], 
MONTH(zsl.DATE_Z_2) [Месяц выбытия], dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
	JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
		JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
				INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
               FROM D3_ZSL_OMS zsl 
					JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
						JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
							JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --— and pa.SMO = @smo
               WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.P_CEL25 != '2.3'
               GROUP by zsl.id)
UNION 

 SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV , sc.[YEAR] [Год], 
 CASE WHEN sc.[MONTH] IN (1,2,3) THEN 'Первый'
      WHEN sc.[MONTH] IN (4,5,6) THEN 'Второй'
      WHEN sc.[MONTH] IN (7,8,9) THEN 'Третий'
      WHEN sc.[MONTH] IN (10,11,12) THEN 'Четвертый' ELSE 'Что-то пошло не так' END [Квартал],
 sc.ID[номер счета], zsl.ID [номер законченного случая],  sl.ID[номер случая], 
 --pa.FAM + ' ' + im + ' ' + ot [Пациент], 
 pa.FAM, im, ot, 
 CASE WHEN pa.W = 1 THEN 'Мужской' ELSE 'Женский' END [пол],
 CASE 
 	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN 'муж 65+'
 	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN 'жен 60+'
 ELSE 'Все остальные' END [Пенсионеры],
 CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
 ELSE 'Дети' END [ВзДети],	
 (SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [Код смо], 
 pa.NPOLIS [Номер полиса], pa.DR [Дата рож.], DATEDIFF(dd, DR, @d)/365.2524 [Возраст на момент выписки], CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия], CAST(sc.DSCHET AS DATE) [Дата счета],
 NULL ksg, NULL [Вид высокотехнологичной медицинской помощи], 'ОМС' [Вид оплаты],
 (SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [Вид помощи],
 (SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [форма помощи],
 (SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
 NULL [Врач приемного отделения],
 NULL [В случае смерти указать основную причину],	
 NULL [Госпитализирован по поводу данного заболевания в текущем году],	
 NULL [Дата направления],
 NULL [Дефект догоспитального этапа],
 (SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз клинический заключительный], 
 NULL [Диагноз направившего учреждения],
 NULL [Диагноз патолого-анатомический],	
 NULL [Диагноз приемного отделения],	
 NULL [Доставлен в состоянии опьянения],	
 NULL [Доставлен в стационар от начала заболевания],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [Профиль],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [Исход],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [Результат обследования],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[Кем направлен],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[Цель посящения],
(SELECT TOP 1 ms.name FROM medicalServices AS ms  WHERE ms.code_usl = duo.CODE_USL AND ms.dataEnd = '20241231')[Вид исследования],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[Код способа оплаты],
CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[Отделение],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[Региональный признак особого случая], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
CASE WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [Количество ед], 
1 [Количество], sl.TARIF [Тариф],
 
zsl.SUMV [Сумма выставленная], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS Койкодни, 2 OPLATA,
dso.S_SUM [Удержания], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' ') [комент],-- CASE WHEN dso.S_COM LIKE 'Терапевт <18 в пол. или <16 в стац%' THEN 'Терапевт <18 в пол. или <16 в стац. Некорректное выставление профиля' ELSE dso.S_COM END AS [Комментарий], 
MONTH(zsl.DATE_Z_2) [Месяц выбытия] , dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
	JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
		JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
				JOIN D3_USL_OMS AS duo ON duo.D3_SLID = sl.ID
					INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
               FROM D3_ZSL_OMS zsl 
					JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
						JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
							JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --— and pa.SMO = @smo
               WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.P_CEL25 = '2.3'
               GROUP by zsl.id)

UNION 

SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV, sc.[YEAR] [Год], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN 'Первый'
     WHEN sc.[MONTH] IN (4,5,6) THEN 'Второй'
     WHEN sc.[MONTH] IN (7,8,9) THEN 'Третий'
     WHEN sc.[MONTH] IN (10,11,12) THEN 'Четвертый' ELSE 'Что-то пошло не так' END [Квартал],
sc.ID[номер счета],  zsl.ID [номер законченного случая], sl.ID[номер случая], 
--pa.FAM + ' ' + im + ' ' + ot [Пациент], 
pa.FAM, im, ot,
CASE WHEN pa.W = 1 THEN 'Мужской' ELSE 'Женский' END [пол],
CASE 
	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN 'муж 65+'
	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN 'жен 60+'
ELSE 'Все остальные' END [Пенсионеры],
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],	
(SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [Код смо], 
pa.NPOLIS [Номер полиса], pa.DR [Дата рож.], DATEDIFF(dd, DR, @d)/365.2524 [Возраст на момент выписки], CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия], CAST(sc.DSCHET AS DATE) [Дата счета],
NULL ksg, NULL [Вид высокотехнологичной медицинской помощи], 'ОМС' [Вид оплаты],
(SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [Вид помощи],
(SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [форма помощи],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
NULL [Врач приемного отделения],
NULL [В случае смерти указать основную причину],	
NULL [Госпитализирован по поводу данного заболевания в текущем году],	
NULL [Дата направления],
NULL [Дефект догоспитального этапа],
(SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз клинический заключительный], 
NULL [Диагноз направившего учреждения],
NULL [Диагноз патолого-анатомический],	
NULL [Диагноз приемного отделения],	
NULL [Доставлен в состоянии опьянения],	
NULL [Доставлен в стационар от начала заболевания],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [Профиль],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [Исход],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [Результат обследования],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[Кем направлен],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[Цель посящения],
NULL [Вид исследования],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[Код способа оплаты],
CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[Отделение],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[Региональный признак особого случая], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [Количество ед], 
1 [Количество],
sl.TARIF [Тариф], 

CASE WHEN zsl.OS_SLUCH_REGION NOT IN (11, 17, 7) THEN zsl.SUMV
	ELSE CASE WHEN zsl.OS_SLUCH_REGION IN (11,17,7) AND sl.PROFIL IN (68) THEN zsl.SUMV ELSE 0 END
	END [Сумма выставленная], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS Койкодни, 2 OPLATA,
dso.S_SUM [Удержания],replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' '),-- CASE WHEN dso.S_COM LIKE 'Терапевт <18 в пол. или <16 в стац%' THEN 'Терапевт <18 в пол. или <16 в стац. Некорректное выставление профиля' ELSE dso.S_COM END AS [Комментарий],
MONTH(zsl.DATE_Z_2) [Месяц выбытия] , dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
JOIN ( SELECT * FROM D3_SL_OMS WHERE id IN (SELECT MAX(dso.id)id
											FROM D3_ZSL_OMS AS dzo
												JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
											WHERE dzo.OS_SLUCH_REGION IS NOT NULL AND dzo.D3_SCID IN (SELECT id FROM @schetTab)
                                            GROUP BY dso.D3_ZSLID, dso.PROFIL
											)) sl ON zsl.ID = sl.D3_ZSLID
	JOIN D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
		JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID 
			INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NOT NULL

UNION


/*******************************************
 * Отдельно посещения в обращении
 *******************************************/
 
 SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV, sc.[YEAR] [Год], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN 'Первый'
     WHEN sc.[MONTH] IN (4,5,6) THEN 'Второй'
     WHEN sc.[MONTH] IN (7,8,9) THEN 'Третий'
     WHEN sc.[MONTH] IN (10,11,12) THEN 'Четвертый' ELSE 'Что-то пошло не так' END [Квартал],
sc.ID[номер счета],  zsl.ID [номер законченного случая], sl.ID[номер случая], 
--pa.FAM + ' ' + im + ' ' + ot [Пациент], 
pa.FAM, im, ot,
CASE WHEN pa.W = 1 THEN 'Мужской' ELSE 'Женский' END [пол],
CASE 
	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN 'муж 65+'
	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN 'жен 60+'
ELSE 'Все остальные' END [Пенсионеры],
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],	
(SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [Код смо], 
pa.NPOLIS [Номер полиса], pa.DR [Дата рож.], DATEDIFF(dd, DR, @d)/365.2524 [Возраст на момент выписки], CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия], CAST(sc.DSCHET AS DATE) [Дата счета],
NULL ksg, NULL [Вид высокотехнологичной медицинской помощи], 'ОМС' [Вид оплаты],
(SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [Вид помощи],
(SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [форма помощи],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
NULL [Врач приемного отделения],
NULL [В случае смерти указать основную причину],	
NULL [Госпитализирован по поводу данного заболевания в текущем году],	
NULL [Дата направления],
NULL [Дефект догоспитального этапа],
(SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз клинический заключительный], 
NULL [Диагноз направившего учреждения],
NULL [Диагноз патолого-анатомический],	
NULL [Диагноз приемного отделения],	
NULL [Доставлен в состоянии опьянения],	
NULL [Доставлен в стационар от начала заболевания],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [Профиль],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [Исход],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [Результат обследования],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[Кем направлен],
('4.0 Посещение в обращении')[Цель посящения],
NULL [Вид исследования],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[Код способа оплаты],
CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[Отделение],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[Региональный признак особого случая], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [Количество ед], 
1 [Количество],
sl.TARIF [Тариф], zsl.SUMV[Сумма выставленная], 
DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS Койкодни, 2 OPLATA,
dso.S_SUM [Удержания], replace(replace(dso.S_COM,char(13),' '), CHAR(10), ' '),--CASE WHEN replace(dso.S_COM,char(13),' ') LIKE 'Терапевт <18 в пол. или <16 в стац%' THEN 'Терапевт <18 в пол. или <16 в стац. Некорректное выставление профиля' ELSE dso.S_COM END AS [Комментарий],
MONTH(zsl.DATE_Z_2) [Месяц выбытия] , dso.S_TIP, dso.S_DATE
from D3_ZSL_OMS zsl 
	join D3_SL_OMS sl on zsl.ID = sl.D3_ZSLID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			join D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID 
				INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.P_CEL25 = '3.0'

UNION ALL

----Стационар и дневной стационар
SELECT (SELECT s.NameWithID
    FROM Yamed_Spr_SchetType s WHERE s.ID = sc.SchetType)SchetType, 
    zsl.PR_NOV, sc.[YEAR] [Год], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN 'Первый'
     WHEN sc.[MONTH] IN (4,5,6) THEN 'Второй'
     WHEN sc.[MONTH] IN (7,8,9) THEN 'Третий'
     WHEN sc.[MONTH] IN (10,11,12) THEN 'Четвертый' ELSE 'Что-то пошло не так' END [Квартал],
sc.ID[номер счета], zsl.ID [номер законченного случая],  sl.ID[номер случая], 
--pa.FAM + ' ' + im + ' ' + ot [Пациент], 
pa.FAM, im, ot,
CASE WHEN pa.W = 1 THEN 'Мужской' ELSE 'Женский' END [пол],
CASE 
	WHEN pa.W = 1 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 65 THEN 'муж 65+'
	WHEN pa.W = 2 AND  (DATEDIFF(dd, DR, @d)/365.2524) >= 60 THEN 'жен 60+'
ELSE 'Все остальные' END [Пенсионеры],
CASE WHEN (DATEDIFF(dd, DR, @d)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети],	
(SELECT TOP 1 f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [Код смо], 
pa.NPOLIS [Номер полиса], pa.DR [Дата рож.], DATEDIFF(dd, DR, @d)/365.2524 [Возраст на момент выписки], CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия], CAST(sc.DSCHET AS DATE) [Дата счета],
isnull((SELECT TOP 1 sk.NameWithID FROM v023 AS sk WHERE sk.K_KSG = dkko.N_KSG AND sl.DATE_1 >=sk.DATEBEG AND sl.DATE_2<=ISNULL(sk.DATEEND,'20991231')   ), dkko.N_KSG) IDKSG,  
NULL [Вид высокотехнологичной медицинской помощи], 'ОМС' [Вид оплаты],
(SELECT TOP 1 v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [Вид помощи],
(SELECT TOP 1 v.NameWithID FROM v014 v WHERE v.IDFRMMP = zsl.for_pom) [форма помощи],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
NULL [Врач приемного отделения],
NULL [В случае смерти указать основную причину],	
NULL [Госпитализирован по поводу данного заболевания в текущем году],	
NULL [Дата направления],
NULL [Дефект догоспитального этапа],
(SELECT TOP 1 mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз клинический заключительный], 
NULL [Диагноз направившего учреждения],
NULL [Диагноз патолого-анатомический],	
NULL [Диагноз приемного отделения],	
NULL [Доставлен в состоянии опьянения],	
NULL [Доставлен в стационар от начала заболевания],
(SELECT TOP 1 v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [Профиль],
(SELECT TOP 1 v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [Исход],
(SELECT TOP 1 v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [Результат обследования],
(SELECT TOP 1 f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[Кем направлен],
(SELECT TOP 1 v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[Цель посящения],
NULL [Вид исследования],
(SELECT TOP 1 v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[Код способа оплаты],
CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = sl.PODR)[Отделение],
(SELECT TOP 1 osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[Региональный признак особого случая], 
(SELECT TOP 1 v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
CASE WHEN profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12.6,2)
	WHEN profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4.2,2) ELSE 1.00 END [Количество ед], 
1 [Количество], sl.TARIF [Тариф],
  
zsl.SUMV [Сумма выставленная], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS Койкодни, 2 OPLATA,
dso.S_SUM [Удержания], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' '),-- CASE WHEN dso.S_COM LIKE 'Терапевт <18 в пол. или <16 в стац%' THEN 'Терапевт <18 в пол. или <16 в стац. Некорректное выставление профиля' ELSE dso.S_COM END AS [Комментарий], 
MONTH(zsl.DATE_Z_2) [Месяц выбытия] , dso.S_TIP, dso.S_DATE
FROM D3_ZSL_OMS zsl 
	JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
		JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
			JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
				LEFT JOIN D3_KSG_KPG_OMS AS dkko ON dkko.D3_SLID = sl.ID
					INNER JOIN ztemp_sankdop2025 AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
					WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
								   FROM D3_ZSL_OMS zsl 
							  JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
							  JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
							  JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --— and pa.SMO = @smo
								   WHERE zsl.usl_ok IN (1,2)
								   GROUP by zsl.id)


) AS t