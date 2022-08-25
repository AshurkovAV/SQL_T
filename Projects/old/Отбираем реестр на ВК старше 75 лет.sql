DECLARE @schet_id INT = 2057
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


UPDATE USL SET DIFF_K = CASE WHEN (u.DIFF_K is NOT NULL OR u.DIFF_K <= 1) THEN 1.05 ELSE u.DIFF_K END
FROM SLUCH AS sl
JOIN PACIENT AS pv ON pv.ID = sl.PID
JOIN USL AS u ON u.SLID = sl.ID
WHERE pv.SCHET_ID = @schet_id
AND sl.USL_OK = 1
AND DATEDIFF(year, pv.DR, sl.DATE_1) > 75