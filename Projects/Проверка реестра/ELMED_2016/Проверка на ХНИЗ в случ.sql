DECLARE @p1 INT = 2061
select sl.ID, sl.SUMV, 'ХНИЗ допускаются только в III-а группе здоровья.' 
from SLUCH sl
where sl.SCHET_ID = @p1 and sl.OS_SLUCH_REGION in (22,23) 
   and RSLT in (317,318, 352,353,356,358)
   and (DS1 between 'I00%' and 'I99.9%' or DS1 between 'J40%' and 'J99.9%' or DS1 between 'C00%' and 'C99.9%' or 
     DS1 between 'D00%' and 'D48.9' or DS1 between 'E11%' and 'E14.9%')
union
select sl.ID, sl.SUMV, 'III-а группа здоровья допускается только при ХНИЗ.'
from SLUCH sl
where sl.SCHET_ID = @p1 and sl.OS_SLUCH_REGION in (22,23) 
   and RSLT in (355,357)
   and not (DS1 between 'I00%' and 'I99.9%' or DS1 between 'J40%' and 'J99.9%' or DS1 between 'C00%' and 'C99.9%' or 
     DS1 between 'D00%' and 'D48.9' or DS1 between 'E11%' and 'E14.9%')