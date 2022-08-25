SELECT 
ISNULL((SELECT f.NameWithID FROM F002 AS f WHERE f.smocod = CASE WHEN q LIKE '46%' THEN q ELSE '����' END ), '����')smo,
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = pv.ConditionHelp)ConditionHelp, 
(CASE rmod.R_MONTH
			WHEN 1 THEN '������'
			WHEN 2 THEN '�������'
			WHEN 3 THEN '����'
			WHEN 4 THEN '������'
			WHEN 5 THEN '���'
			WHEN 6 THEN '����'
			WHEN 7 THEN '����'
			WHEN 8 THEN '������'
			WHEN 9 THEN '��������'
			WHEN 10 THEN '�������'
			WHEN 11 THEN '������'
			WHEN 12 THEN '�������'
	    ELSE '�� ����� ����� �����'
	   END)R_MONTH,
COUNT(*)kol, SUM(sumv)sumv
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp IN(1,2) AND pv.ReestrMedOrgID IN (45, 48, 49, 54, 56, 58, 60, 61, 63, 65, 67, 69)
GROUP BY pv.Q,ConditionHelp, rmod.R_MONTH