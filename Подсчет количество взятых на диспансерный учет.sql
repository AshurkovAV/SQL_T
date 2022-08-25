SELECT DIAG10, COUNT (*)
FROM ATTP_DISP_ACCOUNT
WHERE MO = 460026
--AND PRVS = 76
AND DATEBEG  >= '20200101' 
--AND DATEBEG <= '20200930' 
AND DATEEND IS NOT NULL
GROUP BY DIAG10


--число состоящих на диспансерном учете, из них старше трудосп.
DECLARE @d DATETIME = GETDATE()
SELECT r, COUNT(*)
FROM (
SELECT (CASE WHEN ap.W = 1 THEN 'Мужской' ELSE 'Женский' END)AS r, COUNT(*)kol
FROM ATTP_DISP_ACCOUNT d
JOIN ATTP_People AS ap ON ap.ID = d.PID
WHERE MO = 460026
--AND (DATEDIFF(dd, DR, @d)/365.2524) >= 63
AND DATEEND IS NULL
GROUP BY d.PID, ap.W) AS t
GROUP BY r



--число состоящих на диспансерном учете, из них старше трудосп.
DECLARE @d DATETIME = GETDATE()
SELECT *,
ISNULL((SELECT TOP 1 a.fam + ' ' + a.im + ' ' + a.ot
    FROM [ATTP_Docs] a WHERE a.SNILS = t.SNILS), SNILS)doc
FROM(
SELECT ap.Fam, ap.Im, ap.Ot, ap.Dr, 
MAX(d.snils)snils,
ap.AdrOmsRegion, 
ap.AdrOmsNaspunkt, 
ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv,
 --d.PRVS, 
 ap.Phone
FROM ATTP_DISP_ACCOUNT d
JOIN ATTP_People AS ap ON ap.ID = d.PID
--LEFT JOIN [Yamed_Spr_MedicalEmployee] a ON a.SNILS = d.SNILS
WHERE MO = 460026
AND (DATEDIFF(dd, DR, @d)/365.2524) >= 65
--AND d.PRVS != 76
AND DATEEND IS NULL
GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr, 
--d.SNILS, 
ap.AdrOmsRegion, ap.AdrOmsNaspunkt, ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv,
ap.Phone) AS t
ORDER BY doc

--число физ лиц взятых на дисп учет
DECLARE @d DATETIME = GETDATE()
SELECT *
--ISNULL((SELECT TOP 1 a.fam + ' ' + a.im + ' ' + a.ot
--    FROM [ATTP_Docs] a WHERE a.SNILS = t.SNILS), SNILS)doc
FROM(
SELECT ap.Fam, ap.Im, ap.Ot, ap.Dr
--MAX(d.snils)snils,
--ap.AdrOmsRegion, 
--ap.AdrOmsNaspunkt, 
--ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv,
-- --d.PRVS, 
-- ap.Phone
FROM ATTP_DISP_ACCOUNT d
JOIN ATTP_People AS ap ON ap.ID = d.PID
--LEFT JOIN [Yamed_Spr_MedicalEmployee] a ON a.SNILS = d.SNILS
WHERE MO = 460026
--AND (DATEDIFF(dd, DR, @d)/365.2524) >= 65
AND d.DATEBEG >= '20210101'
--AND d.PRVS != 76
AND DATEEND IS NULL
GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr, 
--d.SNILS, 
--ap.AdrOmsRegion, ap.AdrOmsNaspunkt, ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv,
ap.Phone) AS t
--ORDER BY doc