DECLARE @p1 INT = 5126
select 'ХНИЗ допускаются только в III-а группе здоровья.', pv.FAM, im, ot, dr, mkb, pv.HelpResult
FROM PacientVisit AS pv
where pv.ReestrMedOrgID = @p1 AND pv.OsobSluch in (22,23) 
   AND pv.HelpResult in (317,318, 352,353,356,358)
   and (mkb between 'I00%' AND 'I99.9%' OR mkb between 'J40%' AND 'J99.9%' OR mkb BETWEEN 'C00%' AND 'C99.9%' OR 
     mkb between 'D00%' and 'D48.9' or mkb between 'E11%' and 'E14.9%')
union
select 'III-а группа здоровья допускается только при ХНИЗ.', pv.FAM, im, ot, dr, mkb, pv.HelpResult
from PacientVisit AS pv
where pv.ReestrMedOrgID = @p1 AND pv.OsobSluch in (22,23) 
   AND pv.HelpResult in (355,357)
   and not (mkb between 'I00%' and 'I99.9%' or mkb between 'J40%' and 'J99.9%' or mkb between 'C00%' and 'C99.9%' or 
     mkb between 'D00%' and 'D48.9' or mkb between 'E11%' and 'E14.9%')