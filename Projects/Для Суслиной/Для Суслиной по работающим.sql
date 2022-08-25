SELECT CASE WHEN WorkStat = 1 THEN '����������'
			WHEN WorkStat = 2 THEN '�� ����������'
			WHEN WorkStat = 3 THEN '������� ������ ���������'
		ELSE '�� ����������' END AS [������ ���������], kol [����������] 
FROM
	(SELECT pv.WorkStat, 
	COUNT(*) kol
	FROM pacientvisit pv
	WHERE pv.ConditionHelp = 3 AND pv.ReestrMedOrgID = 48
	AND pv.OsobSluch = 1
	GROUP BY pv.WorkStat) AS t