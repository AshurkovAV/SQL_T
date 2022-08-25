declare @uet numeric(10,2)
  SET @uet = (Select st.Value FROM Settings st WHERE st.Name = 'Uet')

SELECT ISNULL((SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = CASE WHEN q LIKE '46%' THEN q ELSE 'Иногородние' END ), 'Иногородние')smo, 
(SELECT v.NameWithID FROM v006 v WHERE v.id = ConditionHelp)ConditionHelp, 
(SELECT v.NameWithID FROM TypeSluchDb v WHERE v.id = TypeSluch) TypeSluch, SUM(kol)kol
FROM(
	
SELECT ISNULL(Q, 46001) q, 
	ConditionHelp, 
	ISNULL(sl.TypeSluch, 1)TypeSluch,
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
GROUP BY q, ConditionHelp, sl.TypeSluch

UNION ALL	

	SELECT ISNULL(Q, 46001) q, 
	ConditionHelp, 
	ISNULL(pv.TypeSluch, 1)TypeSluch,
	COUNT(*) kol	
	FROM PacientVisit AS pv
	JOIN ReestrMedOrgDb r ON pv.ReestrMedOrgID = r.ID
	LEFT JOIN [DoctorBd] AS doc on doc.id = pv.Doctor 
	WHERE pv.ReestrMedOrgID IN (45,48,49,54,56,58,60,61,63,65,67)	
	AND pv.ConditionHelp IN (1, 2)
	AND pv.UserId IS NOT NULL 
	AND (isdeleted IS NULL OR isdeleted = 0) 
	GROUP BY pv.Q, pv.ConditionHelp, pv.TypeSluch) AS tt
GROUP BY q, ConditionHelp, TypeSluch