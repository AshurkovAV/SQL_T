DECLARE @p1 INT = 2111
SELECT s.ID, p.FAM, p.IM, p.OT, p.DR, 'Услуга оказана ранее случая стационары' per
FROM SLUCH AS s
JOIN PACIENT AS p ON p.ID = s.PID
JOIN USL AS u ON u.SLID = s.ID
WHERE s.SCHET_ID = @p1 AND s.USL_OK IN (1,2)
AND u.DATE_IN < s.DATE_1