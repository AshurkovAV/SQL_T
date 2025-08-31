if OBJECT_ID('zs1') is not null DROP TABLE zs1
if OBJECT_ID('zsd1') is not null DROP TABLE zsd1

SELECT *
INTO zsd1 
	FROM (
			SELECT [ID]
				  ,[Фамилия]
				  ,[Имя]
				  ,[Отчество]
				  ,[Дата_рождения]
				  ,[Дата_Смерти]
				  ,[Адрес_регион]
				  ,[Адрес_район]
				  ,[Адрес_населённый_пункт]
				  ,[Адрес_улица]
				  ,[Адрес_дом]
				  ,[Адрес_корпус]
				  ,[Адрес_квартира]
				  ,[Актуальная_МО]
				  ,[Дата_прикрепления]
				  ,[Дата_открепления]
				  ,[Актуальность]
			FROM [elmed].[dbo].[Prikrep]
			WHERE YEAR([Дата_рождения]) BETWEEN 1965 AND 2007
		) AS t
		LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION, 
				dbo.GROUP_CONCAT_DS(DISTINCT dzo.DATE_Z_2 , N' , ', 1)DATE_Z_2
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				WHERE(dso2.[YEAR] IN (2024, 2023, 2025) 
					AND dzo.OS_SLUCH_REGION IN (47,49,50) )
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.Фамилия = t1.FAM AND t.Имя = t1.IM AND t.Отчество = t1.OT AND t.[Дата_рождения] = t1.DR


--SELECT *
--FROM zsd1
------------//3 проставляем телефоны//----------------
if OBJECT_ID('zt1') is not null DROP TABLE zt1
SELECT *
INTO zt1
FROM(
	SELECT *
	FROM zsd1
	WHERE fam IS null) AS tt
LEFT JOIN [test].[dbo].[Tel] t ON tt.Фамилия=f and tt.Имя=i and tt.Отчество=o and tt.[Дата_рождения]=d


SELECT distinct z.*,
CASE WHEN p.Фамилия IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = z.Фамилия 
									AND p.Имя = z.Имя
									AND p.Отчество = z.Отчество
									AND p.[Дата рождения] = z.[Дата_рождения]
									
									
									
SELECT * FROM zt1