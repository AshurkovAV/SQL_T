ALTER VIEW [dbo].[ZslEventShortView]
AS
SELECT        t0.ExternalId, t0.MedicalExternalId, t1.AccountId, t1.MedicalAccountId, t0.ZslMedicalEventId, zme.ZmedicalEventId AS EventId, t0.PatientId, t2.Surname, t2.PName AS Name, t2.Patronymic, t2.Birthday, 
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
                                                         WHERE        (PersonId = t2.PersonId)) AS t15_1) AS DocType, t1.INP, t1.InsuranceDocNumber, t1.InsuranceDocSeries, t4.smocod AS Insurance, t5.IDUMP AS AssistanceConditions, 
                         t6.IDDS AS Diagnosis, t0.Price AS ZslPrice, zme.EventPrice AS Price, zme.Rate, zme.Quantity, t0.AcceptPrice, zme.EventBegin, zme.EventEnd, 
                         CAST(t7.Id AS NVARCHAR(5)) + '  ' + t7.PRNAME AS Profile, 
                         CAST(V021.Id AS NVARCHAR(5)) + '  ' + V021.SPECNAME  AS Speciality,                         
                         t9.IDRMP AS Result, t10.IDIZ AS Outcome, t11.STNAME AS PaymentStatus, zme.MEC, zme.MEE, zme.EQMA, zme.Comments AS EventComments, dbo.V008.IDVMP AS AssistanceType, dbo.V008.VMPNAME,
                         t1.InsuranceDocType, t3.Id AS SexCode, dbo.F010.KOD_OKATO AS TerritoryOkato, t11.IDIDST AS PaymentStatusCode, t0.MoPrice, t0.MoPaymentStatus, dbo.globalMedicalEventType.Name AS EventTypeName, 
                         dbo.globalRegionalAttribute.Name AS RegionalAttributeName, zme.EventType, t0.RegionalAttribute, t5.UMPNAME AS AssistanceConditionsName, 
                         ksg.Kksg + isnull('   ' + (select top 1 N_KSG from dbo.V023 where (v023.K_KSG = ksg.Kksg) and (v023.IDUMP = t0.AssistanceConditions) 
                         and (zme.EventEnd between V023.DATEBEG and isnull(V023.DATEEND, '20790531')) order by isnull(V023.DATEEND, '20790531') desc), '') as Kksg,                         
                         actype.TypeName TypeName, 
                         dbo.TerritoryAccountView.Direction, dbo.TerritoryAccountView.AccountNumber, dbo.TerritoryAccountView.AccountDate, dbo.TerritoryAccountView.SourceName, dbo.TerritoryAccountView.DestinationName, 
                         v9.VersionID Version,
                         v9.Version VersionName, 
                         v22.IDPC + '  ' + v22.N_PC AS Pcel, 
                         CASE WHEN zme.Dn = '1' THEN '1  Состоит'
							  WHEN zme.Dn = '2' THEN '2  Взят'
							  WHEN zme.Dn = '3' THEN '3  Не подлежит диспансерному наблюдению'
							  WHEN zme.Dn = '4' THEN '4  Снят по причине выздоровления'
							  WHEN zme.Dn = '6' THEN '6  Снят по другим причинам'
							  ELSE NULL END dn,
							  v018.IDHVID + '  ' + v018.HVIDNAME HighTechAssistanceType, --v018
							  (SELECT TOP 1 CAST(IDHM AS NVARCHAR(10)) + '   ' + v019.HMNAME FROM v019 WHERE IDHM = zme.HighTechAssistanceMethod)HighTechAssistanceMethod, --v019
							  '' ServiceCode,
						 '' ServiceName
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
                         dbo.globalMedicalEventType ON zme.EventType = dbo.globalMedicalEventType.ID LEFT OUTER JOIN
                         dbo.globalRegionalAttribute ON t0.RegionalAttribute = dbo.globalRegionalAttribute.ID LEFT OUTER JOIN
                         dbo.V015 ON zme.SpecialityCodeV015 = dbo.V015.Id LEFT OUTER JOIN
                         dbo.V021 ON zme.SpecialityCodeV021 = dbo.V021.Id LEFT OUTER JOIN
                         dbo.V025 AS v22 ON zme.Pcel = v22.IDPC LEFT JOIN                    
                         dbo.TerritoryAccountView ON t1.AccountId = dbo.TerritoryAccountView.TerritoryAccountId
                         LEFT JOIN dbo.globalVersion AS v9 ON TerritoryAccountView.Version = v9.VersionID
                         LEFT JOIN globalAccountType AS actype ON TerritoryAccountView.[Type] = actype.AccountTypeId
                         LEFT JOIN v018 ON HighTechAssistanceType = v018.IDHVID
						
