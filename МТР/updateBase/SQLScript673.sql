ALTER VIEW [dbo].[MedicalAccountView]
AS
SELECT        dbo.FactMedicalAccount.MedicalAccountId, dbo.FactMedicalAccount.MedicalOrganization, dbo.FactMedicalAccount.Date, dbo.FactMedicalAccount.AccountNumber, dbo.FactMedicalAccount.AccountDate, 
                         dbo.FactMedicalAccount.InsurancePayer, dbo.FactMedicalAccount.Price, dbo.FactMedicalAccount.AcceptPrice, dbo.FactMedicalAccount.MECPenalties, dbo.FactMedicalAccount.MEEPenalties, 
                         dbo.FactMedicalAccount.EQMAPenalties, dbo.FactMedicalAccount.Comments, dbo.FactMedicalAccount.Status, dbo.F003.mcod AS CodeMo, dbo.F003.nam_mok AS ShortNameMo, 
                         dbo.FactMedicalAccount.Version, ExternalId
FROM            dbo.FactMedicalAccount INNER JOIN
                         dbo.F003 ON dbo.FactMedicalAccount.MedicalOrganization = dbo.F003.Id