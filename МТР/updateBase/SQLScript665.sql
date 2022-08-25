CREATE VIEW [dbo].[ZEventShortView]
AS
SELECT        t0.ExternalId, t0.MedicalExternalId, t1.AccountId, t1.MedicalAccountId, t0.ZslMedicalEventId, 
CAST(NULL AS  INT) AS EventId, 
t0.PatientId, t2.Surname, t2.PName AS Name, t2.Patronymic, t2.Birthday, 
                         t3.POLNAME AS Sex, t2.BirthPlace, 
                         (SELECT        TOP (1) mcod + '   ' + nam_mok AS Expr1
                               FROM            dbo.F003 AS f3
                               WHERE        (mcod = t0.MedicalOrganizationCode)) AS Lpu,
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
                                                         WHERE        (PersonId = t2.PersonId)) AS t15_1) AS DocType, t1.INP, 
                                                         t1.InsuranceDocNumber, 
                                                         t1.InsuranceDocSeries, 
						 t4.smocod AS Insurance, t5.IDUMP AS AssistanceConditions, 
                         CAST(NULL AS NVARCHAR(10)) Diagnosis, 
                         t0.Price AS ZslPrice, 
                         CAST(NULL AS MONEY) AS Price, 
                         CAST(NULL AS MONEY) Rate, 
                         CAST(NULL AS MONEY) Quantity, 
                         t0.AcceptPrice, 
                         t0.EventBeginZ1 EventBegin, 
                         t0.EventEndZ2 EventEnd, 
                         CAST(NULL AS NVARCHAR(100)) AS Profile, 
                         CAST(NULL AS NVARCHAR(100)) AS Speciality, 
                         CAST(t9.IDRMP AS NVARCHAR(10)) + '  ' + t9.RMPNAME AS Result, 
                         CAST(t10.IDIZ AS NVARCHAR(10)) + '  ' + t10.IZNAME AS Outcome, 
                         t11.STNAME AS PaymentStatus, 
                         CAST(NULL AS MONEY) MEC, 
                         CAST(NULL AS MONEY) MEE, 
                         CAST(NULL AS MONEY) EQMA, 
                         CAST(NULL AS INT) EventType,
                         CAST(NULL AS NVARCHAR(510)) EventComments, 
                         dbo.V008.IDVMP AS AssistanceType, dbo.V008.VMPNAME,
                         t1.InsuranceDocType, t3.Id AS SexCode, dbo.F010.KOD_OKATO AS TerritoryOkato, 
                         t11.IDIDST AS PaymentStatusCode, 
                         t0.MoPrice, 
                         t0.MoPaymentStatus, 
                         CAST(NULL AS NVARCHAR(1000)) AS EventTypeName, 
                         dbo.globalRegionalAttribute.Name AS RegionalAttributeName,  
                         t0.RegionalAttribute, t5.UMPNAME AS AssistanceConditionsName, 
                         CAST(NULL AS NVARCHAR(277)) as Kksg,                         
                         actype.TypeName TypeName, 
                         dbo.TerritoryAccountView.Direction, 
                         dbo.TerritoryAccountView.AccountNumber, 
                         dbo.TerritoryAccountView.AccountDate, 
                         dbo.TerritoryAccountView.SourceName, 
                         dbo.TerritoryAccountView.DestinationName, 
                          v9.VersionID Version,
                         v9.Version VersionName, 
                         CAST(NULL AS NVARCHAR(259)) AS Pcel, 
                         CAST(NULL AS VARCHAR(39)) dn
FROM dbo.ZslFactMedicalEvent AS t0 
LEFT OUTER JOIN dbo.V008 ON t0.AssistanceType = dbo.V008.Id 
LEFT OUTER JOIN dbo.FactPatient AS t1 ON t1.PatientId = t0.PatientId 
LEFT OUTER JOIN dbo.FactPerson AS t2 ON t2.PersonId = t1.PersonalId 
LEFT OUTER JOIN dbo.V005 AS t3 ON t3.Id = t2.Sex 
LEFT OUTER JOIN dbo.F002 AS t4 ON t4.Id = t1.InsuranceId 
LEFT OUTER JOIN dbo.V006 AS t5 ON t5.id = t0.AssistanceConditions 
LEFT OUTER JOIN dbo.V009 AS t9 ON t9.Id = t0.Result 
LEFT OUTER JOIN dbo.V012 AS t10 ON t10.Id = t0.Outcome 
LEFT OUTER JOIN dbo.F005 AS t11 ON t11.Id = t0.PaymentStatus 
LEFT OUTER JOIN dbo.F010 ON t1.TerritoryOkato = dbo.F010.Id
LEFT OUTER JOIN dbo.globalRegionalAttribute ON t0.RegionalAttribute = dbo.globalRegionalAttribute.ID 
LEFT JOIN dbo.TerritoryAccountView ON t1.AccountId = dbo.TerritoryAccountView.TerritoryAccountId
LEFT JOIN dbo.globalVersion AS v9 ON TerritoryAccountView.Version = v9.VersionID
LEFT JOIN globalAccountType AS actype ON TerritoryAccountView.[Type] = actype.AccountTypeId

