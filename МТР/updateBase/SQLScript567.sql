BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[version�heck] 566



INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'-- �� ��������� ���� ����������� 
  SELECT 
  DISTINCT  e.ZmedicalEventId
        
  FROM FactTerritoryAccount a --�����            
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
  --GROUP BY ze.MedicalOrganizationCode, ze.AssistanceConditions', N'�� ��������� ���� ����������� ��� ����������� ��, ����������� �� �������', N'�� ��������� ���� ����������� ��� ����������� ��, ����������� �� �������', N'�� ��������� ���� ����������� ��� ����������� ��, ����������� �� �������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'-- �� ��������� �� ����������� �� ������� ��� ���������� ���� �����������
  SELECT 
  DISTINCT  e.ZmedicalEventId
        
  FROM FactTerritoryAccount a --�����            
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
  --GROUP BY ze.MedicalOrganizationCode, ze.AssistanceConditions', N'�� ��������� �� ����������� �� ������� ��� ���������� ���� �����������', N'�� ��������� �� ����������� �� ������� ��� ���������� ���� �����������', N'�� ��������� �� ����������� �� ������� ��� ���������� ���� �����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --�� �������� ���� ������ ��� �������������� �������� ����
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
         --AND e.ZmedicalEventId = 244344
    INNER JOIN M001 AS m ON  m.Id = e.DiagnosisGeneral --��������
                        AND ( m.IDDS LIKE ''C%'' 
      OR m.IDDS between ''D00'' AND ''D09.z''
      OR (m.IDDS LIKE ''d70%'' AND CHARINDEX(''C'',e.DiagnosisSecondaryAggregate)<>0 ) -- 
       ) 
      AND e.SignSuspectedDsOnk = 0 -- ������� ����������
   
      AND isnull(e.reab,0)<>1
   
 LEFT JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId                                                                                              
 --LEFT JOIN ZFactSank sa ON sa.ZmedicalEventId=e.ZmedicalEventId

WHERE o.ZMedicalEventOnkId IS NULL', N'�� �������� ���� ������ ��� �������������� �������� ����', N'�� �������� ���� ������ ��� �������������� �������� ����', N'�� �������� ���� ������ ��� �������������� �������� ����', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --�� �������� ����� ��������� � ���� ������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         --AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId         
 WHERE o.Ds1t IS  NULL       ', N'�� �������� ����� ��������� � ���� ������', N'�� �������� ����� ��������� � ���� ������', N'�� �������� ����� ��������� � ���� ������', 1, 0.0000, 4, 1.0000, 7, 1)

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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
        -- AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
       
 WHERE o.StageDisease IS NULL AND o.Ds1t IN (0,1,2,3,4)', N'�� ��������� ������ ����������� � ���� ������', N'�� ��������� ������ ����������� � ���� ������', N'�� ��������� ������ ����������� � ���� ������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N' 
--DECLARE @AccountId  INT=25571
 --����� ��������� � ���� ������ �������� �����������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
        -- AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 LEFT JOIN N018 AS n ON n.ID_REAS = o.Ds1t       
 WHERE o.Ds1t IS not  NULL AND n.ID_REAS IS NULL         ', N'����� ��������� � ���� ������ �������� �����������', N'����� ��������� � ���� ������ �������� �����������', N'����� ��������� � ���� ������ �������� �����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� �������� ��� ����� ������������� �������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
       AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  != 4
         
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId
         
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
   JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
   JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
WHERE  zd.CodeSh IS NULL OR  zd.CodeSh NOT IN ( SELECT IDDKK FROM V024 )', N'�� �������� ��� ����� ������������� �������', N'�� �������� ��� ����� ������������� �������', N'�� �������� ��� ����� ������������� �������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� �������� ��� ������ � ���� ������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  != 4
         
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId
         
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
   JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 --left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zso.ServicesOnkTypeId IS  NULL', N'�� �������� ��� ������ � ���� ������', N'�� �������� ��� ������ � ���� ������', N'�� �������� ��� ������ � ���� ������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� ��������� ��������� �������� ���� ��� ������� ��� ������������ �������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 --left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zso.ServicesOnkTypeId IN (3,4)  AND o.Sod IS  NULL', N'�� ��������� ��������� �������� ���� ��� ������� ��� ������������ �������', N'�� ��������� ��������� �������� ���� ��� ������� ��� ������������ �������', N'�� ��������� ��������� �������� ���� ��� ������� ��� ������������ �������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--��� �������� � ��������� ����������������� ������������� ��������� 
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zso.ServicesOnkTypeId IN (2,4)  AND zd.ZAnticancerDrugId IS  NULL', N'��� �������� � ��������� ����������������� ������������� ���������', N'��� �������� � ��������� ����������������� ������������� ���������', N'��� �������� � ��������� ����������������� ������������� ���������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--��� ���������������� ��� ������ ������ �����������
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
      
 FROM FactTerritoryAccount a --�����            
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
 
 WHERE zc.Prot IS NOT NULL AND n001.ID_PrOt IS NULL ', N'��� ���������������� ��� ������ ������ �����������', N'��� ���������������� ��� ������ ������ �����������', N'��� ���������������� ��� ������ ������ �����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� �������� ��� ���������������� ��� ������
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
      
 FROM FactTerritoryAccount a --�����            
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
 
 WHERE zc.Prot IS NULL', N'�� �������� ��� ���������������� ��� ������', N'�� �������� ��� ���������������� ��� ������', N'�� �������� ��� ���������������� ��� ������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 2, 75, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� ��������� ���� ����������� ���������������� ��� ������
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
      
 FROM FactTerritoryAccount a --�����            
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
 
 WHERE zc.Dprot IS NULL', N'�� ��������� ���� ����������� ���������������� ��� ������', N'�� ��������� ���� ����������� ���������������� ��� ������', N'�� ��������� ���� ����������� ���������������� ��� ������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� ��������� ���� ���� �������� �������������� ���������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zd.DataInj IS NULL', N'�� ��������� ���� ���� �������� �������������� ���������', N'�� ��������� ���� ���� �������� �������������� ���������', N'�� ��������� ���� ���� �������� �������������� ���������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� �������� ��� ����������� �������� ��� �������������� �������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 --JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zso.ServicesOnkTypeId = 1 AND  (zso.HirTypeId IS  NULL OR zso.HirTypeId not IN (SELECT ID_THir FROM n014 )) ', N'�� �������� ��� ����������� �������� ��� �������������� �������', N'�� �������� ��� ����������� �������� ��� �������������� �������', N'�� �������� ��� ����������� �������� ��� �������������� �������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--����������� ��������� ��� ����������� ���� ��� ������� �������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
  
 WHERE zso.ServicesOnkTypeId IN (3,4) AND (zso.LuchTypeId IS NULL OR zso.LuchTypeId NOT IN (SELECT id_tluch FROM n017) )', N'����������� ��������� ��� ����������� ���� ��� ������� �������', N'����������� ��������� ��� ����������� ���� ��� ������� �������', N'����������� ��������� ��� ����������� ���� ��� ������� �������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--���� ��� ������� ������� �� �������� ����������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
  
 WHERE zso.ServicesOnkTypeId not IN (3,4) AND zso.LuchTypeId IS NOT NULL', N'���� ��� ������� ������� �� �������� ����������', N'���� ��� ������� ������� �� �������� ����������', N'���� ��� ������� ������� �� �������� ����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--��� �������������� ������� �� �������� ����������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 --JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zso.ServicesOnkTypeId != 1 AND  zso.HirTypeId IS  NOT NULL', N'��� �������������� ������� �� �������� ����������', N'��� �������������� ������� �� �������� ����������', N'��� �������������� ������� �� �������� ����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--��� ���������� ����������� ������ �����������
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
      
 FROM FactTerritoryAccount a --�����            
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
       ', N'��� ���������� ����������� ������ �����������', N'��� ���������� ����������� ������ �����������', N'��� ���������� ����������� ������ �����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--declare @AccountId INT=25571
--�� �������� ��� ���������������� ����������
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
      
 FROM FactTerritoryAccount a --�����            
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
       
 WHERE (zdb.DiagCode7 IS NULL AND zdb.DiagTip = 1) OR (zdb.DiagCode10 IS NULL AND zdb.DiagTip = 2)', N'�� �������� ��� ���������������� ����������', N'�� �������� ��� ���������������� ����������', N'�� �������� ��� ���������������� ����������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT=25571
--�� �������� ��� ���������� ����������� ��� ������� ��������� ���������� �����������
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
      
 FROM FactTerritoryAccount a --�����            
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
    (zdb.RecRslt IS NULL AND ( ( zdb.DiagTip = 1 AND zdb.DiagRslt8 IS NOT NULL ) OR ( zdb.DiagTip = 2 AND zdb.DiagRslt11 IS NOT NULL ) ) )  ', N'�� �������� ��� ���������� ����������� ��� ������� ��������� ���������� �����������', N'�� �������� ��� ���������� ����������� ��� ������� ��������� ���������� �����������', N'�� �������� ��� ���������� ����������� ��� ������� ��������� ���������� �����������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571
  --�� �������� ��� ���������������� ����������
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
      
 FROM FactTerritoryAccount a --�����            
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
       
 WHERE zdb.DiagTip IS NULL', N'�� �������� ��� ���������������� ����������', N'�� �������� ��� ���������������� ����������', N'�� �������� ��� ���������������� ����������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571
   --�� ��������� ���� ������ ���������
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
      
 FROM FactTerritoryAccount a --�����            
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
', N'�� ��������� ���� ������ ���������', N'�� ��������� ���� ������ ���������', N'�� ��������� ���� ������ ���������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571 
 --�� ��������� �������� Metastasis � ���� ������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
       
 WHERE o.OnkM IS  NULL AND o.Ds1t = 0 AND dbo.f_GetAge(fp.Birthday,e.EventBegin) > 18', N'�� ��������� �������� Metastasis � ���� ������', N'�� ��������� �������� Metastasis � ���� ������', N'�� ��������� �������� Metastasis � ���� ������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571

  --��� ���������������� ���������� ������ �����������
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
      
 FROM FactTerritoryAccount a --�����            
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
       ', N'��� ���������������� ���������� ������ �����������', N'��� ���������������� ���������� ������ �����������', N'��� ���������������� ���������� ������ �����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571
 
 --�������� Tumor � ���� ������ ������ ��������� ����������� 
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
      
 FROM FactTerritoryAccount a --�����            
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
       
 WHERE o.OnkT IS NOT NULL AND n003.ID_T IS NULL ', N'�������� Tumor � ���� ������ ������ ��������� ����������� ', N'�������� Tumor � ���� ������ ������ ��������� ����������� ', N'�������� Tumor � ���� ������ ������ ��������� ����������� ', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N' --DECLARE @AccountId INT =25571
 --�� ��������� �������� Nodus � ���� ������ 
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  

       
 WHERE o.OnkN IS NULL AND o.Ds1t = 0 AND dbo.f_GetAge(fp.Birthday,e.EventBegin) > 18', N'�� ��������� �������� Nodus � ���� ������ ', N'�� ��������� �������� Nodus � ���� ������ ', N'�� ��������� �������� Nodus � ���� ������ ', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571 
 --�� ��������� �������� Tumor � ���� ������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       --  AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
  
       
 WHERE o.OnkT IS NULL AND o.Ds1t = 0 AND  dbo.f_GetAge(fp.Birthday,e.EventBegin)>18', N'�� ��������� �������� Tumor � ���� ������', N'�� ��������� �������� Tumor � ���� ������', N'�� ��������� �������� Tumor � ���� ������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
 --������ ����������� � ���� ������ ��������� ����������� (�� �� N002)
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         --AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 LEFT JOIN N002 ON N002.ID_St = o.StageDisease 
       
 WHERE o.StageDisease IS not NULL AND N002.ID_St IS NULL', N'������ ����������� � ���� ������ ��������� ����������� (�� �� N002)', N'������ ����������� � ���� ������ ��������� ����������� (�� �� N002)', N'������ ����������� � ���� ������ ��������� ����������� (�� �� N002)', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --�������� ���� ������ ��� ���������� ��������� ��������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
                  
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
         --AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
         --AND e.ZmedicalEventId = 244344
    INNER JOIN M001 AS m ON  m.Id = e.DiagnosisGeneral --��������
                      
                       AND (m.IDDS not LIKE ''C%'' AND m.IDDS not between ''D00'' AND ''D09.z''
      OR (m.IDDS LIKE ''d70%'' AND CHARINDEX(''C'',e.DiagnosisSecondaryAggregate)=0 ) 
           ) 

 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId   
 ', N'�������� ���� ������ ��� ���������� ��������� ��������', N'�������� ���� ������ ��� ���������� ��������� ��������', N'�������� ���� ������ ��� ���������� ��������� ��������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571

 --�������� ���� ������ ��� ���������� �� ����
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
      
 FROM FactTerritoryAccount a --�����            
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

WHERE o.ZMedicalEventOnkId IS NOT NULL AND e.SignSuspectedDsOnk = 1', N'�������� ���� ������ ��� ���������� �� ����', N'�������� ���� ������ ��� ���������� �� ����', N'�������� ���� ������ ��� ���������� �� ����', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--�� ��������� �������������� ������ � ���������� ��� � ������� ���������� ��� ���������� ������������������ �������
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
      
 FROM FactTerritoryAccount a --�����            
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
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 left JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 --left JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zso.ZmedicalServicesOnkId IS NULL', N'�� ��������� �������������� ������ � ���������� ��� � ������� ���������� ��� ���������� ������������������ �������', N'�� ��������� �������������� ������ � ���������� ��� � ������� ���������� ��� ���������� ������������������ �������', N'�� ��������� ���������� � ���� ��� � ���� ���������� ��� ���������� ������������������ �������', 1, 0.0000, 4, 1.0000, 7, 1)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--����������� �������� ��� ���� ������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 --JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zso.ServicesOnkTypeId IS NOT NULL AND zso.ServicesOnkTypeId not IN (SELECT id_tlech FROM n013 ) ', N'����������� �������� ��� ���� ������', N'����������� �������� ��� ���� ������', N'����������� �������� ��� ���� ������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--����������� ��������� ��� �� ��������� ���� ��������������� ����� �������������� ���������
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
      
 FROM FactTerritoryAccount a --�����            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
 --JOIN ZFactDiagBlok AS zdb ON zdb.ZMedicalEventOnkId = o.ZMedicalEventOnkId --��������������� ����
 --JOIN ZFactContraindications AS zc ON zc.ZMedicalEventOnkId = o.ZMedicalEventOnkId --���������������� � ������
 JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --���� ������
 JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- ��� ��������
  
 WHERE  zd.RegNum IS  NULL OR zd.RegNum not IN ( SELECT id_lekp FROM N020 )', N'����������� ��������� ��� �� ��������� ���� ��������������� ����� �������������� ���������', N'����������� ��������� ��� �� ��������� ���� ��������������� ����� �������������� ���������', N'����������� ��������� ��� �� ��������� ���� ��������������� ����� �������������� ���������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
 --�������� Metastasis � ���� ������ ������ ��������� ����������� (�� �� N005)
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
      
 FROM FactTerritoryAccount a --�����            
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
       
 WHERE o.OnkM IS NOT NULL AND n005.ID_M IS NULL', N'�������� Metastasis � ���� ������ ������ ��������� ����������� (�� �� N005)', N'�������� Metastasis � ���� ������ ������ ��������� ����������� (�� �� N005)', N'�������� Metastasis � ���� ������ ������ ��������� ����������� (�� �� N005)', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId INT =25571

 --�������� Nodus � ���� ������ ������ ��������� ����������� 
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
      
 FROM FactTerritoryAccount a --�����            
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
       
 WHERE o.OnkN IS NOT NULL AND n004.ID_N IS NULL', N'�������� Nodus � ���� ������ ������ ��������� �����������', N'�������� Nodus � ���� ������ ������ ��������� �����������', N'�������� Nodus � ���� ������ ������ ��������� �����������', 1, 0.0000, 4, 1.0000, 7, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-01-01 00:00:00.000' AS DateTime), NULL, 2, N'--DECLARE @AccountId  INT=25571
--��� ���������������� ���������� ������ �����������
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
      
 FROM FactTerritoryAccount a --�����            
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
 ( zdb.DiagTip = 2 AND zdb.DiagCode10 IS NOT NULL AND n010.ID_Igh IS  NULL AND ISNULL(n010.DATEEND, ''21000101'') >= ze.EventBeginZ1 ) ) ', N'��� ���������������� ���������� ������ �����������', N'��� ���������������� ���������� ������ �����������', N'��� ���������������� ���������� ������ �����������', 1, 0.0000, 4, 1.0000, 7, 2)




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