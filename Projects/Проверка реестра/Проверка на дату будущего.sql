--Проверка на дату будущего
DECLARE @ReestrMedOrgID INT
SET @ReestrMedOrgID = 5126
DECLARE @MONTH DATE
SET @MONTH = '20180131'

SELECT pv.id, pv.FAM, pv.IM, pv.OT, pv.HelpStart, pv.HelpEnd, u.DateStart, u.DateEnd, 'Проверка на дату будущего' com
FROM PacientVisit AS pv
INNER JOIN Uslugi AS u ON  u.SluchID = pv.id
WHERE pv.ReestrMedOrgID = @ReestrMedOrgID
AND (CAST(u.DateStart AS DATE) > @MONTH OR CAST(u.DateEnd AS DATE) > @MONTH OR 
CAST(pv.HelpStart AS DATE) > @MONTH OR CAST(pv.HelpEnd AS DATE) > @MONTH) 