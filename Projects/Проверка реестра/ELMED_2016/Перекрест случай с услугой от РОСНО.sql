DECLARE @p1 INT = 2061

SELECT t.ID, t.FAM, t.IM, t.OT, t.DR, s.DS1, s.IDDOKTO, s.DATE_1, 'Перекрест случай с услугой'
FROM( 
SELECT sl.ID, pa.FAM, pa.IM, pa.OT, pa.DR
  FROM SLUCH sl
JOIN PACIENT pa on sl.PID = pa.ID
JOIN (SELECT (CASE WHEN u.PROFIL in (2,3,136,137) THEN 990 ELSE u.PROFIL END) PROFIL, 
	  u.DATE_OUT, pa.FAM, pa.IM, pa.OT, pa.DR, u.slid, sl.USL_OK
	  FROM USL u
	  JOIN SLUCH sl ON u.SLID = sl.ID
	  JOIN PACIENT pa ON sl.PID = pa.ID
	  WHERE u.SCHET_ID = @p1 AND sl.USL_OK = 3 
	) AS u
ON pa.FAM = u.FAM and pa.IM = u.IM and pa.OT = u.OT and pa.DR = u.DR and CAST(sl.DATE_2 AS DATE) = CAST(u.DATE_OUT AS DATE)
AND (CASE WHEN sl.PROFIL IN (2,3,136,137) THEN 990 ELSE sl.PROFIL 
	END) = u.PROFIL
where sl.SCHET_ID = @p1 AND sl.USL_OK = 3 AND sl.OS_SLUCH_REGION IS NULL AND sl.id<>u.slid
GROUP BY sl.ID, pa.FAM, pa.IM, pa.OT, pa.DR) AS t
JOIN SLUCH AS s ON s.ID = t.ID