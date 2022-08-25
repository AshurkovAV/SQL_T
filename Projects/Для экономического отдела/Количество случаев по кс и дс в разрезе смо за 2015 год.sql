SELECT 
ISNULL((SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = CASE WHEN q LIKE '46%' THEN q ELSE 'ФОМС' END ), 'ФОМС')smo,
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = pv.ConditionHelp)ConditionHelp, 
(CASE rmod.R_MONTH
			WHEN 1 THEN 'Январь'
			WHEN 2 THEN 'Февраль'
			WHEN 3 THEN 'Март'
			WHEN 4 THEN 'Апрель'
			WHEN 5 THEN 'Май'
			WHEN 6 THEN 'Июнь'
			WHEN 7 THEN 'Июль'
			WHEN 8 THEN 'Август'
			WHEN 9 THEN 'Сентябрь'
			WHEN 10 THEN 'Октябрь'
			WHEN 11 THEN 'Ноябрь'
			WHEN 12 THEN 'Декабрь'
	    ELSE 'Не верно задан месяц'
	   END)R_MONTH,
COUNT(*)kol, SUM(sumv)sumv
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp IN(1,2) AND pv.ReestrMedOrgID IN (45, 48, 49, 54, 56, 58, 60, 61, 63, 65, 67, 69)
GROUP BY pv.Q,ConditionHelp, rmod.R_MONTH