DECLARE @p1 INT = 2071
select sl.ID, sl.SUMV, 'ХНИЗ допускаются только в III-а группе здоровья.' 
from D3_ZSL sl
LEFT JOIN (SELECT * FROM D3_SL AS ds WHERE ds.PROFIL = 97) AS ds ON sl.ID = ds.D3_ZSLID
where sl.D3_SCID = @p1 and sl.OS_SLUCH_REGION in (22,23) 
   and RSLT in (317,318, 352,353,356,358)
   and (ds.DS1 between 'I00%' and 'I99.9%' or ds.DS1 between 'J40%' and 'J99.9%' or ds.DS1 between 'C00%' and 'C99.9%' or 
     ds.DS1 between 'D00%' and 'D48.9' or ds.DS1 between 'E11%' and 'E14.9%')
union
select sl.ID, sl.SUMV, 'III-а группа здоровья допускается только при ХНИЗ.'
from D3_ZSL sl
LEFT JOIN (SELECT * FROM D3_SL AS ds WHERE ds.PROFIL = 97) AS ds ON sl.ID = ds.D3_ZSLID
where sl.D3_SCID = @p1 and sl.OS_SLUCH_REGION in (22,23) 
   and RSLT in (355,357)
   and not (ds.DS1 between 'I00%' and 'I99.9%' or ds.DS1 between 'J40%' and 'J99.9%' or ds.DS1 between 'C00%' and 'C99.9%' or 
     ds.DS1 between 'D00%' and 'D48.9' or ds.DS1 between 'E11%' and 'E14.9%')