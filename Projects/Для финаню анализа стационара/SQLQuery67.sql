SELECT pv.id, rmod.R_NAME + ' ' + cast(rmod.R_YEAR AS varchar) AS 'Дата реестра', 
ISNULL((SELECT cast(ks.KSG AS varchar) + ' ' + ks.NAME
   FROM KSG_SPR AS ks WHERE ks.ID = pv.KSG15ID), (SELECT cast(kg.KSG_ID AS varchar) + ' ' + kg.KSG_NAME
        FROM KSG_GROUP AS kg WHERE kg.ID = pv.KsgID)) AS 'Номер КСГ', sumv  AS 'Сумма'
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp = 1
AND rmod.ID IN (45,48,49)--(18,20,21,24,26,30,32,34,37,38,40,43) --
AND pv.Profil IN(97, 75)