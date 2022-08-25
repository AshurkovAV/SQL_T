declare @p1 int = 2071

SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM D3_ZSL sl
JOIN PACIENT AS p ON p.ID = sl.D3_PID
LEFT JOIN D3_SL  AS ds ON sl.ID = ds.D3_ZSLID
where sl.D3_SCID = @p1 and ds.P_CEL IN ('1.1', '1.2') and ds.PROFIL = 65 and ds.DS1 like 'Z%' 
and ds.DS1 <> 'Z01.0' AND ds.DS1 <> 'Z39.0' AND ds.DS1 <> 'Z39.1' AND ds.DS1 <> 'Z39.2' 
and ds.DS1 not between 'Z30%' and 'Z35.9'

UNION
SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM D3_ZSL sl
JOIN PACIENT AS p ON p.ID = sl.D3_PID
LEFT JOIN D3_SL  AS ds ON sl.ID = ds.D3_ZSLID
where sl.D3_SCID = @p1 and ds.P_CEL IN ('1.1', '1.2') and ds.PROFIL in (162, 163) and ds.DS1 like 'Z%' 
and ds.DS1 <> 'Z01.1' AND ds.DS1 <> 'Z39.0' AND ds.DS1 <> 'Z39.1' AND ds.DS1 <> 'Z39.2' 
and ds.DS1 not between 'Z30%' and 'Z35.9'

UNION
SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM D3_ZSL sl
JOIN PACIENT AS p ON p.ID = sl.D3_PID
LEFT JOIN D3_SL  AS ds ON sl.ID = ds.D3_ZSLID
where sl.D3_SCID = @p1 and ds.P_CEL IN ('1.1', '1.2') and ds.PROFIL in (63, 85, 86, 87, 88, 89, 90) and ds.DS1 like 'Z%' 
and ds.DS1 <> 'Z01.2' AND ds.DS1 <> 'Z39.0' AND ds.DS1 <> 'Z39.1' AND ds.DS1 <> 'Z39.2' 
and ds.DS1 not between 'Z30%' and 'Z35.9'

UNION
SELECT sl.ID, p.FAM, p.IM, p.OT, p.DR, 'Код МКБ не соответствует профили мед. помощи'
FROM D3_ZSL sl
JOIN PACIENT AS p ON p.ID = sl.D3_PID
LEFT JOIN D3_SL  AS ds ON sl.ID = ds.D3_ZSLID
where sl.D3_SCID = @p1 and ds.P_CEL IN ('1.1', '1.2') and ds.PROFIL in (136, 137) and ds.DS1 like 'Z%' 
AND ds.DS1 <> 'Z01.4' AND ds.DS1 <> 'Z39.0' AND ds.DS1 <> 'Z39.1' AND ds.DS1 <> 'Z39.2' 
AND ds.DS1 not between 'Z30%' and 'Z35.9'  