--Выполняем на компе NachOIT
--DELETE  FROM [SQL_MIAC].[SZV].[dbo].[VD_2019_1]

INSERT INTO [SQL_MIAC].[SZV].[dbo].[VD_2019_1] ( [FAM],[IM],[OT],[DR],[DATE_Z_1],[DATE_Z_2],[doc],[OS_SLUCH_REGION])
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2, 
(SELECT ysme.NameWithID FROM Server_elmed.elmed.dbo.Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT) doc,
(SELECT osd.NameWithID 
   FROM Server_elmed.elmed.dbo.OsobSluchDb AS osd WHERE osd.Id = dzo.OS_SLUCH_REGION)OS_SLUCH_REGION 
FROM Server_elmed.elmed.dbo.D3_ZSL_OMS AS dzo
JOIN Server_elmed.elmed.dbo.D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN Server_elmed.elmed.dbo.D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE YEAR(dzo.DATE_Z_2) = 2019 AND dzo.OS_SLUCH_REGION IN (22,9,38,37,47,49) AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
ORDER BY dpo.FAM, dpo.IM,dpo.OT

--ALTER TABLE
--    vd_2019
--ALTER COLUMN dr datetime COLLATE SQL_Latin1_General_CP1251_CI_AS

UPDATE p SET PRIMEHANIE = OS_SLUCH_REGION +  '   Врач: ' + doc + ' Дата проведения ' + Convert(NVARCHAR(10), date_Z_1, 126) + ' - ' + Convert(NVARCHAR(10), date_Z_2, 126) 
--SELECT p.NOM, p.PRENOM, p.PATRONYME, p.NE_LE, *
FROM PATIENTS AS p
JOIN (SELECT * FROM [SZV].[dbo].[VD_2019_1]) vd ON p.NOM = vd.FAM AND p.PRENOM = vd.im AND p.PATRONYME = vd.OT AND p.NE_LE = vd.DR