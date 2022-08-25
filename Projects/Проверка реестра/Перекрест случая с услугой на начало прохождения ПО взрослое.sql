--перекрест случая с услугой на начало прохождения ПО взрослое
DECLARE @OsobSluch INT = 9
DECLARE @ReestrMedOrgID INT = 5126

select t1.id, t1.fam, t1.im, t1.ot, t1.dr, t1.helpstart, 'Перекрест случай с услугой на начало прохождения ПО' AS com
from
(select pv.*
from PacientVisit AS pv
where pv.profil = '97' AND ReestrMedOrgID = @ReestrMedOrgID and conditionHelp = 3 and typesluch = 2
and OsobSluch is null)as t1
inner join

(
select pv.*
FROM PacientVisit AS pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID 
WHERE pv.OsobSluch = @OsobSluch AND r.ID = @ReestrMedOrgID) as vd
on t1.fam = vd.fam and t1.ot = vd.ot and t1.im = vd.im and t1.dr = vd.dr and cast(t1.helpstart AS DATE) = cast(vd.helpstart  AS DATE) 