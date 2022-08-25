SELECT 
CASE WHEN s.mkb BETWEEN 'C00' AND 'C97' THEN '"C00" - "C97"' 
	 WHEN s.mkb BETWEEN 'I60' AND 'I69' THEN '"I60 - I69"'
	 WHEN s.mkb BETWEEN 'I60' AND 'I64' THEN '"I60 - I64"'
	 WHEN s.mkb BETWEEN 'I10' AND 'I13' THEN '"I10 - I13"'
	 WHEN s.mkb BETWEEN 'I20' AND 'I25' THEN '"I20 - I25"'
	 WHEN s.mkb = 'I21' THEN '"I21"'
	 WHEN s.mkb = 'I22' THEN '"I22"'
	 WHEN s.mkb BETWEEN 'J00' AND 'J99' THEN '"J00 - J99"'
	 WHEN s.mkb BETWEEN 'J12' AND 'J18' THEN '"J12 - J18"'
	 WHEN s.mkb BETWEEN 'J40' AND 'J47' THEN '"J40 - J47"'
	 WHEN s.mkb BETWEEN 'K00' AND 'K93' THEN '"K00 - K93"'
ELSE 'ÄÐÓÃÈÅ' END 'MKB',
p.Uchastok 'Ó×ÀÑÒÎÊ', p.FAM, p.im, p.ot, SUBSTRING(CONVERT(VARCHAR, p.DR, 104),1, 11)DR, s.mkb, s.adrpro
FROM [ssmp2] s 
INNER JOIN PerepisByRMS p ON s.fam = p.FAM AND s.im = p.IM AND s.ot = p.OT AND s.dr = p.dr 
WHERE kodlpu = '460026' 
AND 2015 - YEAR(p.dr) > 17 
AND s.dtviz BETWEEN '20150601' AND '20150608'
--AND s.mkb BETWEEN 'C00' AND 'C97'
--AND s.mkb BETWEEN 'I60' AND 'I69'
--AND s.mkb BETWEEN 'I60' AND 'I64'
--AND s.mkb BETWEEN 'I10' AND 'I13'
--AND s.mkb BETWEEN 'I20' AND 'I25'
--AND s.mkb = 'I21' 
--AND s.mkb = 'I22' 
--AND s.mkb BETWEEN 'J00' AND 'J99'
--AND s.mkb BETWEEN 'J12' AND 'J18'
--AND s.mkb BETWEEN 'J40' AND 'J47'
--AND s.mkb BETWEEN 'K00' AND 'K93'
--GROUP BY p.Uchastok--, s.mkb