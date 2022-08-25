
-- Перекрест случая с услугой
DECLARE @t TABLE (
ID int NOT NULL, 
fam VARCHAR (250) NULL,
im VARCHAR (250) NULL,
ot VARCHAR (250) NULL,
DR DATETIME NULL,
smo INT NULL,
doctor VARCHAR (250) NULL,
HelpStart DATETIME NULL,
DateStart DATETIME NULL,
HelpEnd DATETIME NULL,
DateEnd DATETIME NULL
)

INSERT INTO @t
SELECT pv.ID, pv.FAM, pv.IM, pv.OT, pv.DR , Q, (SELECT d.FioWithId
                                                             FROM DoctorBd d WHERE d.id = pv.Doctor), 
CAST(HelpStart AS DATE)HelpStart, CAST(DateStart AS DATE)DateStart, CAST(HelpEnd AS DATE)HelpEnd, CAST(DateEnd AS DATE)DateEnd
FROM pacientvisit AS pv
JOIN (SELECT u.PROFIL, u.DateEnd, u.DateStart, pv.FAM, pv.IM, pv.OT, pv.DR, pv.Doctor 
      FROM PacientVisit AS pv
      INNER JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
      INNER JOIN Uslugi AS u ON u.SluchID = pv.id
      WHERE pv.ReestrMedOrgID = @p1 AND u.CodUslugi in ('B04.031.002', 'B04.023.002', 'B04.029.002', 'B04.010.002', 'B04.053.004', 'B04.010.002', 'B04.053.002',
      'B04.064.002', 'B04.058.003', 'B04.028.002', 'B04.001.002', 'B04.050.002', 'B01.047.005', 'B04.023.002')) as u
      ON pv.ReestrMedOrgID = @p1
      AND pv.OsobSluch IS NULL  
      AND pv.FAM = u.FAM AND pv.IM = u.IM AND pv.OT = u.OT AND pv.DR = u.DR 
      AND (CAST(pv.HelpStart AS DATE) = CAST(u.DateStart AS DATE) 
      AND  CAST(pv.HelpEnd AS DATE) = CAST(u.DateEnd AS DATE)) 
      AND pv.PROFIL = u.PROFIL

Select t.ID, 'Перекрест случая с услугой ' com
from @t AS t