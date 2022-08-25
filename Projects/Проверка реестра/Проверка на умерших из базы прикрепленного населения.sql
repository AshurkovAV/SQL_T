DROP TABLE AttachedPeop
SELECT fam,im,ot,dr,ds 
into AttachedPeop
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap WHERE ds IS NOT NULL

--SELECT pv.FAM, pv.Im, pv.OT, pv.DR, ap.ds, pv.HelpStart, 'Посещение умершего'
--FROM (SELECT * FROM AttachedPeop) ap
--JOIN (SELECT * FROM PacientVisit AS pv WHERE pv.ReestrMedOrgID = 5126) pv ON pv.fam = ap.fam AND pv.IM = ap.im AND pv.OT = ap.ot AND pv.DR = ap.dr
--WHERE ap.ds <= pv.HelpStart


SELECT pv.FAM, pv.Im, pv.OT, pv.DR, ap.ds, DATE_Z_1, 'Посещение умершего'
FROM (SELECT * FROM AttachedPeop) ap
JOIN (SELECT p.*, dz.DATE_Z_1 FROM PACIENT AS p 
			   JOIN D3_ZSL AS dz ON dz.D3_PID = p.ID 
               WHERE dz.D3_SCID = 2071) pv ON pv.fam = ap.fam AND pv.IM = ap.im AND pv.OT = ap.ot AND pv.DR = ap.dr
WHERE ap.ds <= pv.DATE_Z_1