use elmed
go

SELECT v.*, ap.snils
	FROM  (SELECT distinct v.*
           FROM [test].[dbo].[result9]) AS v
    LEFT JOIN sql_cod.DocExchange.dbo.ATTP_People AS ap ON fam = column1 and im = column2 and ot = column3 and dr = column4
WHERE ap.snils IS NOT NULL 