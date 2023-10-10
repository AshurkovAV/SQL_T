SELECT replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([למ], ' - Óק.13', ''), ' - Óק.1', ''), ' - Óק.3', ''), ' - Óק.4', ''), ' - Óק.29', ''), ' - Óק.27', '')
, ' - Óק.9', ''), ' - Óק.6', ''), ' - Óק.20', '')
, ' - Óק.23', ''), ' - Óק.28', ''), ' - Óק.8', '')
, ' - Óק.25', ''), ' - Óק.6', ''), ' - Óק.5', '')
, ' - Óק.7', ''), ' - Óק.21', ''), ' - Óק.22', '')
, ' - Óק.26', ''), ' - Óק.2', ''), ' - Óק.24', '')
, 'À1', 'À'), 'À2', 'À'), 'À3', 'À'), 'À4', 'À'), 'À5', 'À'), 'À6', 'À'), 'À7', 'À'), 'À8', 'À'), 'À9', 'À'), 'À0', 'À'), [ןאצטוםע], COUNT(*)kol, 1 as k,
CASE WHEN COUNT(*) <10 THEN 'ÄÎ 10'
	 WHEN COUNT(*) >= 10 AND  COUNT(*) < 20 THEN 'C 10 ÄÎ 20'
	 WHEN COUNT(*) >= 20 AND  COUNT(*) < 30 THEN 'C 20 ÄÎ 30'
	 WHEN COUNT(*) >= 30 AND  COUNT(*) < 40 THEN 'C 30 ÄÎ 40'
	 WHEN COUNT(*) >= 40 AND  COUNT(*) < 50 THEN 'C 40 ÄÎ 50'
	 WHEN COUNT(*) >= 50 THEN '50 ט במכוו'
	 ELSE cast(COUNT(*) AS NVARCHAR(10))  END 

FROM [15112022chast_call_polik]
GROUP BY  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([למ], ' - Óק.13', ''), ' - Óק.1', ''), ' - Óק.3', ''), ' - Óק.4', ''), ' - Óק.29', ''), ' - Óק.27', '')
, ' - Óק.9', ''), ' - Óק.6', ''), ' - Óק.20', '')
, ' - Óק.23', ''), ' - Óק.28', ''), ' - Óק.8', '')
, ' - Óק.25', ''), ' - Óק.6', ''), ' - Óק.5', '')
, ' - Óק.7', ''), ' - Óק.21', ''), ' - Óק.22', '')
, ' - Óק.26', ''), ' - Óק.2', ''), ' - Óק.24', '')
, 'À1', 'À'), 'À2', 'À'), 'À3', 'À'), 'À4', 'À'), 'À5', 'À'), 'À6', 'À'), 'À7', 'À'), 'À8', 'À'), 'À9', 'À'), 'À0', 'À'), [ןאצטוםע]

--SELECT *
--FROM [15112022chast_call_polik]