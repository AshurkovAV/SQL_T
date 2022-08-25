--'Соответствие даты лечения счёту'
declare @p1 int = 2071
Select zsl.ID, zsl.SUMV, 'Соответствие даты лечения счёту' com
FROM D3_ZSL zsl
join D3_SL sl on sl.d3_zslid=zsl.id and PROFIL not in (72,73)
Join D3_SCHET sc on sc.ID = zsl.D3_SCID
where zsl.D3_SCID = @p1 and
 (zsl.DATE_Z_2 > 
 convert(nvarchar(4), sc.[YEAR]) +
 case when len(convert(nvarchar(2), sc.[MONTH])) = 1 Then '0'+convert(nvarchar(2), sc.[MONTH]) Else convert(nvarchar(2), sc.[MONTH]) end +
 convert(nvarchar(2),
 CASE
  WHEN sc.[MONTH] IN(1,3,5,7,8,10,12) THEN 31
  WHEN sc.[MONTH] IN(4,6,9,11) THEN 30
  WHEN sc.[MONTH] =2 THEN CASE ISDATE(STR(10000*sc.[YEAR]+229)) WHEN 1 THEN 29 ELSE 28 END
 END) or
  sl.DATE_2 < 
 CAST(convert(nvarchar(4), sc.[YEAR]) +
 case when len(convert(nvarchar(2), sc.[MONTH])) = 1 Then '0'+convert(nvarchar(2), sc.[MONTH]) Else convert(nvarchar(2), sc.[MONTH]) end +
 convert(nvarchar(2),
 CASE
  WHEN sc.[MONTH] IN(1,3,5,7,8,10,12) THEN 31
  WHEN sc.[MONTH] IN(4,6,9,11) THEN 30
  WHEN sc.[MONTH] =2 THEN CASE ISDATE(STR(10000*sc.[YEAR]+229)) WHEN 1 THEN 29 ELSE 28 END
 END) AS DATETIME) - 360)
 group by zsl.ID, zsl.SUMV