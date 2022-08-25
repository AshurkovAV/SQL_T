SELECT *
FROM (
SELECT ap.Fam,ap.Im,ap.Ot,ap.Dr,ap.AdrOmsNaspunkt, ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv, ap.Phone
FROM ATTP_People AS ap
WHERE ap.PrMo = 460026 
AND ap.[Active] = 1
AND year(dr) IN (1997,1994,1991,1988,1985,1982,1979,1976,1973,1970,1967,1964,1961,1958,1955,1952,1949,
1946,1943,1940,1937,1934,1931,1928,1925,1922,1919)) AS p
LEFT JOIN (SELECT  [nam_mok]
      ,[FAM]
      ,[IM]
      ,[OT]
      ,[DR]
      ,[DATE_1]
      ,[DATE_2]
  FROM [DocExchange].[dbo].[temp_vd]) vd ON vd.Fam = p.Fam AND vd.Im = p.Im AND vd.Ot = p.Ot AND Convert(DATETIME, vd.Dr,126) = p.Dr
WHERE vd.Fam IS NULL AND p.Phone IS NOT NULL
  