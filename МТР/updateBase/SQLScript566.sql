BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[versionÑheck] 565

DECLARE @sql NVARCHAR(MAX) =
'CREATE VIEW [ZslEventShortView]
AS
SELECT        t0.ExternalId, t0.MedicalExternalId, t1.AccountId, t1.MedicalAccountId, t0.ZslMedicalEventId, zme.ZmedicalEventId AS EventId, t0.PatientId, t2.Surname, t2.PName AS Name, t2.Patronymic, t2.Birthday, 
                         t3.POLNAME AS Sex, t2.BirthPlace, t0.MedicalOrganizationCode + ''   '' + f3.nam_mok AS Lpu,
                             (SELECT        DocSeries
                               FROM            (SELECT        TOP (1) DocSeries
                                                         FROM            dbo.FactDocument AS t12
                                                         WHERE        (PersonId = t2.PersonId)) AS t13) AS DocSeries,
                             (SELECT        DocNum
                               FROM            (SELECT        TOP (1) DocNum
                                                         FROM            dbo.FactDocument AS t14
                                                         WHERE        (PersonId = t2.PersonId)) AS t15) AS DocNum,
                             (SELECT        DocType
                               FROM            (SELECT        TOP (1) DocType
                                                         FROM            dbo.FactDocument AS t14
                                                         WHERE        (PersonId = t2.PersonId)) AS t15_1) AS DocType, t1.INP, t1.InsuranceDocNumber, t1.InsuranceDocSeries, t4.smocod AS Insurance, t5.IDUMP AS AssistanceConditions, 
                         t6.IDDS AS Diagnosis, t0.Price AS ZslPrice, zme.EventPrice AS Price, zme.Rate, zme.Quantity, t0.AcceptPrice, zme.EventBegin, zme.EventEnd, t7.IDPR AS Profile, ISNULL(dbo.V015.CODE, dbo.V021.IDSPEC) 
                         AS Speciality, t9.IDRMP AS Result, t10.IDIZ AS Outcome, t11.STNAME AS PaymentStatus, zme.MEC, zme.MEE, zme.EQMA, zme.Comments AS EventComments, dbo.V008.IDVMP AS AssistanceType, 
                         t1.InsuranceDocType, t3.Id AS SexCode, dbo.F010.KOD_OKATO AS TerritoryOkato, t11.IDIDST AS PaymentStatusCode, t0.MoPrice, t0.MoPaymentStatus, dbo.globalMedicalEventType.Name AS EventTypeName, 
                         dbo.globalRegionalAttribute.Name AS RegionalAttributeName, zme.EventType, t0.RegionalAttribute, t5.UMPNAME AS AssistanceConditionsName, 
                         ksg.Kksg + isnull(''   '' + (select top 1 N_KSG from dbo.V023 where (v023.K_KSG = ksg.Kksg) and (v023.IDUMP = t0.AssistanceConditions) and (zme.EventEnd between V023.DATEBEG and isnull(V023.DATEEND, ''20790531'')) order by isnull(V023.DATEEND, ''20790531'') desc), '''') as Kksg,                         
                         dbo.TerritoryAccountView.Type, 
                         dbo.TerritoryAccountView.Direction, dbo.TerritoryAccountView.AccountNumber, dbo.TerritoryAccountView.AccountDate, dbo.TerritoryAccountView.SourceName, dbo.TerritoryAccountView.DestinationName, 
                         dbo.TerritoryAccountView.Version
FROM            dbo.ZslFactMedicalEvent AS t0 INNER JOIN
                         dbo.ZFactMedicalEvent AS zme ON zme.ZslMedicalEventId = t0.ZslMedicalEventId LEFT OUTER JOIN
                         dbo.V008 ON t0.AssistanceType = dbo.V008.Id LEFT OUTER JOIN
                         dbo.FactPatient AS t1 ON t1.PatientId = t0.PatientId LEFT OUTER JOIN
                         dbo.FactPerson AS t2 ON t2.PersonId = t1.PersonalId LEFT OUTER JOIN
                         dbo.ZFactKsgKpg AS ksg ON ksg.ZmedicalEventId = zme.ZmedicalEventId LEFT OUTER JOIN
                         dbo.V005 AS t3 ON t3.Id = t2.Sex LEFT OUTER JOIN
                         dbo.F002 AS t4 ON t4.Id = t1.InsuranceId LEFT OUTER JOIN
                         dbo.V006 AS t5 ON t5.id = t0.AssistanceConditions LEFT OUTER JOIN
                         dbo.M001 AS t6 ON t6.Id = zme.DiagnosisGeneral LEFT OUTER JOIN
                         dbo.V002 AS t7 ON t7.Id = zme.ProfileCodeId LEFT OUTER JOIN
                         dbo.V009 AS t9 ON t9.Id = t0.Result LEFT OUTER JOIN
                         dbo.V012 AS t10 ON t10.Id = t0.Outcome LEFT OUTER JOIN
                         dbo.F005 AS t11 ON t11.Id = t0.PaymentStatus LEFT OUTER JOIN
                         dbo.F010 ON t1.TerritoryOkato = dbo.F010.Id LEFT OUTER JOIN
                         dbo.F003 AS f3 ON f3.mcod = t0.MedicalOrganizationCode LEFT OUTER JOIN
                         dbo.globalMedicalEventType ON zme.EventType = dbo.globalMedicalEventType.ID LEFT OUTER JOIN
                         dbo.globalRegionalAttribute ON t0.RegionalAttribute = dbo.globalRegionalAttribute.ID LEFT OUTER JOIN
                         dbo.V015 ON zme.SpecialityCodeV015 = dbo.V015.Id LEFT OUTER JOIN
                         dbo.V021 ON zme.SpecialityCodeV021 = dbo.V021.Id LEFT OUTER JOIN
                        -- dbo.V023 AS v23 ON v23.K_KSG = ksg.Kksg LEFT OUTER JOIN
                         dbo.TerritoryAccountView ON t1.AccountId = dbo.TerritoryAccountView.TerritoryAccountId'
                         
EXECUTE sp_executesql @sql
               
EXEC [dbo].[versionUpdate] 566
COMMIT TRAN;		
END TRY
		BEGIN CATCH			
			SET @ErrorMessage= ERROR_MESSAGE()
			SET @ErrorSeverity= ERROR_SEVERITY()
			SET @ErrorState= ERROR_STATE()
			RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState)
			IF (@@trancount > 0) ROLLBACK TRAN						
		END CATCH
IF (@@trancount > 0) ROLLBACK TRAN;