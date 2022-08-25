DECLARE @d DATETIME
SELECT @d = '20150730' --выставляем дату на которую будем просматривать
SELECT (SELECT f.nam_smok FROM F002 AS f WHERE f.smocod = Smo_Kod) smo_kod,
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
(select as1.Smo_Kod ,pr.id,
case when pr.w = 1 then'М'else'Ж'end as sex,
case 
	when (DATEDIFF(dd, pr.DR, @d)/365.25) >= 0 AND	(DATEDIFF(dd, pr.DR, @d)/365.25) < 5 then 4
	when (DATEDIFF(dd, pr.DR, @d)/365.25) >= 5 AND	(DATEDIFF(dd, pr.DR, @d)/365.25) < 18 then 17
	when (DATEDIFF(dd, pr.DR, @d)/365.25) >= 18 AND	(DATEDIFF(dd, pr.DR, @d)/365.25) < 55 and pr.w = 2 then 55
	when (DATEDIFF(dd, pr.DR, @d)/365.25) >= 55 AND	(DATEDIFF(dd, pr.DR, @d)/365.25) < 255 and pr.w = 2 then 255
	when (DATEDIFF(dd, pr.DR, @d)/365.25) >= 18 AND	(DATEDIFF(dd, pr.DR, @d)/365.25) < 60 and pr.w = 1 then 60
	when (DATEDIFF(dd, pr.DR, @d)/365.25) >= 60 AND	(DATEDIFF(dd, pr.DR, @d)/365.25) < 255 and pr.w = 1 then 255
	else 4
end	as god
from AttachedPeople pr
LEFT JOIN AttachedSmo AS as1 ON as1.ID_People = pr.ID) AS t
group by t.Smo_Kod