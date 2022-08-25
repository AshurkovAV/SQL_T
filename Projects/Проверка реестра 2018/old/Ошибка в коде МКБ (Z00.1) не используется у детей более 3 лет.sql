SELECT dz.id, p.FAM, p.IM, p.OT, CAST(p.DR AS DATE) dr, 
(SELECT TOP 1 db.NameWithID FROM Yamed_Spr_MedicalEmployee AS db WHERE db.SNILS = ds.IDDOKT) doc, 
CAST(ds.DATE_1 AS DATE) HelpStart, CAST(ds.DATE_2 AS DATE) HelpEnd,
'Ошибка в коде МКБ (Z00.1) не используется у детей более 3 лет' AS per
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON p.ID = dz.D3_PID
WHERE dz.D3_SCID = 2071
AND ds.USL_OK = 3 
AND DATEDIFF(year, p.DR, ds.DATE_2) > 3
AND ds.DET = 1 AND ds.DS1 = 'Z00.1'