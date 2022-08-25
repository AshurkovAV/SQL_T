declare @uet numeric(10,2)
  SET @uet = (Select st.Value FROM Settings st WHERE st.Name = 'Uet')

SELECT ISNULL((SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = CASE WHEN q LIKE '46%' THEN q ELSE 'Иногородние' END ), 'Иногородние')smo, 
(SELECT v.NameWithID FROM V002 AS v WHERE v.Id = profil)profil,
SUM(kol)kol
FROM(
	
SELECT ISNULL(Q, 46001) q, 
	profil,
SUM(CASE WHEN sl.IDSP = 9 THEN sl.ED_COL*@uet ELSE 1.00 END) kol
  FROM PacientVisit sl
LEFT JOIN 
(SELECT sl.ID
  FROM Uslugi u
  JOIN PacientVisit sl on u.SluchID = sl.ID
  JOIN Nomenclature n ON u.CodUslugi = n.Id
  WHERE sl.ConditionHelp = 3 AND sl.OsobSluch IN (13, 11, 7, 17)
  AND sl.UserId IS NOT NULL 
  AND (isdeleted IS NULL OR isdeleted = 0)
  AND n.Name like '%прием%') tu ON sl.ID = tu.ID
WHERE (sl.ConditionHelp = 3 OR (sl.ConditionHelp = 4 and sl.TypeSluch = 3)) AND sl.ReestrMedOrgID IN (45, 48, 49, 54, 56, 58, 60, 61, 63,65,67,69)
AND TypeSluch = 2 AND OsobSluch = 11
GROUP BY q, profil)AS tt
 GROUP BY q, profil