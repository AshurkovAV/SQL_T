CREATE VIEW [dbo].[GetZslEvent]
AS
SELECT DISTINCT zsl.ZslMedicalEventId,min(e.SpecialityCodeV021)prvs,
min(e.ProfileCodeId) profil,
min(e.DiagnosisGeneral) AS DS1
FROM [ZslFactMedicalEvent] zsl 
INNER JOIN ZFactMedicalEvent e on e.ZslMedicalEventId=zsl.ZslMedicalEventId  
--LEFT JOIN V021 AS v ON e.SpecialityCodeV021 = v.Id 
--LEFT JOIN v002 ON v002.Id = e.ProfileCodeId  
--LEFT JOIN m001 on m001.Id=e.DiagnosisGeneral
--WHERE pt.AccountId = @AccountId
GROUP BY zsl.ZslMedicalEventId