--�������� ��� ������ �� �����
DECLARE @ReestrMedOrgID INT
SET @ReestrMedOrgID = 63

SELECT *
FROM(
SELECT id, fam ,im, pv.ot, pv.W, 
CASE WHEN (pv.ot LIKE '%���' OR pv.ot LIKE '%���') AND w = 2 THEN 'TRUE' 
	 WHEN (pv.ot LIKE '%���' OR pv.ot LIKE '%���' OR pv.ot LIKE '%���' OR pv.ot LIKE '%���') AND w = 1 THEN 'TRUE'
ELSE 'FALSE'
END AS bol
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID AND pv.UserId IS NOT NULL 
AND (isdeleted IS NULL OR isdeleted = 0) ) AS t
WHERE bol = 'false'