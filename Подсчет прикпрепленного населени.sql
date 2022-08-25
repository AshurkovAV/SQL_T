DECLARE @d DATETIME = GETDATE()

SELECT 
(CASE WHEN ap.W = 1 THEN 'Мужской' ELSE 'Женский' END)AS r, COUNT(*)
FROM ATTP_People AS ap
WHERE ap.PrMo = 460026 
AND ap.[Active] = 1
AND (DATEDIFF(dd, DR, @d)/365.2524) >= 18
--AND YEAR(DR) <= 2002
GROUP BY ap.W

SELECT 
(CASE WHEN ap.W = 1 THEN 'Мужской' ELSE 'Женский' END)AS r, COUNT(*)
FROM ATTP_People AS ap
WHERE ap.PrMo = 460026 
AND ap.[Active] = 1
AND (DATEDIFF(dd, DR, @d)/365.2524) < 18
--AND YEAR(DR) <= 2002
GROUP BY ap.W

