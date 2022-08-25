SELECT f.name_tfk, fta.AccountNumber, fta.AccountDate, kol ,fta.price, zfme.price-- SUM(kol)kol, SUM(fta.price)sumv
FROM FactTerritoryAccount AS fta
JOIN F001 AS f ON fta.Source = f.tf_okato
JOIN (SELECT t.TerritoryAccountId, SUM(kol)kol, SUM(price)price
      FROM (
			  SELECT fp.AccountId TerritoryAccountId, zfme.ZslMedicalEventId, COUNT(*) kol, SUM(zfme.Price)Price, SUM(kolmek)kolmek
			  FROM FactPatient AS fp 
			  JOIN ZslFactMedicalEvent AS zfme ON zfme.PatientId = fp.PatientId
			  LEFT (SELECT zs.ZslMedicalEventId, COUNT(*) kolmek
			          FROM ZFactSank AS zs 
			        WHERE zs.[Type] = 1 --AND zs.ZslMedicalEventId = zfme.ZslMedicalEventId 
			        GROUP BY zs.ZslMedicalEventId ) AS sank ON  sank.ZslMedicalEventId = zfme.ZslMedicalEventId
			  GROUP BY fp.AccountId, zfme.ZslMedicalEventId) AS t
      GROUP BY t.TerritoryAccountId
      ) AS zfme ON zfme.TerritoryAccountId = fta.TerritoryAccountId
--WHERE fta.AccountDate BETWEEN

--GROUP BY f.name_tfk, fta.AccountNumber, fta.AccountDate

--SELECT *
--FROM F001 AS f

--SELECT *
--FROM FactPatient
--WHERE AccountId = 28362