DECLARE @schet_id INT = 2152
----Возрас более 75-------------------
--SELECT sl.id, pv.FAM, pv.IM, pv.OT, pv.DR, 
--(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз], 
--(SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = sl.IDDOKTO) docto, 
--CAST(sl.DATE_1 AS DATE)[нач.леч.], CAST(sl.DATE_2 AS DATE)[окон.леч.]
--FROM SLUCH AS sl
--JOIN PACIENT AS pv ON pv.ID = sl.PID
--JOIN USL AS u ON u.SLID = sl.ID
--WHERE pv.SCHET_ID = @schet_id
--AND sl.USL_OK = 1
--AND DATEDIFF(year, pv.DR, sl.DATE_1) > 75

--UPDATE USL SET DIFF_K = CASE WHEN (u.DIFF_K is NOT NULL OR u.DIFF_K <= 1) THEN 1.05 ELSE u.DIFF_K END
--FROM SLUCH AS sl
--JOIN PACIENT AS pv ON pv.ID = sl.PID
--JOIN USL AS u ON u.SLID = sl.ID
--WHERE pv.SCHET_ID = @schet_id
--AND sl.USL_OK = 1
--AND DATEDIFF(year, pv.DR, sl.DATE_1) > 75


--INSERT INTO USL_KSLP (IDSL,[Z_SL],SLID)
--SELECT 9041, 1.05, u.ID
--FROM SLUCH AS sl
--JOIN PACIENT AS pv ON pv.ID = sl.PID
--JOIN USL AS u ON u.SLID = sl.ID
--WHERE pv.SCHET_ID = @schet_id
--AND sl.USL_OK = 1
--AND DATEDIFF(year, pv.DR, sl.DATE_1) > 75

------Возрас более 75-------------------

--------Сопутствующее заболевание e11.7 e10.7-------------------
SELECT sl.id, pv.FAM, pv.IM, pv.OT, pv.DR, 
(SELECT mk.NameWithID FROM M001_KSG AS mk WHERE mk.IDDS = sl.DS1) [Диагноз], sd2.ds [Диаг ослож], 
(SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = sl.IDDOKTO) docto, 
CAST(sl.DATE_1 AS DATE)[нач.леч.], CAST(sl.DATE_2 AS DATE)[окон.леч.]
  FROM [SLUCH] sl
  LEFT JOIN USL AS u ON u.SLID = sl.ID
  INNER JOIN PACIENT AS pv ON pv.ID = sl.PID
  LEFT JOIN (SELECT SLID, dbo.GROUP_CONCAT_DS(DISTINCT DS, N' , ', 1) DS  
             FROM (SELECT *
				   FROM SLUCH_DS2 WHERE DS IN ('E11.7', 'E10.7')) AS t             
             GROUP BY SLID)AS sd2  ON sd2.SLID = sl.ID
  JOIN D3_SCHET_oms AS s ON s.ID = sl.SCHET_ID
WHERE sl.SCHET_ID = @schet_id AND sd2.DS IS NOT NULL AND sl.USL_OK = 1


UPDATE u SET DIFF_K = CASE WHEN (u.DIFF_K is NOT NULL OR u.DIFF_K <= 1) THEN 1.3 ELSE u.DIFF_K END
 FROM [SLUCH] sl
  LEFT JOIN USL AS u ON u.SLID = sl.ID
  INNER JOIN PACIENT AS pv ON pv.ID = sl.PID
  LEFT JOIN (SELECT SLID, dbo.GROUP_CONCAT_DS(DISTINCT DS, N' , ', 1) DS  
             FROM (SELECT *
				   FROM SLUCH_DS2 WHERE DS IN ('E11.7', 'E10.7')) AS t             
             GROUP BY SLID)AS sd2  ON sd2.SLID = sl.ID
  JOIN D3_SCHET_oms AS s ON s.ID = sl.SCHET_ID
WHERE sl.SCHET_ID = @schet_id AND sd2.DS IS NOT NULL AND sl.USL_OK = 1


INSERT INTO USL_KSLP (IDSL,[Z_SL],SLID)
SELECT 9061, 1.30, u.ID
 FROM [SLUCH] sl
  LEFT JOIN USL AS u ON u.SLID = sl.ID
  INNER JOIN PACIENT AS pv ON pv.ID = sl.PID
  LEFT JOIN (SELECT SLID, dbo.GROUP_CONCAT_DS(DISTINCT DS, N' , ', 1) DS  
             FROM (SELECT *
				   FROM SLUCH_DS2 WHERE DS IN ('E11.7', 'E10.7')) AS t             
             GROUP BY SLID)AS sd2  ON sd2.SLID = sl.ID
  JOIN D3_SCHET_oms AS s ON s.ID = sl.SCHET_ID
WHERE sl.SCHET_ID = @schet_id AND sd2.DS IS NOT NULL AND sl.USL_OK = 1



--------Сопутствующее заболевание e11.7 e10.7-------------------

