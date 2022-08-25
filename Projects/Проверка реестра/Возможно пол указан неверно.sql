--Возможно пол указан не верно
DECLARE @ReestrMedOrgID INT
SET @ReestrMedOrgID = 63

SELECT *
FROM(
SELECT id, fam ,im, pv.ot, pv.W, 
CASE WHEN (pv.ot LIKE '%вна' OR pv.ot LIKE '%чна') AND w = 2 THEN 'TRUE' 
	 WHEN (pv.ot LIKE '%вич' OR pv.ot LIKE '%ьич' OR pv.ot LIKE '%глы' OR pv.ot LIKE '%мич') AND w = 1 THEN 'TRUE'
ELSE 'FALSE'
END AS bol
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.UserId IS NOT NULL 
AND (isdeleted IS NULL OR isdeleted = 0) ) AS t
WHERE bol = 'false'