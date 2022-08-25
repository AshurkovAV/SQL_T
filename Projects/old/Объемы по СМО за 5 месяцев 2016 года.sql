DECLARE @uet numeric(10,2)
SET @uet = (SELECT st.Value FROM Settings st WHERE st.Name = 'Uet')

SELECT 
(SELECT CASE WHEN p.SMO LIKE '46%' THEN f.NameWithID ELSE 'Иногородние' END FROM F002 AS f WHERE f.smocod = p.SMO),
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = sl.USL_OK) USL_OK,
--(SELECT v.NameWithID FROM V015 AS v WHERE v.ID = ISNULL(tu.MSPUID, sl.MSPID) )MSPID,
ISNULL((SELECT st.NameWithId FROM TypeSluchDb st where st.id = sl.SLUCH_TYPE), 'Не проставлен тип случая')SLUCH_TYPE,
SUM(CASE WHEN sl.IDSP = 9 THEN ISNULL(sl.ED_COL, 1.00)*@uet ELSE 1.00 END) cnt_all,
SUM(1.00), SUM(sl.SUMV)SUMV
  FROM SLUCH sl
LEFT JOIN 
(SELECT sl.ID, u.CODE_MDLPU, u.MSPUID
  FROM USL u
  JOIN SLUCH sl on u.SLID = sl.ID
  JOIN Nomenclature n ON u.CODE_USL = n.Id
  WHERE sl.USL_OK = 3 AND sl.OS_SLUCH_REGION IN (13, 11, 7, 17)
  AND n.Name like '%прием%') tu ON sl.ID = tu.ID
JOIN SCHET sc ON sc.ID = sl.SCHET_ID
JOIN PACIENT AS p ON p.ID = sl.PID
WHERE (sl.USL_OK = 3 OR (sl.USL_OK = 4 and sl.SLUCH_TYPE = 3)) 
AND sl.SCHET_ID IN (8, 7, 9, 12, 13)
AND MONTH(sl.DATE_2) = sc.[MONTH]
GROUP BY p.SMO, sl.USL_OK, SLUCH_TYPE 

UNION ALL

SELECT 
(SELECT CASE WHEN p.SMO LIKE '46%' THEN f.NameWithID ELSE 'Иногородние' END FROM F002 AS f WHERE f.smocod = p.SMO),
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = sl.USL_OK) USL_OK,
ISNULL((SELECT st.NameWithId FROM TypeSluchDb st where st.id = sl.SLUCH_TYPE), 'Не проставлен тип случая')SLUCH_TYPE,
SUM(CASE WHEN sl.IDSP = 9 THEN ISNULL(sl.ED_COL, 1.00)*@uet ELSE 1.00 END) cnt_all,
SUM(1.00), SUM(sl.SUMV)sumv
  FROM SLUCH sl

JOIN SCHET sc ON sc.ID = sl.SCHET_ID
JOIN PACIENT AS p ON p.ID = sl.PID
WHERE (sl.USL_OK IN (1, 2) OR (sl.USL_OK = 4 and sl.SLUCH_TYPE = 1)) 
AND sl.SCHET_ID IN (8, 7, 9, 12, 13)
AND MONTH(sl.DATE_2) = sc.[MONTH]
GROUP BY p.SMO, sl.USL_OK, SLUCH_TYPE 