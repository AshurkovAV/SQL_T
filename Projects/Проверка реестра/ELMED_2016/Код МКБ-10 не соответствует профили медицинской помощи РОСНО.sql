declare @p1 int = 2061

SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM SLUCH sl
JOIN PACIENT AS p ON p.ID = sl.PID
where sl.SCHET_ID = @p1 and sl.USL_OK = 3 and sl.SLUCH_TYPE = 2 and sl.PROFIL = 65 and sl.DS1 like 'Z%' 
and sl.DS1 <> 'Z01.0' AND sl.DS1 <> 'Z39.0' AND sl.DS1 <> 'Z39.1' AND sl.DS1 <> 'Z39.2' 
and sl.DS1 not between 'Z30%' and 'Z35.9'

UNION
SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM SLUCH sl
JOIN PACIENT AS p ON p.ID = sl.PID
where sl.SCHET_ID = @p1 and sl.USL_OK = 3 and sl.SLUCH_TYPE = 2 and sl.PROFIL in (162, 163) and sl.DS1 like 'Z%' 
and sl.DS1 <> 'Z01.1' AND sl.DS1 <> 'Z39.0' AND sl.DS1 <> 'Z39.1' AND sl.DS1 <> 'Z39.2' 
and sl.DS1 not between 'Z30%' and 'Z35.9'

UNION
SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM SLUCH sl
JOIN PACIENT AS p ON p.ID = sl.PID
where sl.SCHET_ID = @p1 and sl.USL_OK = 3 and sl.SLUCH_TYPE = 2 and sl.PROFIL in (63, 85, 86, 87, 88, 89, 90) and sl.DS1 like 'Z%' 
and sl.DS1 <> 'Z01.2' AND sl.DS1 <> 'Z39.0' AND sl.DS1 <> 'Z39.1' AND sl.DS1 <> 'Z39.2' 
and sl.DS1 not between 'Z30%' and 'Z35.9'

UNION
SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM SLUCH sl
JOIN PACIENT AS p ON p.ID = sl.PID
where sl.SCHET_ID = @p1 and sl.USL_OK = 3 and sl.SLUCH_TYPE = 2 and sl.PROFIL in (136, 137) and sl.DS1 like 'Z%' 
AND sl.DS1 <> 'Z01.4' AND sl.DS1 <> 'Z39.0' AND sl.DS1 <> 'Z39.1' AND sl.DS1 <> 'Z39.2' 
AND sl.DS1 not between 'Z30%' and 'Z35.9'  