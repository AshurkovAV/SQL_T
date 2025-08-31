SELECT t.Сотрудник,[Отделение], dbo.GROUP_CONCAT_DS(DISTINCT Наименование, N' , ', 1)Наименование, sum(kol)kol
FROM(
		SELECT  Сотрудник, [Отделение], Наименование, sum(Количество)kol, SUBSTRING(Сотрудник, 0, CHARINDEX(' (', Сотрудник))doc
		FROM docsing0625$
		WHERE Наименование NOT LIKE '%зуба%' 
		AND Сотрудник NOT LIKE '%Ариадна Лис%'
		AND Услуга NOT LIKE '%CT%'
		AND Услуга NOT LIKE '%A11%'
		AND Услуга NOT LIKE '%088-y06_FED%'
		AND Услуга NOT LIKE '%A16.07.002.009%'
		AND Услуга NOT LIKE '%A16.07.010%'
		AND Услуга NOT LIKE '%A16.07.009%'
		AND Услуга NOT LIKE '%A16.07.030.001%'

		AND Услуга NOT LIKE '%A16.07.030.003%'
		AND Услуга NOT LIKE '%B01.003.004.004%'
		AND Услуга NOT LIKE '%A02.07.004%'
		AND Услуга NOT LIKE '%A16.01.004%'
		AND Услуга NOT LIKE '%A16.07.014%'

		AND Услуга NOT LIKE '%A16.07.058%'
		AND Услуга NOT LIKE '%A16.07.082.001%'
		AND Услуга NOT LIKE '%A16.07.091%'
		AND Услуга NOT LIKE '%A25.07.001%'
		AND Услуга NOT LIKE '%B01.003.004.005%'

		AND Услуга NOT LIKE '%A26.06.082.001%'
		AND Услуга NOT LIKE '%A26.19.010%'
		AND Услуга NOT LIKE '%A16.07.030.002%'
		AND Услуга NOT LIKE '%B01.003.004.002%'
		AND Услуга NOT LIKE '%A12.07.004%'
		AND Услуга NOT LIKE '%A16.07.095%'
		AND Услуга NOT LIKE '%A13.30.0075%'

		AND Услуга NOT LIKE '%A13.30.007%'
		AND Услуга NOT LIKE '%A12.07.003%'
		AND Услуга NOT LIKE '%A16.07.051%'
		AND Услуга NOT LIKE '%A17.07.003%'
		AND Услуга NOT LIKE '%A16.07.017.002%'
		AND Услуга NOT LIKE '014/у%'
 
		GROUP BY Сотрудник, [Отделение], Наименование) AS t
LEFT JOIN (
			SELECT (ysme.FAM + ' ' + ysme.IM + ' ' + ysme.OT) doc, ysme.LPU_ID
            FROM Yamed_Spr_MedicalEmployee AS ysme
          ) t1 ON t.doc = t1.doc 
GROUP BY Сотрудник,[Отделение]--,  t1.LPU_ID