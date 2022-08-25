SELECT t.*
FROM(
SELECT ap.Fam,ap.Im,ap.Ot,ap.Dr, ap.AdrOmsNaspunkt, ap.AdrOmsUl, ap.AdrOmsDom, ap.AdrOmsKorp, ap.AdrOmsKv, ap.Phone, ap.PrMoDtBeg
FROM ATTP_People AS ap
WHERE ap.PrMo = 460026 
AND ap.[Active] = 1
AND year(dr) IN (1961,1958,1964,1967,1970,1979,1973,1976,1985,1982,1988,1994,1991,1997,1955)-- (1998,1995,1992,1989,1986,1983,1980,1977,1974,1971,1968,1965,1962,1959,1956,1953,1950,1947,1944,1941)
) AS t
LEFT JOIN (SELECT * FROM temp_vdisp AS tv) v ON v.Fam = t.Fam AND v.Im = t.Im AND v.Ot = t.Ot aND  v.[drt] = t.Dr
WHERE v.FAM IS NULL AND t.Phone IS NULL AND year(PrMoDtBeg) = 2018