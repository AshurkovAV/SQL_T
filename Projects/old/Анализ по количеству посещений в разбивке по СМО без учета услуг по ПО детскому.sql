SELECT (CASE WHEN Q LIKE '46%' THEN nam_smok ELSE 'иногородние' END) q, 
(SELECT v.NameWithID FROM v006 v WHERE v.id = ConditionHelp)ConditionHelp, 
(SELECT v.NameWithID FROM TypeSluchDb v WHERE v.id = TypeSluch) TypeSluch, SUM(kol+kol_inter)kol--, SUM(kol_inter)kol_inter
FROM(
SELECT f.nam_smok, t.*, 'стоматология' com
FROM(
	SELECT ISNULL(Q, 46001) q, 
	ConditionHelp, 
	ISNULL(pv.TypeSluch, 1)TypeSluch,
	SUM(CASE WHEN Q LIKE '46%' THEN pv.ED_COL*0.25 ELSE 0 END) kol, 
	SUM(CASE WHEN Q NOT LIKE '46%' THEN pv.ED_COL*0.25 ELSE 0 END) kol_inter
	FROM PacientVisit AS pv
	JOIN ReestrMedOrgDb r ON pv.ReestrMedOrgID = r.ID
	LEFT JOIN [DoctorBd] AS doc on doc.id = pv.Doctor 
	WHERE pv.ReestrMedOrgID IN (45, 48, 49, 54, 56, 58, 60, 61, 63) 
	AND  pv.Idsp = 9
	AND pv.UserId IS NOT NULL 
	AND (isdeleted IS NULL OR isdeleted = 0) 
	GROUP BY pv.Q, pv.ConditionHelp, pv.TypeSluch) AS t
LEFT JOIN f002 f ON f.smocod = t.Q

UNION ALL

SELECT f.nam_smok, t.*, 'все остальное' com
FROM(
	SELECT ISNULL(Q, 46001) q, 
	ConditionHelp, 
	ISNULL(pv.TypeSluch, 1)TypeSluch,
	SUM(CASE WHEN Q LIKE '46%' THEN 1 ELSE 0 END) kol, 
	SUM(CASE WHEN Q NOT LIKE '46%' THEN 1 ELSE 0 END) kol_inter
	FROM PacientVisit AS pv
	JOIN ReestrMedOrgDb r ON pv.ReestrMedOrgID = r.ID
	LEFT JOIN [DoctorBd] AS doc on doc.id = pv.Doctor 
	WHERE pv.ReestrMedOrgID IN (45,48,49,54,56,58,60,61,63) 
	AND (pv.OsobSluch NOT IN (2,23) OR pv.OsobSluch IS NULL) 
	AND pv.Idsp != 9
	AND pv.UserId IS NOT NULL 
	AND (isdeleted IS NULL OR isdeleted = 0) 
	GROUP BY pv.Q, pv.ConditionHelp, pv.TypeSluch) AS t
LEFT JOIN f002 f ON f.smocod = t.Q) AS tt
GROUP BY nam_smok, q, ConditionHelp, TypeSluch