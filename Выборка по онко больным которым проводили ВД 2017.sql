SELECT t.FAM, t.IM, t.OT, t.DR, t2.adres, t2.ds, st, 
        (SELECT v.NameWithID FROM V009 AS v WHERE v.IDRMP = HelpResult), MKB,
        (SELECT TOP 1 db.FioWithId FROM DoctorBd AS db WHERE db.id = t.Doctor)doc, cast(t.HelpStart AS DATE), cast(t.HelpEnd AS DATE)
--(SELECT TOP 1 ysme.NameWithID   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = t.IDDOKT) doc, t.DATE_Z_1, t.DATE_Z_2
FROM(

SELECT FAM, IM, OT, DR, pv.HelpStart, pv.HelpEnd, pv.Doctor, pv.HelpResult,  pv.MKB
FROM PacientVisit AS pv
WHERE Year(pv.DateVisit) = 2017 AND pv.OsobSluch = 22) AS t
JOIN (
SELECT *
FROM [elmed].[dbo].[Лист1$]
WHERE fam IS NOT NULL) AS t2 ON t2.FAM = t.FAM AND t2.IM = t.IM AND t2.OT = t.OT AND YEAR(DR) = god