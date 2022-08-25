SELECT 
--(select  f.mcod FROM f003 f WHERE f.mcod = pv.Q),Q, 
--R_MONTH,
SUM(CASE WHEN pv.Q is null or pv.Q not like '46%' THEN 1 ELSE 0 END) 'Иногодние', 
SUM(CASE WHEN NOT (pv.Q is null or pv.Q not like '46%') THEN 1 ELSE 0 END) 'Местные',
COUNT(*) 'Всего', SUM(sumv)

--db.*, *
From PacientVisit pv
Join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID <> 42
--JOIN DoctorBd AS db ON db.id = pv.Doctor
Where pv.Profil IN (86,89,90) and 
r.R_MONTH = 12 AND R.R_YEAR = 2014 --AND (pv.Q is null or pv.Q not like '46%')
