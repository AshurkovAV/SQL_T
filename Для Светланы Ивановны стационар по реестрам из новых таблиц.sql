DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(4183)
--INSERT INTO @schetTab(id)VALUES(3962)

DECLARE @d DATETIME = GETDATE()
DECLARE @uet numeric(10,2)
SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')


SELECT 
pa.FAM, im, ot,
pa.NPOLIS [Номер полиса], CAST(pa.DR AS DATE) [Дата рож.], 
CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия],
v.NameWithID ,
--(SELECT sk.NameWithID FROM v023 AS sk WHERE sk.K_KSG = dkko.N_KSG AND sk.DATEEND) IDKSG,
ds1, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
--CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT od.NameWithID FROM OtdelDb AS od WHERE od.Id = sl.PODR)[Отделение],
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
sl.TARIF [Тариф], dkko.KOEF_UP,
zsl.SUMV [Сумма выставленная], 
sl.KD  AS Койкодни,
(SELECT v.NameWithID FROM v012 v WHERE v.id = zsl.ISHOD) [Исход],
(SELECT v.NameWithID FROM V009 AS v WHERE v.IDRMP = zsl.RSLT) [Результат обследования]
,ds2.DS [сопутствующий]
,ds3.DS [осложнение], 
CRIT--(SELECT top 1 v2.NameWithID FROM V024 AS v2 WHERE v2.IDDKK = dco.CRIT) [критерий]
,Z_SL [КСЛП]
 
FROM D3_ZSL_OMS zsl 
JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
LEFT JOIN D3_KSG_KPG_OMS AS dkko ON dkko.D3_SLID = sl.ID
LEFT JOIN v023 v ON v.K_KSG = dkko.N_KSG AND zsl.DATE_Z_2 >= v.DATEBEG AND isnull(v.DATEEND, '20201231') >= zsl.DATE_Z_2
LEFT JOIN (SELECT D3_SL_KOEF_OMS.D3_KSGID,  dbo.GROUP_CONCAT_DS(DISTINCT D3_SL_KOEF_OMS.Z_SL, N' , ', 1) Z_SL FROM D3_SL_KOEF_OMS GROUP BY D3_SL_KOEF_OMS.D3_KSGID) SlKoEf on SlKoEf.D3_KSGID=dkko.ID
LEFT JOIN (SELECT D3_CRIT_OMS.D3_KSGID,     dbo.GROUP_CONCAT_DS(DISTINCT D3_CRIT_OMS.CRIT, N' , ', 1) CRIT FROM D3_CRIT_OMS GROUP BY D3_CRIT_OMS.D3_KSGID) AS dco ON dco.D3_KSGID =dkko.ID
LEFT JOIN (SELECT D3_SLID,                  dbo.GROUP_CONCAT_DS(DISTINCT DS, N' , ', 1) DS FROM D3_DSS_OMS WHERE DS_TYPE = 2 GROUP BY D3_SLID)   AS ds2 ON ds2.D3_SLID = sl.ID
LEFT JOIN (SELECT D3_SLID,                  dbo.GROUP_CONCAT_DS(DISTINCT DS, N' , ', 1) DS FROM D3_DSS_OMS WHERE DS_TYPE = 3 GROUP BY D3_SLID)   AS ds3 ON ds3.D3_SLID = sl.ID
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
               WHERE zsl.usl_ok IN (1,2) AND zsl.PR_NOV = 0
               GROUP by zsl.id)
AND zsl.USL_OK = 1
--AND zsl.PR_NOV = 1 
----Начало Дневной стационар
--AND sl.LPU_1 = 201 
--AND sl.PODR IN (9)
----Окончание Дневной стационар

----Начало Круглосуточный стационар пульмонология
--AND sl.LPU_1 = 101 AND sl.PODR = 8
------Окончание Круглосуточный стационар пульмонология

--------Начало Круглосуточный стационар терапия
--AND sl.LPU_1 = 101 AND sl.PODR = 1
------Окончание Круглосуточный стационар терапия
ORDER BY pa.FAM, pa.IM, pa.OT