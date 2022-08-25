DECLARE @schetTab TABLE (id INT)
INSERT INTO @schetTab(id)VALUES(3032)
SELECT 
(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dz.OS_SLUCH_REGION)[Особый случай в регионе], 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT)[Врач],
--(SELECT v.NameWithID FROM V009 AS v WHERE v.IDRMP = dz.RSLT), 
COUNT(*)[Количество]--, SUM(dz.SUMV)[Сумма]
--, dz.DATE_Z_1
FROM D3_ZSL_OMS AS dz
JOIN D3_PACIENT_OMS AS p ON dz.D3_PID = p.ID
LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds --WHERE ds.PROFIL = 97
) AS ds ON dz.ID = ds.D3_ZSLID
JOIN D3_SCHET_OMS AS s ON dz.D3_SCID = s.ID
WHERE dz.D3_SCID IN (SELECT id FROM @schetTab) --AND p.SMO = 46001 
--AND dz.PR_NOV = 0
AND  OS_SLUCH_REGION IN ( 47,48, 49)-- AND MONTH(dz.DATE_Z_2) = s.[MONTH]
 
GROUP BY dz.OS_SLUCH_REGION, ds.IDDOKT--, dz.RSLT--, dz.DATE_Z_1
ORDER BY OS_SLUCH_REGION


--SELECT 
--(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dz.OS_SLUCH_REGION)[Особый случай в регионе], 
--(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT)[Врач], COUNT(*)[Количество], SUM(dz.SUMV)[Сумма]
--FROM D3_ZSL AS dz
--JOIN PACIENT AS p ON dz.D3_PID = p.ID
--LEFT JOIN (SELECT * FROM D3_SL AS ds WHERE ds.PROFIL = 97) AS ds ON dz.ID = ds.D3_ZSLID
--WHERE dz.D3_SCID = @D3_SCID --AND p.SMO = 46001 
--AND  OS_SLUCH_REGION IN ( 9) --AND MONTH(dz.DATE_Z_2) = 3
--GROUP BY dz.OS_SLUCH_REGION, ds.IDDOKT
--ORDER BY OS_SLUCH_REGION