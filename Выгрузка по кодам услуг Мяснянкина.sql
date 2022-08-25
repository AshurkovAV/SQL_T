--DECLARE @sc INT = 2057
DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(2898)
INSERT INTO @schetTab(id)VALUES(2899)
INSERT INTO @schetTab(id)VALUES(3036)
INSERT INTO @schetTab(id)VALUES(3037)
INSERT INTO @schetTab(id)VALUES(3038)
INSERT INTO @schetTab(id)VALUES(3039)
INSERT INTO @schetTab(id)VALUES(3040)


DECLARE @d DATETIME = GETDATE()
DECLARE @uet numeric(10,2)
SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')

SELECT zsl.PR_NOV, sc.[YEAR] [Год], 
CASE WHEN sc.[MONTH] IN (1,2,3) THEN 'Первый'
     WHEN sc.[MONTH] IN (4,5,6) THEN 'Второй'
     WHEN sc.[MONTH] IN (7,8,9) THEN 'Третий'
     WHEN sc.[MONTH] IN (10,11,12) THEN 'Четвертый' ELSE 'Что-то пошло не так' END [Квартал],
sc.ID[номер счета], zsl.ID [номер законченного случая],  sl.ID[номер случая], 
--pa.FAM + ' ' + im + ' ' + ot [Пациент], 
pa.FAM, im, ot,
(SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = pa.SMO) [Код смо], 
pa.NPOLIS [Номер полиса], pa.DR [Дата рож.], DATEDIFF(dd, DR, @d)/365.2524 [Возраст на момент выписки], CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия], CAST(sc.DSCHET AS DATE) [Дата счета],
NULL ksg, NULL [Вид высокотехнологичной медицинской помощи], 'ОМС' [Вид оплаты],
(SELECT v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [Вид помощи],
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
NULL [Врач приемного отделения],
NULL [В случае смерти указать основную причину],	
NULL [Госпитализирован по поводу данного заболевания в текущем году],	
NULL [Дата направления],
NULL [Дефект догоспитального этапа],
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз клинический заключительный], 
NULL [Диагноз направившего учреждения],
NULL [Диагноз патолого-анатомический],	
NULL [Диагноз приемного отделения],	
NULL [Доставлен в состоянии опьянения],	
NULL [Доставлен в стационар от начала заболевания],
(SELECT v.NameWithID FROM V002 AS v WHERE v.Id = sl.PROFIL) [Профиль],
(SELECT v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [Исход],
(SELECT v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [Результат обследования],
(SELECT f.NameWithID FROM f003 f WHERE f.mcod = zsl.NPR_MO)[Кем направлен],
(SELECT v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[Цель посящения],
(SELECT v.NameWithID FROM v010 v WHERE v.Id = zsl.IDSP)[Код способа оплаты],
CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT od.NameWithID FROM OtdelDb AS od WHERE od.Id = sl.PODR)[Отделение],
(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[Региональный признак особого случая], 
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
CASE WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 = '3.0' THEN  round(sl.ED_COL/12,2)
	 WHEN sl.profil IN (85,86,87,88,89,90) and P_CEL25 != '3.0' THEN  round(sl.ED_COL/4,2) ELSE 1.00 END [Количество ед], 
1 [Количество], sl.TARIF [Тариф],
 
zsl.SUMV [Сумма выставленная], 

DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) + 1  AS Койкодни,
dso.S_SUM [Удержания], replace(replace(dso.S_COM,CHAR(13),' '), CHAR(10), ' '),-- CASE WHEN dso.S_COM LIKE 'Терапевт <18 в пол. или <16 в стац%' THEN 'Терапевт <18 в пол. или <16 в стац. Некорректное выставление профиля' ELSE dso.S_COM END AS [Комментарий], 
MONTH(zsl.DATE_Z_2) [Месяц выбытия],
(SELECT code_usl + '    ' + m.name FROM medicalServices m WHERE m.code_usl = duo.CODE_USL) 
FROM D3_ZSL_OMS zsl 
JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = sl.ID
LEFT JOIN (
	SELECT *
	FROM D3_SANK_OMS AS dso
	WHERE dso.ID IN (
	SELECT MAX(s.ID)
             FROM D3_SANK_OMS s GROUP BY s.D3_ZSLGID)) AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID AND dso.D3_SCID = zsl.D3_SCID
WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
               FROM D3_ZSL_OMS zsl 
          JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
          JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
          JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --— and pa.SMO = @smo
               WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL 
               GROUP by zsl.id) AND zsl.IDSP = 28






