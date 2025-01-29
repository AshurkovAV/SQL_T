SELECT ais.*,  ais.fam, ais.im, ais.ot, ais.dr, bars.Телефон, bars.fam, ais.ДУ_МКБ10 mkb_ais, bars.ds1 mkb_bars
FROM ( SELECT  *
	   FROM [elmed].[dbo].du
       WHERE fam IS NOT NULL ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$
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


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ДУ_Врач = ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  ДУ_Врач_СНИЛС = ysme.SNILS
WHERE ДУ_Врач = ''


SELECT distinct z.*,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
									AND p.[Дата рождения] = z.dr
