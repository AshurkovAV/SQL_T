WITH recurs as 
( 
 SELECT *, 0 AS lev, CAST(name AS VARCHAR(MAX)) AS list
 FROM [V015] WHERE [HIGH] = ''
 
 UNION ALL 
  
 SELECT t.*, lev+1, c.list+' ;'+cast(t.name as varchar(max))
 FROM [V015] t JOIN recurs c
 ON c.[id] = t.[HIGH] AND t.[HIGH] <> ''
) 
SELECT 
 [id], [HIGH],
 SPACE(lev*10)+[NAME] as title,
 lev,
 list
FROM recurs 
ORDER BY list