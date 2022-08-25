--Некорректное заполнение поля "Результат обращения"
declare @p1 int = 2077
select zsl.ID, zsl.SUMV, '' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
where zsl.d3_SCID = @p1 and OS_SLUCH_REGION in (7,9,11,13,15,17) 
		and (zsl.USL_OK <> 3 or IDSP <> 11 or sl.P_CEL <> '1.1')
GROUP BY zsl.ID, zsl.SUMV
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 9 AND zsl.RSLT NOT IN (343,344,345)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IN (7,8) AND zsl.RSLT NOT IN (321,322,323,324,325)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IN (17,18) AND zsl.RSLT NOT IN (347,348,349,350,351)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IN (11,12) AND zsl.RSLT NOT IN (332,333,334,335,336)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IN (13,14) AND zsl.RSLT NOT IN (337,338,339,340,341,342)
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 15 AND zsl.RSLT <> 342
UNION
SELECT zsl.ID, zsl.SUMV, 'Некорректное заполнение поля "Результат обращения"' + ' код: ' + Convert(nvarchar (3),RSLT) com 
FROM D3_ZSL_OMS zsl
WHERE zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION = 23 AND zsl.RSLT in (319,354)
group by zsl.id, zsl.SUMV, RSLT