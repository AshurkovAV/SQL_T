SELECT sl.id, p.FAM, p.IM, p.OT, CAST(p.DR AS DATE) dr, (SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = sl.IDDOKTO) doc, 
CAST(sl.DATE_1 AS DATE) HelpStart, CAST(sl.DATE_2 AS DATE) HelpEnd,
'Ошибка в коде МКБ (Z00.1) не используется у детей более 3 лет' AS per
FROM SLUCH AS sl
JOIN PACIENT AS p ON p.ID = sl.PID
WHERE sl.SCHET_ID = 2059
AND sl.USL_OK = 3 
AND DATEDIFF(year, p.DR, sl.DATE_2) > 3
AND sl.DET = 1 AND sl.DS1 = 'Z00.1'