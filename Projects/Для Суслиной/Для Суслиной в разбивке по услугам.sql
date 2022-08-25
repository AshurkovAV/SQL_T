SELECT 
(SELECT m.NameWithID
   FROM M001 m WHERE m.IDDS = pv.MKB) AS [Код заб], 
   (SELECT v.NameWithID
      FROM V005 AS v WHERE v.Id = pv.W) w, 
   CASE WHEN YEAR(dr) BETWEEN 1979 AND 1994 THEN 'гр. 1979-1994'
	    WHEN YEAR(dr) BETWEEN 1955 AND 1976 THEN 'гр. 1955-1976'
	    WHEN YEAR(dr) BETWEEN 1900 AND 1952 THEN 'гр. 1900-1952'
   ELSE 'другие' END [goda], 
   COUNT(*) kol
	FROM pacientvisit pv
	--INNER JOIN Uslugi AS u2 ON u2.SluchID = pv.id
	WHERE pv.ConditionHelp = 3 AND pv.ReestrMedOrgID IN (54)
	AND pv.OsobSluch = 22 --AND pv.MKB = 'Z00.0'
GROUP BY pv.MKB, pv.W, CASE WHEN YEAR(dr) BETWEEN 1979 AND 1994 THEN 'гр. 1979-1994'
	    WHEN YEAR(dr) BETWEEN 1955 AND 1976 THEN 'гр. 1955-1976'
	    WHEN YEAR(dr) BETWEEN 1900 AND 1952 THEN 'гр. 1900-1952'
   ELSE 'другие' END 