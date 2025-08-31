DROP TABLE ztemp_prikrep_not_visit

SELECT t.*
INTO ztemp_prikrep_not_visit
FROM(
			SELECT ap.Фамилия, ap.Имя, ap.Отчество, ap.Дата_рождения, 
				ISNULL(ap.Адрес_район , '-') + ' ' + isnull(ap.Адрес_населённый_пункт , '-') + ' ' + isnull(ap.Адрес_улица , '-') + ' ' + ISNULL(ap.Адрес_дом , '-') + ' ' + isnull(ap.Адрес_корпус , '-')  + ' ' + isnull(ap.Адрес_квартира , '-')  addr, ap.Актуальная_МО
			FROM Prikrep AS ap
			WHERE ap.Актуальность = 'True' AND ap.Дата_рождения <= '20050101') AS t
LEFT JOIN
	( 
			SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR
			FROM D3_SCHET_OMS AS dso2
				JOIN D3_ZSL_OMS AS dzo             ON dzo.D3_SCID  = dso2.ID
					JOIN D3_PACIENT_OMS AS dpo     ON dpo.ID       = dzo.D3_PID
						JOIN D3_SL_OMS AS dso      ON dso.D3_ZSLID = dzo.ID
			WHERE (dso2.[YEAR] = 2023 AND dso2.[MONTH] IN (8,9,10,11,12)) OR 
				   dso2.[YEAR] = 2024 OR 
				  (dso2.[YEAR] = 2025 AND dso2.[MONTH] IN (1,2,3,4,5,6,7))
				  
	)AS t2						ON t2.FAM = t.Фамилия 
									AND t2.IM = t.Имя 
									AND t2.OT = t.Отчество 
									AND t2.DR = t.Дата_рождения
WHERE t2.FAM IS NULL


---Отделяем заводскую от союзной-------
SELECT g.*, t.MOBIL_TELEFON, t.mcod
	FROM ztemp_prikrep_not_visit g
		LEFT JOIN telefon1 AS t ON t.NOM = Фамилия AND t.PRENOM = Имя AND t.PATRONYME = Отчество AND t.NE_LE = Дата_рождения		
WHERE g.Актуальная_МО = 'Союзная' AND
(  
	charindex('завод',    addr)=0 AND  
	charindex('дейнек',   addr)=0 AND
	charindex('сумская',  addr)=0 AND
	charindex('кулакова', addr)=0 AND
	charindex('парковая', addr)=0 AND
	charindex('клыков',   addr)=0  AND
	charindex('клыкова',  addr)=0 
) 