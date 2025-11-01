if OBJECT_ID('ztemp_prikrep_not_visit')  is not null DROP TABLE ztemp_prikrep_not_visit

SELECT t.*
INTO ztemp_prikrep_not_visit
FROM(
			SELECT ap.Фамилия fam, ap.Имя im, ap.Отчество ot, ap.Дата_рождения dr, 
					 ISNULL(ap.Адрес_район , '-') Адрес_район,
					 isnull(ap.Адрес_населённый_пункт , '-')Адрес_населённый_пункт,
					 isnull(ap.Адрес_улица , '-')Адрес_улица,
					 ISNULL(ap.Адрес_дом , '-')Адрес_дом,
					 isnull(ap.Адрес_корпус , '-')Адрес_корпус, 
					 isnull(ap.Адрес_квартира , '-')Адрес_квартира,
					 ISNULL(ap.Адрес_район , '-') + ' ' + isnull(ap.Адрес_населённый_пункт , '-') + ' ' + isnull(ap.Адрес_улица , '-') + ' ' + ISNULL(ap.Адрес_дом , '-') + ' ' + isnull(ap.Адрес_корпус , '-')  + ' ' + isnull(ap.Адрес_квартира , '-')  addr, 
					 ap.Актуальная_МО
			FROM Prikrep AS ap
			WHERE ap.Актуальность = 'True' AND ap.Дата_рождения <= '20050101') AS t
LEFT JOIN
	( 
			SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR
			FROM D3_SCHET_OMS AS dso2
				JOIN D3_ZSL_OMS AS dzo             ON dzo.D3_SCID  = dso2.ID
					JOIN D3_PACIENT_OMS AS dpo     ON dpo.ID       = dzo.D3_PID
						JOIN D3_SL_OMS AS dso      ON dso.D3_ZSLID = dzo.ID
			WHERE (dso2.[YEAR] = 2023 ) OR 
				   dso2.[YEAR] = 2024 --OR 
				--  (dso2.[YEAR] = 2025 AND dso2.[MONTH] IN (1,2,3,4,5,6,7,8,9))
				  
	)AS t2						ON t2.FAM = t.fam 
									AND t2.IM = t.im
									AND t2.OT = t.ot
									AND t2.DR = t.dr
WHERE t2.FAM IS NULL




-------Проставляем телефон-------
if OBJECT_ID('zt1') is not null DROP TABLE zt1
SELECT tt.*, t.MOBIL_TELEFON
INTO zt1
FROM(
	SELECT *
	FROM ztemp_prikrep_not_visit
	) AS tt
LEFT JOIN telefon AS t ON tt.fam=t.NOM and tt.im= t.PRENOM and tt.ot=t.PATRONYME and tt.dr=t.NE_LE


-------Проставляем участок-------
if OBJECT_ID('ztemp_patuch') is not null DROP TABLE ztemp_patuch
SELECT b.*, CASE WHEN p.НАШНОМЕРУЧАСТКА IS NULL THEN 'Заводская № участка ' + cast(p7.UCH AS NVARCHAR(10)) ELSE 'Союзная № участка ' + cast(p.НАШНОМЕРУЧАСТКА AS NVARCHAR(10)) END uch
INTO ztemp_patuch
FROM (
		SELECT *
		FROM zt1
) AS b
LEFT JOIN [test].[dbo].[prikrep_29102021] p ON 
							p.Фамилия         = b.fam AND 
							p.Имя             = b.im AND 
							p.Отчество        = b.ot AND  
							p.[Дата рождения] = b.dr         -- CONVERT(DATE, SUBSTRING(dr, 7,4) + SUBSTRING(dr, 1,2) + SUBSTRING(dr, 4,2), 102)

LEFT JOIN [dbo].[Perepis] p7 ON p7.fam        = b.fam AND 
							    p7.im         = b.im AND 
							    p7.ot         = b.ot AND  
							    p7.dr         = b.dr     

------Кто из них прошел в 2025 году -----------
if OBJECT_ID('zsd1') is not null DROP TABLE zsd1
SELECT t.*, t1.OS_SLUCH_REGION, t1.DATE_Z_2
INTO zsd1 
	FROM (
			SELECT *
			FROM ztemp_patuch
			
		) AS t
		LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION, 
				dbo.GROUP_CONCAT_DS(DISTINCT convert(date,dzo.DATE_Z_2, 102) , N' , ', 1)DATE_Z_2
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				WHERE(dso2.[YEAR] IN (2025) 
					AND dzo.OS_SLUCH_REGION IN (47,49,50) )
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.fam = t1.FAM AND t.im = t1.IM AND t.ot = t1.OT AND t.dr = t1.DR





SELECT *
FROM zsd1
