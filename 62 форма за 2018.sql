DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(2057)
INSERT INTO @schetTab(id)VALUES(2059) 
INSERT INTO @schetTab(id)VALUES(2060)
INSERT INTO @schetTab(id)VALUES(2061)
INSERT INTO @schetTab(id)VALUES(2071)
INSERT INTO @schetTab(id)VALUES(2077)
INSERT INTO @schetTab(id)VALUES(2083)
INSERT INTO @schetTab(id)VALUES(2092)
INSERT INTO @schetTab(id)VALUES(2095)
INSERT INTO @schetTab(id)VALUES(2111)
INSERT INTO @schetTab(id)VALUES(2115)
INSERT INTO @schetTab(id)VALUES(2119)
DECLARE @d DATETIME = GETDATE()
DECLARE @uet numeric(10,2)
SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')
SELECT *
FROM (
SELECT sc.[MONTH], 
zsl.ID [номер законченного случая],  sl.ID[номер случая], 
(SELECT v.NameWithID FROM v008 v WHERE v.Id = zsl.VIDPOM) [Вид помощи],
CASE WHEN sc.[MONTH] < 8 THEN (SELECT sp.NameWithID FROM SprPCel AS sp WHERE sp.ID = sl.P_CEL) ELSE (SELECT v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25) END [Цель посящения],
--(SELECT v.NameWithID FROM V025 AS v WHERE v.IDPC = sl.P_CEL25)[Цель посящения],
--NULL , p_cel25,
zsl.SUMV [Сумма выставленная]
FROM D3_ZSL_OMS zsl 
JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
LEFT JOIN (
	SELECT *
	FROM D3_SANK_OMS AS dso
	WHERE dso.ID IN (
	SELECT MAX(s.ID)
             FROM D3_SANK_OMS s GROUP BY s.D3_ZSLGID)) AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE sl.id IN (SELECT MAX(sl.id)--,sl.IDDOKT,sl.PROFIL, sl.DS1,sl.P_CEL,sl.PODR,sl.USL_OK
 
               FROM D3_ZSL_OMS zsl 
          JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
          JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
          JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID --— and pa.SMO = @smo
               WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NULL
               GROUP by zsl.id)
UNION ALL

SELECT  sc.[MONTH], 
zsl.ID [номер законченного случая],  NULL, 
'12   первичная врачебная медико-санитарная помощь' [Вид помощи],
(SELECT NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = zsl.OS_SLUCH_REGION)[Цель посящения],
--NULL,NULL,
MAX(zsl.SUMV) [Сумма выставленная]
FROM D3_ZSL_OMS zsl 
JOIN ( SELECT * FROM D3_SL_OMS WHERE id IN (SELECT MAX(dso.id)id
											FROM D3_ZSL_OMS AS dzo
											JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
                                          WHERE dzo.OS_SLUCH_REGION IS NOT NULL AND dzo.D3_SCID IN (SELECT id FROM @schetTab)
                                          GROUP BY dso.D3_ZSLID, dso.PROFIL
											)) sl ON zsl.ID = sl.D3_ZSLID
JOIN D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID 
LEFT JOIN (
	SELECT *
	FROM D3_SANK_OMS AS dso
	WHERE dso.ID IN (
	SELECT MAX(s.ID)
             FROM D3_SANK_OMS s GROUP BY s.D3_ZSLGID)) AS dso ON dso.D3_ZSLGID = zsl.ZSL_ID
WHERE zsl.usl_ok = 3 AND zsl.OS_SLUCH_REGION IS NOT NULL
GROUP BY sc.[MONTH], zsl.ID, zsl.OS_SLUCH_REGION)
 AS t
--GROUP BY 