DROP TABLE zs1
DROP TABLE zsd1

SELECT *
INTO zsd1
FROM(
SELECT  [Фамилия], [Имя], [Отчество], [Дата рождения], dbo.GROUP_CONCAT_DS(DISTINCT [Дата получения], N' , ', 1)[Дата получения], dbo.GROUP_CONCAT_DS(DISTINCT t, N' , ', 1)t
				FROM(
				--	SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], rez [Дата получения], 'OAK0112't
				--	FROM [oak1223$]
				--	UNION ALL
				--	SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], rez [Дата получения], 'hol0112't
				--	FROM [hol1223$]
				--	UNION ALL
				--	SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], rez [Дата получения], 'GLUK0112't
				--	FROM [GLUK1223$]
				--	UNION ALL
				--SELECT [Фамилия], [Имя], [Отчество], [Дата рождения], [Дата получения], 'OAK't
				--FROM oak$
				--UNION ALL
				--SELECT [Фамилия], [Имя], [Отчество], [Дата рождения], [Дата получения], 'HOL't
				--FROM hol$
				--UNION ALL
				--SELECT [Фамилия], [Имя], [Отчество], [Дата рождения], [Дата получения], 'GLUK't
				--FROM GLUK$
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'GLUK't				
				--FROM gluk0607$
				--UNION ALL
				--SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'HOL't
				--FROM hol0607$
				--UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'GLUK't				
				FROM gluk101124$
				UNION ALL
				SELECT fam [Фамилия], im [Имя], ot [Отчество], dr [Дата рождения], dp [Дата получения], 'HOL't
				FROM hol101124$
				) AS d
				GROUP BY  [Фамилия], [Имя], [Отчество], [Дата рождения]) AS t

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
				WHERE dso2.[YEAR] IN (2024)
					AND dzo.OS_SLUCH_REGION IN (47,49,50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.Фамилия = t1.FAM AND t.Имя = t1.IM AND t.Отчество = t1.OT AND t.[Дата рождения] = t1.DR


------------//3 проставляем телефоны//----------------
DROP TABLE zt1
SELECT *
INTO zt1
FROM(
	SELECT *
	FROM zs1
	WHERE fam IS null) AS tt
LEFT JOIN [test].[dbo].[Tel] t ON tt.Фамилия=f and tt.Имя=i and tt.Отчество=o and tt.[Дата рождения]=d



--SELECT distinct z.*
--FROM zt z
--LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = z.Фамилия 
--									AND p.Имя = z.Имя
--									AND p.Отчество = z.Отчество
--									AND p.[Дата рождения] = z.[Дата рождения]
--INNER JOIN (SELECT * FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap WHERE prmo=460026) ap ON  
--												ap.fam= z.Фамилия 
--												AND ap.im=z.Имя 
--												AND ap.ot= z.Отчество
--												AND ap.dr = z.[Дата рождения]
--WHERE p.Фамилия IS  NULL


-----------4.
-----------Союзная---------------------
SELECT distinct z.*
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = z.Фамилия 
									AND p.Имя = z.Имя
									AND p.Отчество = z.Отчество
									AND p.[Дата рождения] = z.[Дата рождения]
WHERE p.Фамилия IS NULL
-----------Союзная---------------------


-----------Заводская---------------------
SELECT distinct z.*
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = z.Фамилия 
									AND p.Имя = z.Имя
									AND p.Отчество = z.Отчество
									AND p.[Дата рождения] = z.[Дата рождения]
WHERE p.Фамилия IS not NULL
-----------Заводская---------------------		

