CREATE VIEW [dbo].[ZslEventNaprView]
AS
SELECT zsl.ZslMedicalEventId, t2.Surname, t2.PName, t2.Patronymic, t2.Birthday, t1.INP, zsl.EventBeginZ1, zsl.EventEndZ2, zsl.AssistanceConditions, t1.MedicalAccountId
FROM  ZslFactMedicalEvent AS zsl 
INNER JOIN FactPatient AS t1 ON t1.PatientId = zsl.PatientId 
LEFT OUTER JOIN FactPerson AS t2 ON t2.PersonId = t1.PersonalId
WHERE (zsl.AssistanceConditions = 1 AND zsl.AssistanceForm = 3) OR (zsl.AssistanceConditions = 2)