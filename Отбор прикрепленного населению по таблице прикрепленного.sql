SELECT p.Актуальная_МО, p.пол, COUNT(*)
FROM Prikrep AS p
WHERE 
--p.Актуальная_МО !='Заводская' AND 
p.Актуальность = 'True'
AND year(p.Дата_рождения) <= 2007
GROUP BY p.Актуальная_МО, p.пол


---Проставляем участок 
UPDATE p SET uch = d.uch
FROM Prikrep AS p
	JOIN [elmed].[dbo].[Prikrep_old1512225] d ON 
												d.Фамилия = p.Фамилия AND 
												d.Имя = p.Имя AND 
												d.Отчество = p.Отчество AND 
												d.Дата_рождения = p.Дата_рождения
WHERE 
	p.Актуальная_МО !='Заводская' AND 
	p.Актуальность = 'True'
	-----Убрать детей
	AND year(p.Дата_рождения) <= 2007
	
SELECT p.*,
CASE 
	WHEN YEAR(Дата_рождения) BETWEEN 2006 AND 2007 THEN '18-19'
	WHEN YEAR(Дата_рождения) BETWEEN 1996 AND 2005  THEN '20-29'
	WHEN YEAR(Дата_рождения) BETWEEN 1986 AND 1995 THEN '30-39'
	WHEN YEAR(Дата_рождения) BETWEEN 1976 AND 1985  THEN '40-49'
	WHEN YEAR(Дата_рождения) BETWEEN 1966 AND 1975 THEN '50-59'
	WHEN YEAR(Дата_рождения) BETWEEN 1956 AND 1965  THEN '60-69'
	WHEN YEAR(Дата_рождения) BETWEEN 1900 AND 1955 THEN '70 и старше' ELSE 'Что-то пошло не так' END	
FROM Prikrep AS p
	--LEFT JOIN (select * 
	--           from Server7.fire.dbo.perepis 
	--           WHERE [vybyl] = 0 and [Dead] = 0)  d ON 
	--										p.Фамилия = fam AND 
	--										p.Имя = im AND 
	--										p.Отчество = ot AND 
	--										p.Дата_рождения = dr
WHERE 
	p.Актуальная_МО ='Заводская' AND 
	p.Актуальность = 'True'
	-----Убрать детей
	AND year(p.Дата_рождения) <= 2007



