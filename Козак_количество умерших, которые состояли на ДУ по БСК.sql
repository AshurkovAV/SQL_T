SELECT  
(CASE WHEN month(z.DEATHDATE) = 1 THEN  'Январь'
						WHEN month(z.DEATHDATE) = 2 THEN  'Февраль'
						WHEN month(z.DEATHDATE) = 3 THEN  'Март'
						WHEN month(z.DEATHDATE) = 4 THEN  'Апрель'
						WHEN month(z.DEATHDATE) = 5 THEN  'Май'
						WHEN month(z.DEATHDATE) = 6 THEN  'Июнь'
						WHEN month(z.DEATHDATE) = 7 THEN  'Июль'
						WHEN month(z.DEATHDATE) = 8 THEN  'Август'
						WHEN month(z.DEATHDATE) = 9 THEN  'Сентябрь'
						WHEN month(z.DEATHDATE) = 10 THEN 'Октябрь'
						WHEN month(z.DEATHDATE) = 11 THEN 'Ноябрь'
						WHEN month(z.DEATHDATE) = 12 THEN 'Декабрь' 
						ELSE 'Что-то пошло не так' END) [месяц подачи], 
z.FAM, z.IM, z.OT, z.BIRTHDATE, d2.Регистр#ДН#Диагнозы

FROM dubsk AS d2
	JOIN  [covid19].[dbo].[mtr_ZAGSARHIV] z ON ltrim(d2.Фамилия) = ltrim(z.FAM) AND ltrim( d2.Имя) = ltrim(z.IM) AND ltrim(d2.Отчество) = ltrim(z.OT) AND d2.ДР = z.BIRTHDATE
WHERE z.DEATHDATE BETWEEN '20250101' AND '20250831'
GROUP BY month(z.DEATHDATE), z.FAM, z.IM, z.OT, z.BIRTHDATE, d2.Регистр#ДН#Диагнозы


SELECT *
FROM [covid19].[dbo].[mtr_ZAGSARHIV]