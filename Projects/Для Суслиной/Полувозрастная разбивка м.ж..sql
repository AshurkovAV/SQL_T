SELECT  
   (SELECT v.NameWithID
      FROM V005 AS v WHERE v.Id = pv.W) w, 
   CASE WHEN YEAR(dr) BETWEEN 1979 AND 1994 THEN 'год роджения 1979-1994'
	    WHEN YEAR(dr) BETWEEN 1955 AND 1976 THEN 'год роджения 1955-1976'
	    WHEN YEAR(dr) BETWEEN 1900 AND 1952 THEN 'год роджения 1900-1952'
   ELSE 'другие' END [goda], 
   COUNT(*) kol
	FROM pacientvisit pv	
	WHERE pv.ReestrMedOrgID in (45, 48, 49, 54, 56, 58,60,61)
	AND pv.OsobSluch in (1, 22)
GROUP BY pv.W, CASE WHEN YEAR(dr) BETWEEN 1979 AND 1994 THEN 'год роджения 1979-1994'
	    WHEN YEAR(dr) BETWEEN 1955 AND 1976 THEN 'год роджения 1955-1976'
	    WHEN YEAR(dr) BETWEEN 1900 AND 1952 THEN 'год роджения 1900-1952'
   ELSE 'другие' END 