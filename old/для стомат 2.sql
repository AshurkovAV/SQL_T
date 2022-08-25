
--UPDATE PacientVisit SET MSPID = 174 
----SELECT * FROM PacientVisit AS pv
--WHERE ReestrMedOrgID = 81
----AND MSPID = 173 
--AND Profil = 86

--UPDATE PacientVisit SET Idsp = 9 
----SELECT * FROM PacientVisit AS pv
--WHERE ReestrMedOrgID = 81
----AND MSPID = 173 
----AND Profil = 86

--UPDATE PacientVisit SET MSPID = 177
----SELECT * FROM PacientVisit AS pv
--WHERE ReestrMedOrgID = 81
----AND MSPID = 173 
--AND Profil = 90

UPDATE PacientVisit SET TypeHelp = 13
--SELECT * FROM PacientVisit AS pv
WHERE ReestrMedOrgID = 81
--AND MSPID = 173 
AND TypeHelp != 13