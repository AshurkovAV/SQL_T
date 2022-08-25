SELECT COUNT(*) kol -- DATEDIFF(DAY, aps.DR, GETDATE())/365.2524, *
FROM AttachedPeopleSpr AS aps
INNER JOIN SQL_ONLINE.ELMED_ONLINE.dbo.AttachedPeople_ONLINE pon ON pon.id = aps.ID 
WHERE pon.x_status = 1 AND pon.ds IS NULL
AND DATEDIFF(DAY, aps.DR, GETDATE())/365.2524 >= 18 