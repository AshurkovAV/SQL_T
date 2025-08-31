SELECT ais.*,  ais.fam, ais.im, ais.ot, ais.dr, bars.Телефон, bars.fam, ais.ДУ_МКБ10 mkb_ais, bars.ds1 mkb_bars
FROM ( SELECT  *
	   FROM [elmed].[dbo].du
       WHERE fam IS NOT NULL ) AS ais
LEFT JOIN (
		SELECT *
		FROM barsdu0602$
		WHERE fam IS NOT NULL) AS bars ON bars.fam = ais.fam 
												AND bars.im = ais.im 
												AND bars.ot = ais.ot
												AND bars.[Дата рождения] = ais.dr
												AND bars.ds1 = ais.ДУ_МКБ10_Код
ORDER BY ais.fam





--язвенные болезни

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.ДУ_МКБ10 mkb_ais, ais.ДУ_Врач_СНИЛС, ais.ДУ_Врач, bars.Телефон, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE ДУ_МКБ10  BETWEEN 'K25.0' AND 'K26.9'
			 or ДУ_МКБ10_Код  = 'K25'
			or ДУ_МКБ10_Код  = 'K26'   ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE db.ds1 BETWEEN 'K25.0' AND 'K26.9'
		or ds1  = 'K25'
		or ds1  = 'K26'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[Дата рождения] 
						AND ais.ДУ_МКБ10_Код = bars.ds1
ORDER BY ais.fam



--лор болезни

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.ДУ_МКБ10 mkb_ais, ais.ДУ_Врач_СНИЛС, ais.ДУ_Врач, bars.Телефон, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE 
			    ДУ_МКБ10  BETWEEN 'H66.1' AND 'H66.3'
			 OR ДУ_МКБ10  BETWEEN 'H90.3' AND 'H93.3'
			 or ДУ_МКБ10_Код  = 'J35.0'
			 or ДУ_МКБ10_Код  = 'H80.0'
			 or ДУ_МКБ10_Код  = 'J37.0'
			 or ДУ_МКБ10_Код  = 'J31.2'
			 or ДУ_МКБ10_Код  = 'J31.2'
			 or ДУ_МКБ10_Код  = 'J30.1'
			 or ДУ_МКБ10_Код  = 'J30.3'
			 or ДУ_МКБ10_Код  = 'J33.8'
			 or ДУ_МКБ10_Код  = 'J32.0'
			 or ДУ_МКБ10_Код  = 'J32.2'   ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE  ds1  BETWEEN 'H66.1' AND 'H66.3'
			 OR ds1  BETWEEN 'H90.3' AND 'H93.3'
			 or ds1  = 'J35.0'
			 or ds1  = 'H80.0'
			 or ds1  = 'J37.0'
			 or ds1  = 'J31.2'
			 or ds1  = 'J31.2'
			 or ds1  = 'J30.1'
			 or ds1  = 'J30.3'
			 or ds1  = 'J33.8'
			 or ds1  = 'J32.0'
			 or ds1  = 'J32.2'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[Дата рождения] 
						AND ais.ДУ_МКБ10_Код = bars.ds1
ORDER BY ais.fam





--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ДУ_Врач = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(ДУ_Врач_СНИЛС,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ДУ_Врач = ''


SELECT distinct z.*,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
									AND p.[Дата рождения] = z.dr







--хирургические 

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.ДУ_МКБ10 mkb_ais, ais.ДУ_Врач_СНИЛС, ais.ДУ_Врач, bars.Телефон, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE 
			   ДУ_МКБ10  like 'I70%'
			OR ДУ_МКБ10  like  'I83%'
			OR ДУ_МКБ10  like  'I80%'
			OR ДУ_МКБ10  like  'I81%'
			OR ДУ_МКБ10  like  'K64%'
			OR ДУ_МКБ10  like  'K43%'
			OR ДУ_МКБ10  like  'K40%'
			OR ДУ_МКБ10  like  'K42%'
			OR ДУ_МКБ10  like  'K73%'
			OR ДУ_МКБ10  like  'N60%'
			OR ДУ_МКБ10  like  'K80%'
			OR ДУ_МКБ10  like  'M86%'
			OR ДУ_МКБ10  like  'K52%'
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE  
			 ds1  = 'I70.2'
			OR ds1  = 'I83.9'
			OR ds1  = 'I80.0'
			OR ds1  = 'I81.0'
			OR ds1  = 'K64.1'
			OR ds1  = 'K43.9'
			OR ds1  = 'K40.9'
			OR ds1  = 'K42.9'
			OR ds1  = 'K73.0'
			OR ds1  = 'N60.0'
			OR ds1  = 'K80.1'
			OR ds1  = 'M86.6'
			OR ds1  = 'K52.1'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[Дата рождения] 
						AND ais.ДУ_МКБ10_Код = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ДУ_Врач = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(ДУ_Врач_СНИЛС,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ДУ_Врач = ''


SELECT distinct z.*,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
									AND p.[Дата рождения] = z.dr



--онко болезни

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.ДУ_Начало, ais.ДУ_МКБ10 mkb_ais, ais.ДУ_Врач_СНИЛС, ais.ДУ_Врач, bars.Телефон, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
       WHERE ДУ_МКБ10_Код 	like 'C%'
			
			   ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE 			 
			ds1 like 'C%'

		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[Дата рождения] 
						AND ais.ДУ_МКБ10_Код = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ДУ_Врач = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(ДУ_Врач_СНИЛС,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ДУ_Врач = ''


SELECT distinct z.*, pr.Адрес_регион, pr.Адрес_район, pr.Адрес_населённый_пункт, pr.Адрес_улица, pr.Адрес_дом, pr.Адрес_квартира,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
	LEFT JOIN Prikrep pr ON pr.Фамилия = fam AND pr.Имя = im AND pr.Отчество = ot AND pr.Дата_рождения = z.dr
		LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
									AND p.[Дата рождения] = z.dr
									
									
									



DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.ДУ_МКБ10 mkb_ais, ais.ДУ_Врач_СНИЛС, ais.ДУ_Врач, bars.Телефон, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE 
			   ДУ_МКБ10  like 'I70%'
			OR ДУ_МКБ10  like  'I83%'
			OR ДУ_МКБ10  like  'I80%'
			OR ДУ_МКБ10  like  'I81%'
			OR ДУ_МКБ10  like  'K64%'
			OR ДУ_МКБ10  like  'K43%'
			OR ДУ_МКБ10  like  'K40%'
			OR ДУ_МКБ10  like  'K42%'
			OR ДУ_МКБ10  like  'K73%'
			OR ДУ_МКБ10  like  'N60%'
			OR ДУ_МКБ10  like  'K80%'
			OR ДУ_МКБ10  like  'M86%'
			OR ДУ_МКБ10  like  'K52%'
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE  
			 ds1  = 'I70.2'
			OR ds1  = 'I83.9'
			OR ds1  = 'I80.0'
			OR ds1  = 'I81.0'
			OR ds1  = 'K64.1'
			OR ds1  = 'K43.9'
			OR ds1  = 'K40.9'
			OR ds1  = 'K42.9'
			OR ds1  = 'K73.0'
			OR ds1  = 'N60.0'
			OR ds1  = 'K80.1'
			OR ds1  = 'M86.6'
			OR ds1  = 'K52.1'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[Дата рождения] 
						AND ais.ДУ_МКБ10_Код = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ДУ_Врач = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(ДУ_Врач_СНИЛС,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ДУ_Врач = ''


SELECT distinct z.*,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
									AND p.[Дата рождения] = z.dr
									
									
									
-----рюмшина
if OBJECT_ID('zt') is not null DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.ДУ_Начало, ais.ДУ_МКБ10 mkb_ais, ais.ДУ_Врач_СНИЛС, ais.ДУ_Врач, bars.Телефон, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
       WHERE ДУ_Врач LIKE '%Рюмшина%' 
			   
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM BARS0319$ AS db		
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[Дата рождения] 
						AND ais.ДУ_МКБ10_Код = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ДУ_Врач = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(ДУ_Врач_СНИЛС,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ДУ_Врач = ''


SELECT distinct z.*,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
									AND p.[Дата рождения] = z.dr
									
									
									
									
if OBJECT_ID('zt') is not null DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.ДУ_Начало, ais.ДУ_МКБ10 mkb_ais, ais.ДУ_Врач_СНИЛС, ais.ДУ_Врач, bars.Телефон, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
       WHERE ДУ_МКБ10_Код LIKE 'J%' OR 
       ДУ_МКБ10_Код LIKE 'M%'
			   
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM BARS0319$ AS db		
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[Дата рождения] 
						AND ais.ДУ_МКБ10_Код = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ДУ_Врач = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(ДУ_Врач_СНИЛС,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ДУ_Врач = ''


SELECT distinct z.*,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
									AND p.[Дата рождения] = z.dr