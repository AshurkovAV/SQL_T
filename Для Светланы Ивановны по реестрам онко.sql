DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(2180)

DECLARE @d DATETIME = GETDATE()
DECLARE @uet numeric(10,2)
SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')


SELECT 
pa.FAM, im, ot,
pa.NPOLIS [Номер полиса], pa.DR [Дата рож.], 
CAST(zsl.DATE_Z_1 AS DATE)[Дата поступления], CAST(zsl.DATE_Z_2 AS DATE)[Дата выбытия],
(SELECT sk.NameWithID FROM SprKsg AS sk WHERE sk.ID = dkko.N_KSG) IDKSG, 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =sl.IDDOKT) [Врач закрывший случай],
CAST(zsl.id AS NVARCHAR(10)) [Номер истории болезни],
(SELECT od.NameWithID FROM OtdelDb AS od WHERE od.Id = sl.PODR)[Отделение],
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = zsl.USL_OK) [Условие оказания помощи], 
sl.TARIF [Тариф], 
zsl.SUMV [Сумма выставленная], 
sl.KD  AS Койкодни
 
FROM D3_ZSL_OMS zsl 
JOIN D3_SL_OMS sl ON zsl.ID = sl.D3_ZSLID
JOIN D3_SCHET_OMS sc ON zsl.D3_SCID = sc.ID and sc.ID IN (SELECT id FROM @schetTab)
JOIN D3_PACIENT_OMS pa ON zsl.D3_PID = pa.ID 
LEFT JOIN D3_KSG_KPG_OMS AS dkko ON dkko.D3_SLID = sl.ID
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
               WHERE zsl.usl_ok IN (1,2)
               GROUP by zsl.id)
 
----Начало Дневной стационар
----CODE_USL = 'TF1.D01.001'
--AND sl.LPU_1 = 201 
--AND sl.PODR IN (9)
----Окончание Дневной стационар

----Начало Круглосуточный стационар пульмонология
--CODE_USL = 'TF1.K01.001'
--AND u.LPU_1 = 101 AND u.PODR = 8
------Окончание Круглосуточный стационар пульмонология

------Начало Круглосуточный стационар терапия
--CODE_USL = 'TF1.K01.001'
--AND u.LPU_1 = 101 AND u.PODR = 1
----Окончание Круглосуточный стационар терапия