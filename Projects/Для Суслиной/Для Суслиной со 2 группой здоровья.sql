
SELECT P.CITY, P.UL, P.DOM,
--(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = OsobSluch), 
pv.FAM, pv.IM, pv.OT, cast(pv.DR AS DATE)DR, pv.W, cast(pv.HelpEnd AS DATE)HelpEnd, 
(SELECT m.NameWithID FROM M001 AS m WHERE m.IDDS = pv.MKB)MKB,
(SELECT D.FIO FROM [DoctorBd] AS d WHERE d.id = pv.Doctor)Doctor, PV.GrZdorov, 
ISNULL(CAST((SELECT w.NameWithID 
              FROM [WorkStatDb] w WHERE w.Id = PV.WorkStat) AS VARCHAR), 'Нет сведений')WorkStat
From PacientVisit pv
Join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID 
LEFT JOIN PEOPLE P ON P.FAM = pv.FAM AND P.IM = pv.IM AND P.OT = pv.OT AND P.DR = pv.DR
Where 
pv.ConditionHelp = 3 and 
r.R_MONTH BETWEEN 1 AND 11 AND R.R_YEAR = 2014
AND pv.OsobSluch in (1) 
AND PV.GrZdorov = 2
--AND pv.FAM = 'Аникеева' AND pv.IM = 'Кристина' --AND pv.OT = '' 