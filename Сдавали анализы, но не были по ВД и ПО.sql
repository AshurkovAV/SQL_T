if OBJECT_ID('zsd1') is not null DROP TABLE zsd1

GO

SELECT *
INTO zsd1234
FROM(
SELECT  [Фамилия], [Имя], [Отчество], CAST([Дата рождения] AS DATE)[Дата рождения], dbo.GROUP_CONCAT_DS(DISTINCT [Дата получения], N' , ', 1)[Дата получения], dbo.GROUP_CONCAT_DS(DISTINCT t, N' , ', 1)t
				FROM(	
				--SELECT  fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'GLUK't				
				--FROM [gluk0607$] AS g
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'HOL't
				--FROM hol0607$
				--UNION ALL
				--SELECT  fam [Фамилия], im [Имя], ot [Отчество], dr1 [Дата рождения], dr [Дата получения], 'GLUK't				
				--FROM [gluk08$] AS g
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr1 [Дата рождения], dr [Дата получения], 'HOL't
				--FROM hol08$
				--UNION ALL
				SELECT  fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'GLUK't				
				FROM gluk101124$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'HOL't
				FROM hol101124$
				
				
				
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'GLUK't				
				--FROM gluk0607$
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'HOL't
				--FROM hol0607$
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'GLUK't		
				--FROM gluk101124$
				--WHERE CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102)	 >='20241101'
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'HOL't
				--FROM hol101124$
				--WHERE CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102)	 >='20241101'
				
				UNION ALL
				
				
				
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'GLUK't				
				FROM gluk010225$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'HOL't
				FROM hol010225$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'GLUK't				
				FROM gluk_030425$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'HOL't
				FROM hol_030425$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'GLUK't				
				FROM gluk0525$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'HOL't
				FROM hol0525$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'GLUK't				
				FROM gluk090725$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'HOL't
				FROM hol090725$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'GLUK't				
				FROM gluk110825$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [Дата получения], 'HOL't
				FROM hol110825$
				) AS d
				GROUP BY  [Фамилия], [Имя], [Отчество], [Дата рождения]) AS t

if OBJECT_ID('zs1')  is not null DROP TABLE zs1
GO
------------//2 находим кто из них уже прошел вд и по//----------------
SELECT *
INTO zs1 
	FROM zsd1 AS t
		LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				WHERE dso2.[YEAR] IN (2025)
					AND dzo.OS_SLUCH_REGION IN (47,49,50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.Фамилия = t1.FAM AND t.Имя = t1.IM AND t.Отчество = t1.OT AND t.[Дата рождения] = t1.DR
WHERE  t.[Дата рождения] IS NOT NULL AND [Дата получения] IS NOT NULL


------------//3 проставляем телефоны//----------------
if OBJECT_ID('zt1') is not null DROP TABLE zt1

SELECT *
INTO zt1
FROM(
	SELECT *
	FROM zs1
	WHERE fam IS null) AS tt
LEFT JOIN telefon1 AS t ON tt.Фамилия=t.NOM and tt.Имя= t.PRENOM and tt.Отчество=t.PATRONYME and tt.[Дата рождения]=t.NE_LE

------------//3 проставляем адреса и номер полиса//----------------
if OBJECT_ID('zt2') is not null DROP TABLE zt2

SELECT enp, t2.*, ISNULL(dl.Адрес_район , '-') + ' ' + isnull(dl.Адрес_населённый_пункт , '-') + ' ' + isnull(dl.Адрес_улица , '-') + ' ' + ISNULL(dl.Адрес_дом , '-') + ' ' + isnull(dl.Адрес_корпус , '-')  + ' ' + isnull(dl.Адрес_квартира , '-') addr
INTO zt2
	FROM zt1 t2
		LEFT JOIN [elmed].[dbo].Prikrep dl ON dl.Фамилия =t2.Фамилия and dl.Имя =t2.Имя and dl.Отчество =t2.Отчество and dl.Дата_рождения =t2.[Дата рождения]

-----------4.

-------------Союзная---------------------
-----------Заводская---------------------
SELECT distinct z.*,
CASE WHEN p.fam IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt2 z
LEFT JOIN [dbo].[Perepis] p ON p.fam = z.Фамилия 
									AND p.im = z.Имя
									AND p.ot = z.Отчество
									AND p.dr = z.[Дата рождения]
