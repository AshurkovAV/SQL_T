DECLARE @d DATETIME
SELECT @d = '20151031' --выставляем дату на которую будем просматривать
SELECT (SELECT f.nam_smok FROM F002_ONLINE AS f WHERE f.smocod = ID_SMO) ID_SMO,
	COUNT(*) AS k_vo,
	SUM(case when sex='М'and(god=4)then 1 else 0 end)as m4, 
	SUM(case when sex='Ж'and(god=4)then 1 else 0 end)as g4, 
	SUM(case when sex='М'and(god=17)then 1 else 0 end)as m17, 
	SUM(case when sex='Ж'and(god=17)then 1 else 0 end)as g17, 
	SUM(case when sex='М'and(god=60)then 1 else 0 end)as m60, 
	SUM(case when sex='Ж'and(god=55)then 1 else 0 end)as g55, 
	SUM(case when sex='М'and(god=255)then 1 else 0 end)as m255, 
	SUM(case when sex='Ж'and(god=255)then 1 else 0 end)as g255 
from 
(select pr_online.ID_SMO ,pr_online.id,
case when pspr.w = 1 then'М'else'Ж'end as sex,
case 
	when (DATEDIFF(dd, pspr.DR, @d)/365.2524) >= 0 AND	(DATEDIFF(dd, pspr.DR, @d)/365.2524) < 5 then 4
	when (DATEDIFF(dd, pspr.DR, @d)/365.2524) >= 5 AND	(DATEDIFF(dd, pspr.DR, @d)/365.2524) < 18 then 17
	when (DATEDIFF(dd, pspr.DR, @d)/365.2524) >= 18 AND	(DATEDIFF(dd, pspr.DR, @d)/365.2524) < 55 and pspr.w = 2 then 55
	when (DATEDIFF(dd, pspr.DR, @d)/365.2524) >= 55 AND	(DATEDIFF(dd, pspr.DR, @d)/365.2524) < 255 and pspr.w = 2 then 255
	when (DATEDIFF(dd, pspr.DR, @d)/365.2524) >= 18 AND	(DATEDIFF(dd, pspr.DR, @d)/365.2524) < 60 and pspr.w = 1 then 60
	when (DATEDIFF(dd, pspr.DR, @d)/365.2524) >= 60 AND	(DATEDIFF(dd, pspr.DR, @d)/365.2524) < 255 and pspr.w = 1 then 255
	else 4
end	as god
from AttachedPeople_ONLINE pr_online
INNER JOIN sqlserver.elmed.dbo.AttachedPeopleSpr pspr ON pr_online.ID = pspr.id
WHERE hid = 17) AS t
group by ID_SMO