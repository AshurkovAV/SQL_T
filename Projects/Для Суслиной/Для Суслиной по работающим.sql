SELECT CASE WHEN WorkStat = 1 THEN 'Работающий'
			WHEN WorkStat = 2 THEN 'Не работающий'
			WHEN WorkStat = 3 THEN 'Студент очного отделения'
		ELSE 'Не определено' END AS [Статус занятости], kol [Количество] 
FROM
	(SELECT pv.WorkStat, 
	COUNT(*) kol
	FROM pacientvisit pv
	WHERE pv.ConditionHelp = 3 AND pv.ReestrMedOrgID = 48
	AND pv.OsobSluch = 1
	GROUP BY pv.WorkStat) AS t