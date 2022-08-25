DECLARE @dateF DATETIME = '20151231'
SELECT (SELECT f.nam_mok FROM F003 AS f WHERE f.mcod = ID_MO) ID_SMO,
	COUNT(*) AS k_vo,
	SUM(case when sex='Ì'and(god=4)then 1 else 0 end)as m4, 
	SUM(case when sex='Æ'and(god=4)then 1 else 0 end)as g4, 
	SUM(case when sex='Ì'and(god=17)then 1 else 0 end)as m17, 
	SUM(case when sex='Æ'and(god=17)then 1 else 0 end)as g17, 
	SUM(case when sex='Ì'and(god=60)then 1 else 0 end)as m60, 
	SUM(CASE when sex='Æ'and(god=55)then 1 else 0 end)as g55, 
	SUM(CASE when sex='Ì'and(god=255)then 1 else 0 end)as m255, 
	SUM(CASE when sex='Æ'and(god=255)then 1 else 0 end)as g255 
FROM
(SELECT pr_online.ID_MO ,pr_online.id,
CASE WHEN pspr.w = 1 THEN 'Ì' ELSE 'Æ' END AS sex,
CASE 
	WHEN (DATEDIFF(dd, pspr.DR, @dateF)/365.2524) >= 0 AND	(DATEDIFF(dd, pspr.DR, @dateF)/365.2524) < 5 then 4
	WHEN (DATEDIFF(dd, pspr.DR, @dateF)/365.2524) >= 5 AND	(DATEDIFF(dd, pspr.DR, @dateF)/365.2524) < 18 then 17
	WHEN (DATEDIFF(dd, pspr.DR, @dateF)/365.2524) >= 18 AND	(DATEDIFF(dd, pspr.DR, @dateF)/365.2524) < 55 and pspr.w = 2 then 55
	WHEN (DATEDIFF(dd, pspr.DR, @dateF)/365.2524) >= 55 AND	(DATEDIFF(dd, pspr.DR, @dateF)/365.2524) < 255 and pspr.w = 2 then 255
	WHEN (DATEDIFF(dd, pspr.DR, @dateF)/365.2524) >= 18 AND	(DATEDIFF(dd, pspr.DR, @dateF)/365.2524) < 60 and pspr.w = 1 then 60
	WHEN (DATEDIFF(dd, pspr.DR, @dateF)/365.2524) >= 60 AND	(DATEDIFF(dd, pspr.DR, @dateF)/365.2524) < 255 and pspr.w = 1 then 255
	ELSE 4
END	AS god
 FROM sql_online.elmed_online.dbo.AttachedPeople_ONLINE AS pr_online
LEFT JOIN AttachedPeopleSpr AS pspr ON pspr.ID = pr_online.id
WHERE pr_online.ID_SMO = 46004 
AND pr_online.x_Status = 1
AND (dstop > @dateF OR dstop IS NULL)
AND pspr.ID IS NOT NULL
) AS t
GROUP BY ID_mo


DECLARE @dateF DATETIME = '20151231'
SELECT pr_online.*
FROM sql_online.elmed_online.dbo.AttachedPeople_ONLINE AS pr_online
LEFT JOIN AttachedPeopleSpr AS pspr ON pspr.ID = pr_online.id
WHERE pr_online.ID_SMO = 46004 
AND pr_online.x_Status = 1
AND (dstop > @dateF OR dstop IS NULL)
--AND pspr.FAM = ''

SELECT COUNT(*)
FROM AttachedPeople_ONLINE AS p
WHERE p.ID_SMO = 46004 AND p.DSTOP IS NULL AND p.x_Status = 1