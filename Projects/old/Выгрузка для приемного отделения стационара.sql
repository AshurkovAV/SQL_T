DECLARE @M1 INT = 1
DECLARE @M2 INT = 12
DECLARE @Y1 INT = 2016
DECLARE @Y2 INT = 2016

SELECT 
(SELECT v.NameWithID FROM V009 v WHERE v.IDRMP = sl.RSLT)[Результат обращения], 
(SELECT v.NameWithID FROM V012 v WHERE v.id = sl.ISHOD)[Исход заболевания], COUNT(*)[Количество]
FROM SLUCH AS sl
JOIN SCHET sc ON sc.ID = sl.SCHET_ID
WHERE sl.SLUCH_TYPE = 3 
AND ((sc.[MONTH] IN (SELECT n FROM M1(@M1, @M2, @Y1, @Y2) AS mm) AND sc.[YEAR] = @Y1) or (sc.[MONTH] IN ((SELECT n FROM M2(@M1, @M2, @Y1, @Y2) AS mm)) AND sc.[YEAR] = @Y2)) 
AND MONTH(sl.DATE_2) = sc.[MONTH]
GROUP BY sl.RSLT, sl.ISHOD
ORDER BY sl.RSLT