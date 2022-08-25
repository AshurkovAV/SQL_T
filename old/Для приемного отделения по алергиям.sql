SELECT w, YEAR(dr), MONTH(pv.HelpStart), mkb, COUNT(*)
FROM PacientVisit AS pv
WHERE pv.ConditionHelp IN (1,2)
AND pv.MKB IN ('L50.0', 'L23', 'T78.4', 'T78.0')
GROUP BY w, YEAR(dr), MONTH(pv.HelpStart), mkb
UNION ALL
SELECT w, YEAR(dr), MONTH(s.DATE_1), ds1, COUNT(*)
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
WHERE s.USL_OK IN (1,2)
AND s.DS1 IN ('L50.0', 'L23', 'T78.4', 'T78.0')
GROUP BY w, YEAR(dr), MONTH(s.DATE_1), ds1

SELECT w, YEAR(dr), MONTH(pv.HelpStart), mkb, COUNT(*)
FROM PacientVisit AS pv
WHERE pv.ConditionHelp IN (3) AND pv.PODR = 2
AND pv.MKB IN ('L50.0', 'L23', 'T78.4', 'T78.0')
GROUP BY w, YEAR(dr), MONTH(pv.HelpStart), mkb
