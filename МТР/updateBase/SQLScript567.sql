BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[versionСheck] 566



INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'-- не заполнена дата направления 
  SELECT 
  DISTINCT  e.ZmedicalEventId
        
  FROM FactTerritoryAccount a --счета            
  INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
              AND p.AccountId=@AccountId        
       --and a.Source=38000
       --AND a.Destination=''83000''
       -- AND a.Date >= ''20190101''
  INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
  INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
              --    AND ze.[AssistanceConditions]  != 4
                  
  INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
    
  WHERE ze.ReferralDate IS NULL AND ze.ReferralOrganization IS NOT NULL
 -- AND ( (ze.AssistanceConditions = 1 AND ze.AssistanceForm = 3) OR ze.AssistanceConditions = 2 )
  --GROUP BY ze.MedicalOrganizationCode, ze.AssistanceConditions', N'не заполнена дата направления при заполненной мо, направившей на лечение', N'не заполнена дата направления при заполненной мо, направившей на лечение', N'не заполнена дата направления при заполненной мо, направившей на лечение', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'-- не заполнена МО направившая на лечение при заполненой дате направления
  SELECT 
  DISTINCT  e.ZmedicalEventId
        
  FROM FactTerritoryAccount a --счета            
  INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
              AND p.AccountId=@AccountId        
       --and a.Source=38000
       --AND a.Destination=''83000''
       -- AND a.Date >= ''20190101''
  INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
  INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
              --    AND ze.[AssistanceConditions]  != 4
                  
  INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
    
  WHERE ze.ReferralDate IS NOT NULL AND ze.ReferralOrganization IS NULL
 -- AND ( (ze.AssistanceConditions = 1 AND ze.AssistanceForm = 3) OR ze.AssistanceConditions = 2 )
  --GROUP BY ze.MedicalOrganizationCode, ze.AssistanceConditions', N'Не заполнена МО направившая на лечение при заполненой дате направления', N'Не заполнена МО направившая на лечение при заполненой дате направления', N'Не заполнена МО направившая на лечение при заполненой дате направления', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --Не заполнен онко случай при подтвержденном диагнозе онко
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
         --AND e.ZmedicalEventId = 244344
    INNER JOIN M001 AS m ON  m.Id = e.DiagnosisGeneral --основной
                        AND ( m.IDDS LIKE ''C%'' 
      OR m.IDDS between ''D00'' AND ''D09.z''
      OR (m.IDDS LIKE ''d70%'' AND CHARINDEX(''C'',e.DiagnosisSecondaryAggregate)<>0 ) -- 
       ) 
      AND e.SignSuspectedDsOnk = 0 -- признак подозрения
   
      AND isnull(e.reab,0)<>1
   
 LEFT JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId                                                                                              
 --LEFT JOIN ZFactSank sa ON sa.ZmedicalEventId=e.ZmedicalEventId

WHERE o.ZMedicalEventOnkId IS NULL', N'Не заполнен онко случай при подтвержденном диагнозе онко', N'Не заполнен онко случай при подтвержденном диагнозе онко', N'Не заполнен онко случай при подтвержденном диагнозе онко', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --Не заполнен повод обращения в онко случае
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         --AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId         
 WHERE o.Ds1t IS  NULL       ', N'Не заполнен повод обращения в онко случае', N'Не заполнен повод обращения в онко случае', N'Не заполнен повод обращения в онко случае', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N' SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
        -- AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
       
 WHERE o.StageDisease IS NULL AND o.Ds1t IN (0,1,2,3,4)', N'Не заполнена стадия заболевания в онко случае', N'Не заполнена стадия заболевания в онко случае', N'Не заполнена стадия заболевания в онко случае', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N' 
--DECLARE @AccountId  INT=25571
 --Повод обращения в онко случае заполнен некорректно
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
        -- AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 LEFT JOIN N018 AS n ON n.ID_REAS = o.Ds1t       
 WHERE o.Ds1t IS not  NULL AND n.ID_REAS IS NULL         ', N'Повод обращения в онко случае заполнен некорректно', N'Повод обращения в онко случае заполнен некорректно', N'Повод обращения в онко случае заполнен некорректно', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Не заполнен код схемы лекарственной терапии
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,ze.[AssistanceConditions] 
 --,zdb.DiagTip  
 --,a.[Date]
 ,p.AccountId, p.ExternalId,zd.CodeSh
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
       AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  != 4
         
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId
         
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
   JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
   JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
WHERE  zd.CodeSh IS NULL OR  zd.CodeSh NOT IN ( SELECT IDDKK FROM V024 )', N'Не заполнен код схемы лекарственной терапии', N'Не заполнен код схемы лекарственной терапии', N'Не заполнен код схемы лекарственной терапии', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--не заполнен тип услуги в онко услуге
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,ze.[AssistanceConditions] 
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  != 4
         
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId
         
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
   JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 --left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zso.ServicesOnkTypeId IS  NULL', N'не заполнен тип услуги в онко услуге', N'не заполнен тип услуги в онко услуге', N'не заполнен тип услуги в онко услуге', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--не заполнена суммарная очаговая доза при лучевой или химиолучевой терапии
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 --left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zso.ServicesOnkTypeId IN (3,4)  AND o.Sod IS  NULL', N'не заполнена суммарная очаговая доза при лучевой или химиолучевой терапии', N'не заполнена суммарная очаговая доза при лучевой или химиолучевой терапии', N'не заполнена суммарная очаговая доза при лучевой или химиолучевой терапии', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Нет сведений о введенном противоопухолевом лекарственном препарате 
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zso.ServicesOnkTypeId IN (2,4)  AND zd.ZAnticancerDrugId IS  NULL', N'Нет сведений о введенном противоопухолевом лекарственном препарате', N'Нет сведений о введенном противоопухолевом лекарственном препарате', N'Нет сведений о введенном противоопухолевом лекарственном препарате', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Код противопоказания или отказа указан некорректно
 SELECT 
 DISTINCT e.ZmedicalEventId

 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
 JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId
 LEFT JOIN N001 AS n001 ON n001.ID_PrOt = zc.Prot
 
 WHERE zc.Prot IS NOT NULL AND n001.ID_PrOt IS NULL ', N'Код противопоказания или отказа указан некорректно', N'Код противопоказания или отказа указан некорректно', N'Код противопоказания или отказа указан некорректно', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Не заполнен код противопоказания или отказа
 SELECT 
 DISTINCT e.ZmedicalEventId

 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
 JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId
 
 WHERE zc.Prot IS NULL', N'Не заполнен код противопоказания или отказа', N'Не заполнен код противопоказания или отказа', N'Не заполнен код противопоказания или отказа', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 2, 75, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Не заполнена дата регистрации противопоказания или отказа
 SELECT 
 DISTINCT e.ZmedicalEventId

 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
 JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId
 
 WHERE zc.Dprot IS NULL', N'Не заполнена дата регистрации противопоказания или отказа', N'Не заполнена дата регистрации противопоказания или отказа', N'Не заполнена дата регистрации противопоказания или отказа', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Не заполнено поле Дата введения лекарственного препарата
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zd.DataInj IS NULL', N'Не заполнено поле Дата введения лекарственного препарата', N'Не заполнено поле Дата введения лекарственного препарата', N'Не заполнено поле Дата введения лекарственного препарата', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--не заполнен или некорректно заполнен тип хирургического лечения
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 --JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zso.ServicesOnkTypeId = 1 AND  (zso.HirTypeId IS  NULL OR zso.HirTypeId not IN (SELECT ID_THir FROM n014 )) ', N'не заполнен или некорректно заполнен тип хирургического лечения', N'не заполнен или некорректно заполнен тип хирургического лечения', N'не заполнен или некорректно заполнен тип хирургического лечения', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--некорректно заполнено или незаполнено поле Тип лучевой терапии
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zso.LekTypeVId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
  
 WHERE zso.ServicesOnkTypeId IN (3,4) AND (zso.LuchTypeId IS NULL OR zso.LuchTypeId NOT IN (SELECT id_tluch FROM n017) )', N'некорректно заполнено или незаполнено поле Тип лучевой терапии', N'некорректно заполнено или незаполнено поле Тип лучевой терапии', N'некорректно заполнено или незаполнено поле Тип лучевой терапии', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Поле Тип лучевой терапии не подлежит заполнению
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
  
 WHERE zso.ServicesOnkTypeId not IN (3,4) AND zso.LuchTypeId IS NOT NULL', N'Поле Тип лучевой терапии не подлежит заполнению', N'Поле Тип лучевой терапии не подлежит заполнению', N'Поле Тип лучевой терапии не подлежит заполнению', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Тип хирургического лечения не подлежит заполнению
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 --JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zso.ServicesOnkTypeId != 1 AND  zso.HirTypeId IS  NOT NULL', N'Тип хирургического лечения не подлежит заполнению', N'Тип хирургического лечения не подлежит заполнению', N'Тип хирургического лечения не подлежит заполнению', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Код результата диагностики указан некорректно
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
               
 left JOIN N008 AS n008 ON n008.ID_R_M = zdb.DiagRslt8
 LEFT JOIN N011 AS n011 ON n011.ID_R_I = zdb.DiagRslt11 
 
 WHERE zdb.DiagTip IS NOT NULL AND ( 
  ( zdb.DiagTip = 1 AND zdb.DiagRslt8 IS NOT NULL AND n008.ID_R_M IS  NULL AND ISNULL( n008.DATEEND,''21000101'' ) >= ze.EventBeginZ1 ) OR
  ( zdb.DiagTip = 2 AND zdb.DiagRslt11 IS NOT NULL AND n011.ID_R_I IS NULL AND ISNULL( n011.DATEEND,''21000101'' ) >= ze.EventBeginZ1 ) )
       ', N'Код результата диагностики указан некорректно', N'Код результата диагностики указан некорректно', N'Код результата диагностики указан некорректно', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--declare @AccountId INT=25571
--Не заполнен код диагностического показателя
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
       
 WHERE (zdb.DiagCode7 IS NULL AND zdb.DiagTip = 1) OR (zdb.DiagCode10 IS NULL AND zdb.DiagTip = 2)', N'Не заполнен код диагностического показателя', N'Не заполнен код диагностического показателя', N'Не заполнен код диагностического показателя', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT=25571
--Не заполнен код результата диагностики или признак получения результата диагностики
 SELECT 
 DISTINCT e.ZmedicalEventId

 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
 
 WHERE (zdb.RecRslt = 1 AND ( ( zdb.DiagTip = 1 AND zdb.DiagRslt8 IS NULL ) OR ( zdb.DiagTip = 2 AND zdb.DiagRslt11 IS NULL ) ) ) 
  OR
    (zdb.RecRslt IS NULL AND ( ( zdb.DiagTip = 1 AND zdb.DiagRslt8 IS NOT NULL ) OR ( zdb.DiagTip = 2 AND zdb.DiagRslt11 IS NOT NULL ) ) )  ', N'Не заполнен код результата диагностики или признак получения результата диагностики', N'Не заполнен код результата диагностики или признак получения результата диагностики', N'Не заполнен код результата диагностики или признак получения результата диагностики', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571
  --Не заполнен тип диагностического показателя
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
       
 WHERE zdb.DiagTip IS NULL', N'Не заполнен тип диагностического показателя', N'Не заполнен тип диагностического показателя', N'Не заполнен тип диагностического показателя', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571
   --Не заполнена дата взятия материала
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
       
 WHERE zdb.DiagDate IS NULL
', N'Не заполнена дата взятия материала', N'Не заполнена дата взятия материала', N'Не заполнена дата взятия материала', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571 
 --Не заполнено значение Metastasis в онко случае
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
       
 WHERE o.OnkM IS  NULL AND o.Ds1t = 0 AND dbo.f_GetAge(fp.Birthday,e.EventBegin) > 18', N'Не заполнено значение Metastasis в онко случае', N'Не заполнено значение Metastasis в онко случае', N'Не заполнено значение Metastasis в онко случае', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571

  --Тип диагностического показателя указан некорректно
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
       
 WHERE zdb.DiagTip IS NOT NULL AND zdb.DiagTip NOT IN (1,2)
       ', N'Тип диагностического показателя указан некорректно', N'Тип диагностического показателя указан некорректно', N'Тип диагностического показателя указан некорректно', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571
 
 --Значение Tumor в онко случае случае заполнена некорректно 
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 LEFT JOIN N003 AS n003 ON n003.ID_T = o.OnkT 
       
 WHERE o.OnkT IS NOT NULL AND n003.ID_T IS NULL ', N'Значение Tumor в онко случае случае заполнена некорректно ', N'Значение Tumor в онко случае случае заполнена некорректно ', N'Значение Tumor в онко случае случае заполнена некорректно ', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N' --DECLARE @AccountId INT =25571
 --Не заполнено значение Nodus в онко случае 
 SELECT 
 DISTINCT e.ZmedicalEventId
 --o.Ds1t, o.OnkT, o.OnkN, o.OnkM
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  

       
 WHERE o.OnkN IS NULL AND o.Ds1t = 0 AND dbo.f_GetAge(fp.Birthday,e.EventBegin) > 18', N'Не заполнено значение Nodus в онко случае ', N'Не заполнено значение Nodus в онко случае ', N'Не заполнено значение Nodus в онко случае ', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571 
 --Не заполнено значение Tumor в онко случае
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
  
       
 WHERE o.OnkT IS NULL AND o.Ds1t = 0 AND  dbo.f_GetAge(fp.Birthday,e.EventBegin)>18', N'Не заполнено значение Tumor в онко случае', N'Не заполнено значение Tumor в онко случае', N'Не заполнено значение Tumor в онко случае', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
 --Стадия заболевания в онко случае заполнена некорректно (не из N002)
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         --AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 LEFT JOIN N002 ON N002.ID_St = o.StageDisease 
       
 WHERE o.StageDisease IS not NULL AND N002.ID_St IS NULL', N'Стадия заболевания в онко случае заполнена некорректно (не из N002)', N'Стадия заболевания в онко случае заполнена некорректно (не из N002)', N'Стадия заболевания в онко случае заполнена некорректно (не из N002)', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --Заполнен онко случай при отсутствии основного диагноза
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         --AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
         --AND e.ZmedicalEventId = 244344
    INNER JOIN M001 AS m ON  m.Id = e.DiagnosisGeneral --основной
                      
                       AND (m.IDDS not LIKE ''C%'' AND m.IDDS not between ''D00'' AND ''D09.z''
      OR (m.IDDS LIKE ''d70%'' AND CHARINDEX(''C'',e.DiagnosisSecondaryAggregate)=0 ) 
           ) 

 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId   
 ', N'Заполнен онко случай при отсутствии основного диагноза', N'Заполнен онко случай при отсутствии основного диагноза', N'Заполнен онко случай при отсутствии основного диагноза', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --Заполнен онко случай при подозрении на онко
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 ----,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         --AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
         --AND e.ZmedicalEventId = 244344
         
    
   
 LEFT JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId                                                                                              
 --LEFT JOIN ZFactSank sa ON sa.ZmedicalEventId=e.ZmedicalEventId

WHERE o.ZMedicalEventOnkId IS NOT NULL AND e.SignSuspectedDsOnk = 1', N'Заполнен онко случай при подозрении на онко', N'Заполнен онко случай при подозрении на онко', N'Заполнен онко случай при подозрении на онко', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--не заполнена онкологическая услуга в стационаре или в дневном стационаре при проведении противоопухолевого лечения
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         AND ze.[AssistanceConditions]  IN (1,2) 
         
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId
         AND o.Ds1t  IN (0,1,2)
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 left JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 --left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zso.ZmedicalServicesOnkId IS NULL', N'не заполнена онкологическая услуга в стационаре или в дневном стационаре при проведении противоопухолевого лечения', N'не заполнена онкологическая услуга в стационаре или в дневном стационаре при проведении противоопухолевого лечения', N'не заполнена онкоуслуга в стац или в днев стационаре при проведении противоопухолевого лечения', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Некорректно заполнен тип онко услуги
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 --JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zso.ServicesOnkTypeId IS NOT NULL AND zso.ServicesOnkTypeId not IN (SELECT id_tlech FROM n013 ) ', N'Некорректно заполнен тип онко услуги', N'Некорректно заполнен тип онко услуги', N'Некорректно заполнен тип онко услуги', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Некорректно заполнено или не заполнено поле Регистрационный номер лекарственного препарата
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,zdb.DiagRslt8
 --,zdb.DiagRslt11
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --диагностический блок
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --противопоказания и отказы
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
 JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  
 WHERE  zd.RegNum IS  NULL OR zd.RegNum not IN ( SELECT id_lekp FROM N020 )', N'Некорректно заполнено или не заполнено поле Регистрационный номер лекарственного препарата', N'Некорректно заполнено или не заполнено поле Регистрационный номер лекарственного препарата', N'Некорректно заполнено или не заполнено поле Регистрационный номер лекарственного препарата', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
 --Значение Metastasis в онко случае случае заполнено некорректно (не из N005)
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 LEFT JOIN N005 AS n005 ON n005.ID_M = o.OnkM
       
 WHERE o.OnkM IS NOT NULL AND n005.ID_M IS NULL', N'Значение Metastasis в онко случае случае заполнено некорректно (не из N005)', N'Значение Metastasis в онко случае случае заполнено некорректно (не из N005)', N'Значение Metastasis в онко случае случае заполнено некорректно (не из N005)', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571

 --Значение Nodus в онко случае случае заполнено некорректно 
 SELECT 
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 LEFT JOIN N004 AS n004 ON n004.ID_N = o.OnkN
       
 WHERE o.OnkN IS NOT NULL AND n004.ID_N IS NULL', N'Значение Nodus в онко случае случае заполнено некорректно', N'Значение Nodus в онко случае случае заполнено некорректно', N'Значение Nodus в онко случае случае заполнено некорректно', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--Код диагностического показателя указан некорректно
 SELECT 
 DISTINCT e.ZmedicalEventId
 --,zdb.DiagTip  
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,m.IDDS
 --,e.SignSuspectedDsOnk
 --,e.reab
 --,ze.AssistanceConditions
 --,ze.AssistanceType
   --  ,m001.IDDS,ze.AcceptPrice,ze.Price,ze.AcceptPrice,sa.Comments
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId
               
 left JOIN N007 AS n007 ON n007.ID_Mrf = zdb.DiagCode7
 LEFT JOIN N010 AS n010 ON n010.ID_Igh = zdb.DiagCode10  
 
 WHERE zdb.DiagTip IS NOT NULL AND (
 ( zdb.DiagTip = 1 AND zdb.DiagCode7 IS NOT NULL AND n007.ID_Mrf IS  NULL AND ISNULL(n007.DATEEND, ''21000101'') >= ze.EventBeginZ1 )
  OR
 ( zdb.DiagTip = 2 AND zdb.DiagCode10 IS NOT NULL AND n010.ID_Igh IS  NULL AND ISNULL(n010.DATEEND, ''21000101'') >= ze.EventBeginZ1 ) ) ', N'Код диагностического показателя указан некорректно', N'Код диагностического показателя указан некорректно', N'Код диагностического показателя указан некорректно', 1, 0.0000, 4, 1.0000, 7, 2)




EXEC [dbo].[versionUpdate] 567
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