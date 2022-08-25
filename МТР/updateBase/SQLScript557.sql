BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[version�heck] 556

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'53', 1, 52, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'-- Region Parameters
DECLARE @p0 NVarChar(1000);
SET @p0 = '''';
DECLARE @p6 Int;
SET @p6 = 3;
DECLARE @p7 Int;
SET @p7 = 0;

-- EndRegion
SELECT [t0].[PatientId]
FROM [FactPatient] AS [t0]
LEFT OUTER JOIN [FactPerson] AS [t1] ON [t1].[PersonId] = [t0].[PersonalId]
WHERE (
((([t0].[InsuranceDocNumber] IS NULL) OR ([t0].[InsuranceDocNumber] = @p0)) AND (([t0].[INP] IS NULL) OR ([t0].[INP] = @p0))) OR 
([t0].[InsuranceDocType] IS NULL) OR 
([t1].[Surname] IS NULL) OR 
([t1].[Surname] = @p0) OR 
([t1].[PName] IS NULL) OR 
([t1].[PName] = @p0) OR 
([t1].[Patronymic] IS NULL) OR 
([t1].[Patronymic] = @p0) OR 
([t1].[Sex] IS NULL) OR 
([t1].[Birthday] IS NULL) OR 
([t0].[Newborn] IS NULL) OR 
([t0].[Newborn] = @p0) OR 
(([t0].[InsuranceDocType] <> @p6) AND (((
	SELECT COUNT(*)
	FROM [FactDocument] AS [t2]
	WHERE [t2].[PersonId] = [t1].[PersonId]
	)) = @p7))) AND ([t0].[AccountId] = @AccountID)
', N'�������� ���� ������������ ����� ��������, � ��� ����� ��', N'�� ��������� ���� �� ������������ ����� �������', N'�������� ������������ ����� �������', 1, 0.0000, 3, 1.0000, 7, 1)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 74, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'-- ��������� �����������  ��� ������ �� ����� ���������� �������� � �������������� ���������� ����� ������� � ���������� ��� �������������� (�� ���� ������)
-- declare @AccountID int
--Set @AccountID=21198
DECLARE @p4 Float = -1
DECLARE @p5 Float = 1
select t2.ZmedicalEventId -- ������� ����������� ��� ������. ��������� �� �������???
  
  from
 (Select zsl1.ZslMedicalEventId,
  sl1.ZmedicalEventId,
  pe1.PName,
  pe1.Surname,
  pe1.Patronymic,
  pe1.Birthday,
  p1.[INP],
        p1.[InsuranceDocNumber],  
  sl1.eventbegin,
  sl1.eventend
  
 FROM [ZslFactMedicalEvent] AS zsl1
   inner join ZFactMedicalEvent as sl1 on sl1.ZslMedicalEventId=zsl1.ZslMedicalEventId
            and zsl1.AssistanceConditions=1
   inner JOIN [FactPatient] AS p1 ON p1.[PatientId] = zsl1.[PatientId] 
          and p1.[AccountId] = @AccountID
   inner join  [FactPerson] as pe1 on pe1.PersonId=p1.PersonalId      
) as t1--��� ������ ���������� �� ����� ��� ������� ��������
inner join --�������� �� ���� ������������
 (Select zsl2.ZslMedicalEventId,
  sl2.ZmedicalEventId,
  pe2.PName,
  pe2.Surname,
  pe2.Patronymic,
  pe2.Birthday,
  p2.[INP],
        p2.[InsuranceDocNumber],
  sl2.eventbegin,
  sl2.eventend
  FROM [ZslFactMedicalEvent] AS zsl2
   inner join ZFactMedicalEvent as sl2 on sl2.ZslMedicalEventId=zsl2.ZslMedicalEventId
             and zsl2.AssistanceConditions in (3,4)
   inner JOIN [FactPatient] AS p2 ON p2.[PatientId] = zsl2.[PatientId] 
          and p2.[AccountId] = @AccountID
   inner join  [FactPerson] as pe2 on pe2.PersonId=p2.PersonalId        
) as t2 on   t1.PName=t2.PName
  and t1.Surname=t2.Surname
  and t1.Patronymic=t2.Patronymic
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and ([t2].[EventBegin] <= (DATEADD(ms, (CONVERT(BigInt,@p4 * 86400000)) % 86400000, DATEADD(day, (CONVERT(BigInt,@p4 * 86400000)) / 86400000, [t1].[EventEnd])))) 
  AND ((DATEADD(ms, (CONVERT(BigInt,@p5 * 86400000)) % 86400000, DATEADD(day, (CONVERT(BigInt,@p5 * 86400000)) / 86400000, [t1].[EventBegin]))) <= [t2].[EventEnd])
             
   ', N'��������� �����������  ��� ������ �� ����� ���������� �������� � �������������� ���������� ����� ������� � ���������� ��� �������������� (�� ���� ������)', N'��� ���������� � ���', N'�������� ������������ ����������� ��������� �� �����', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 75, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'select t1.ZmedicalEventId -- ������� ������� ������(�� ������ �����)
--,
--t1.externalid,
--t2.accountid,
--t2.externalid

  
  from
 (Select zsl1.ZslMedicalEventId,
 p1.externalid,
 
  sl1.ZmedicalEventId,
  pe1.PName,
  pe1.Surname,
  pe1.Patronymic,
  pe1.Birthday,
  p1.[INP],
        p1.[InsuranceDocNumber],  
  sl1.eventbegin,
  sl1.eventend
  
 FROM [ZslFactMedicalEvent] AS zsl1
   inner join ZFactMedicalEvent as sl1 on sl1.ZslMedicalEventId=zsl1.ZslMedicalEventId
            and zsl1.AssistanceConditions=1
   inner JOIN [FactPatient] AS p1 ON p1.[PatientId] = zsl1.[PatientId] 
          and p1.[AccountId] = @AccountID
   inner join  [FactPerson] as pe1 on pe1.PersonId=p1.PersonalId      
) as t1--��� ������ ���������� �� �������� �����.
inner join --�������� �� ����� ����������� ���� �� ����� �������� ������ ������ 3,0
 (Select zsl2.ZslMedicalEventId,
  sl2.ZmedicalEventId,
  pe2.PName,
  pe2.Surname,
  pe2.Patronymic,
  pe2.Birthday,
  p2.[INP],
        p2.[InsuranceDocNumber],
  sl2.eventbegin,
  sl2.eventend,
  p2.externalid,
  p2.accountid
  FROM [ZslFactMedicalEvent] AS zsl2
   inner join ZFactMedicalEvent as sl2 on sl2.ZslMedicalEventId=zsl2.ZslMedicalEventId
             and zsl2.AssistanceConditions in (1)
   inner JOIN [FactPatient] AS p2 ON p2.[PatientId] = zsl2.[PatientId] 
          
   inner join  [FactPerson] as pe2 on pe2.PersonId=p2.PersonalId  
 where zsl2.AcceptPrice>0        
) as t2 on   t1.PName=t2.PName
  and t1.Surname=t2.Surname
  and t1.Patronymic=t2.Patronymic
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and 
  (
    (cast([t1].[EventBegin]as date) >=cast([t2].[EventBegin]as date) 
  and cast([t1].[EventBegin]as date) <cast([t2].[EventEnd]as date)
    )
  or 
    (cast([t2].[EventBegin]as date) >=cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <cast([t1].[EventEnd]as date)
    )
  )
  and t1.ZmedicalEventId<>t2.ZmedicalEventId--�� ���� � ��� �� ������', N'�������� ���������� ��������� � �����  ��� ����� �������� ������ ��������� ����� ������ 3,0', N'', N'�������� ��������� ���������/��������� (��)', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 70, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'SELECT 
--t1.accountid,t1.externalid,
[t5].ZmedicalEventId
--,t3.externalid--����� ��������� ��� �� �� ����� ����� ������
FROM [FactMedicalEvent] AS [t0]--������ �����
LEFT OUTER JOIN [FactPatient] AS [t1] ON [t1].[PatientId] = [t0].[PatientId]
INNER JOIN FactPerson AS fp ON fp.PersonId = [t1].PersonalId
CROSS JOIN ([ZslFactMedicalEvent] AS [t2]--������ ������� � ������ �������
   INNER JOIN ZFactMedicalEvent as [t5] on t5.ZslMedicalEventId=t2.ZslMedicalEventId
   LEFT OUTER JOIN [FactPatient] AS [t3] ON [t3].[PatientId] = [t2].[PatientId]
   INNER JOIN FactPerson AS fp2 ON t3.PersonalId = fp2.PersonId)
WHERE ([t1].[AccountId] <> @AccountID) --������� �� �� ������ �����
  AND ([t3].[AccountId] = @AccountID)--� �� ��� �� ������
  AND ([t5].[EventBegin] = [t0].[EventBegin])
  AND ([t5].[EventEnd] = [t0].[EventEnd]) 
  AND ([t5].[ProfileCodeId] = [t0].[ProfileCodeId])
  AND ([t3].[Newborn] = [t1].[Newborn]) 
  AND fp.PName=fp2.PName
  AND fp.Surname=fp2.Surname
  AND fp.Patronymic=fp2.Patronymic
  AND fp.Birthday=fp2.Birthday
  AND ([t1].[INP]=[t3].[INP] OR [t1].[InsuranceDocNumber]= [t3].[InsuranceDocNumber])
 AND t0.AcceptPrice > 0', N'����������� ������ � ����� ������ �������� ����������� ������ �� ���, ���� ��������, ������ ���, ���� �������� ����������� ������, ������������� � ������� ����������� ������ (�������� �� ������ ������)
', N'', N'�������� ������������ �� ����� (��) 3.0', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 71, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'-- Region Parameters
DECLARE @p1 Int = 1

SELECT ZmedicalEventId
FROM (
    SELECT max(zme.ZmedicalEventId) ZmedicalEventId, COUNT(*) value, zme.SpecialityCodeV021, zme.EventBegin, zme.[EventEnd], zme.ProfileCodeId, [t1].[INP], [t1].[InsuranceDocNumber], [t1].[Newborn], 
    fp.PName, fp.Surname, fp.Patronymic, fp.Birthday, t0.MedicalOrganizationCode 
    FROM [ZslFactMedicalEvent] AS [t0]
    INNER JOIN ZFactMedicalEvent AS zme ON zme.ZslMedicalEventId = [t0].ZslMedicalEventId
    LEFT OUTER JOIN [FactPatient] AS [t1] ON [t1].[PatientId] = [t0].[PatientId]
    JOIN FactPerson AS fp ON fp.PersonId = [t1].PersonalId
    WHERE [t1].[AccountId] = @AccountID
    GROUP BY zme.SpecialityCodeV021, zme.EventBegin, zme.[EventEnd], zme.ProfileCodeId, [t1].[INP], [t1].[InsuranceDocNumber], [t1].[Newborn], 
    fp.PName, fp.Surname, fp.Patronymic, fp.Birthday,t0.MedicalOrganizationCode ) AS t4  
WHERE [value] > @p1', N'����������� ������ � ����� ������ �������� ����������� ������ �� ���, ���� ��������, ������ ���, ���� �������� ����������� ������, ������������� � ������� ����������� ������ (�������� �� ������ �����)
', N'', N'�������� ������������ �� �������� ����� (��) 3.0', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 74, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'select t1.ZmedicalEventId -- ������� ������� ������(�� ������ �����)
--,
--t1.externalid,
--t2.accountid,
--t2.externalid

  
  from
 (Select zsl1.ZslMedicalEventId,
 p1.externalid,
 
  sl1.ZmedicalEventId,
  pe1.PName,
  pe1.Surname,
  pe1.Patronymic,
  pe1.Birthday,
  p1.[INP],
        p1.[InsuranceDocNumber],  
  sl1.eventbegin,
  sl1.eventend
  
 FROM [ZslFactMedicalEvent] AS zsl1
   inner join ZFactMedicalEvent as sl1 on sl1.ZslMedicalEventId=zsl1.ZslMedicalEventId
            and zsl1.AssistanceConditions=1
   inner JOIN [FactPatient] AS p1 ON p1.[PatientId] = zsl1.[PatientId] 
          and p1.[AccountId] = @AccountID
   inner join  [FactPerson] as pe1 on pe1.PersonId=p1.PersonalId      
) as t1--��� ������ ���������� �� �������� �����.
inner join --�������� �� ����� ����������� ���� �� ����� �������� ������ ������ 2,1
 (Select sl2.MedicalEventId,
  pe2.PName,
  pe2.Surname,
  pe2.Patronymic,
  pe2.Birthday,
  p2.[INP],
        p2.[InsuranceDocNumber],
  sl2.eventbegin,
  sl2.eventend,
  p2.externalid,
  p2.accountid
  FROM [FactMedicalEvent] AS sl2
    inner JOIN [FactPatient] AS p2 ON p2.[PatientId] = sl2.[PatientId] 
         and sl2.AssistanceConditions in (3,4) 
   inner join  [FactPerson] as pe2 on pe2.PersonId=p2.PersonalId  
 where sl2.AcceptPrice>0        
) as t2 on   t1.PName=t2.PName
  and t1.Surname=t2.Surname
  and t1.Patronymic=t2.Patronymic
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and 
  (
    cast([t2].[EventBegin]as date) >cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <cast([t2].[EventEnd]as date)
    
   )', N'�������� ���������� ��������� � �����  ��� ����� 2,1 �������� ������ �����������_������ ������ 3,0', N'', N'�������� ���������� ��������� � �����  ��� ����� 2,1 �������� ������ �����������_������ ������ 3,0', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 75, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'select t1.ZmedicalEventId -- ������� ������� ������(�� ������ �����)
--,
--t1.externalid,
--t2.accountid,
--t2.externalid

  
  from
 (Select zsl1.ZslMedicalEventId,
 p1.externalid,
 
  sl1.ZmedicalEventId,
  pe1.PName,
  pe1.Surname,
  pe1.Patronymic,
  pe1.Birthday,
  p1.[INP],
        p1.[InsuranceDocNumber],  
  sl1.eventbegin,
  sl1.eventend
  
 FROM [ZslFactMedicalEvent] AS zsl1
   inner join ZFactMedicalEvent as sl1 on sl1.ZslMedicalEventId=zsl1.ZslMedicalEventId
            and zsl1.AssistanceConditions=1
   inner JOIN [FactPatient] AS p1 ON p1.[PatientId] = zsl1.[PatientId] 
          and p1.[AccountId] = @AccountID
   inner join  [FactPerson] as pe1 on pe1.PersonId=p1.PersonalId      
) as t1--��� ������ ���������� �� �������� �����.
inner join --�������� �� ����� ����������� ���� �� ����� �������� ������ ������ 2,1
 (Select sl2.MedicalEventId,
  pe2.PName,
  pe2.Surname,
  pe2.Patronymic,
  pe2.Birthday,
  p2.[INP],
        p2.[InsuranceDocNumber],
  sl2.eventbegin,
  sl2.eventend,
  p2.externalid,
  p2.accountid
  FROM [FactMedicalEvent] AS sl2
    inner JOIN [FactPatient] AS p2 ON p2.[PatientId] = sl2.[PatientId] 
         and sl2.AssistanceConditions in (1) 
   inner join  [FactPerson] as pe2 on pe2.PersonId=p2.PersonalId  
 where sl2.AcceptPrice>0        
) as t2 on   t1.PName=t2.PName
  and t1.Surname=t2.Surname
  and t1.Patronymic=t2.Patronymic
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and 
  (
    (cast([t1].[EventBegin]as date) >=cast([t2].[EventBegin]as date) 
  and cast([t1].[EventBegin]as date) <cast([t2].[EventEnd]as date)
    )
  or 
    (cast([t2].[EventBegin]as date) >=cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <cast([t1].[EventEnd]as date)
    )
  )', N'�������� ���������� ��������� � �����  ��� ����� 2,1 �������� ������ ���������  ������ 3,0', N'', N'�������� ���������� ��������� � �����  ��� ����� 2,1 �������� ������ ���������  ������ 3,0', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 75, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'select t1.ZmedicalEventId -- ������� ������� ������(�� ������ �����)
--,
--t1.externalid,
--t2.accountid,
--t2.externalid

  
  from
 (Select zsl1.ZslMedicalEventId,
 p1.externalid,
 
  sl1.ZmedicalEventId,
  pe1.PName,
  pe1.Surname,
  pe1.Patronymic,
  pe1.Birthday,
  p1.[INP],
        p1.[InsuranceDocNumber],  
  sl1.eventbegin,
  sl1.eventend
  
 FROM [ZslFactMedicalEvent] AS zsl1
   inner join ZFactMedicalEvent as sl1 on sl1.ZslMedicalEventId=zsl1.ZslMedicalEventId
            and zsl1.AssistanceConditions=1
   inner JOIN [FactPatient] AS p1 ON p1.[PatientId] = zsl1.[PatientId] 
          and p1.[AccountId] = @AccountID
   inner join  [FactPerson] as pe1 on pe1.PersonId=p1.PersonalId      
) as t1--��� ������ ���������� �� �������� �����.
inner join --�������� �� ����� ����������� ���� �� ����� �������� ������ ������ 2,1
 (Select sl2.MedicalEventId,
  pe2.PName,
  pe2.Surname,
  pe2.Patronymic,
  pe2.Birthday,
  p2.[INP],
        p2.[InsuranceDocNumber],
  sl2.eventbegin,
  sl2.eventend,
  p2.externalid,
  p2.accountid
  FROM [FactMedicalEvent] AS sl2
    inner JOIN [FactPatient] AS p2 ON p2.[PatientId] = sl2.[PatientId] 
         and sl2.AssistanceConditions in (2) 
   inner join  [FactPerson] as pe2 on pe2.PersonId=p2.PersonalId  
 where sl2.AcceptPrice>0        
) as t2 on   t1.PName=t2.PName
  and t1.Surname=t2.Surname
  and t1.Patronymic=t2.Patronymic
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and 
  (
    (cast([t1].[EventBegin]as date) >cast([t2].[EventBegin]as date) 
  and cast([t1].[EventBegin]as date) <cast([t2].[EventEnd]as date)
    )
  or 
    (cast([t2].[EventBegin]as date) >cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <cast([t1].[EventEnd]as date)
    )
  )', N'�������� ���������� ��������� � �����  ��� ����� 2,1 �������� ������ ������� ���������  ������ 3,0', N'', N'�������� ���������� ��������� � �����  ��� ����� 2,1 �������� ������ ������� ���������  ������ 3,0', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 75, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'select t1.ZmedicalEventId -- ������� ������� ������(�� ������ �����)
--,
--t1.externalid,
--t2.accountid,
--t2.externalid

  
  from
 (Select zsl1.ZslMedicalEventId,
 p1.externalid,
 
  sl1.ZmedicalEventId,
  pe1.PName,
  pe1.Surname,
  pe1.Patronymic,
  pe1.Birthday,
  p1.[INP],
        p1.[InsuranceDocNumber],  
  sl1.eventbegin,
  sl1.eventend
  
 FROM [ZslFactMedicalEvent] AS zsl1
   inner join ZFactMedicalEvent as sl1 on sl1.ZslMedicalEventId=zsl1.ZslMedicalEventId
            and zsl1.AssistanceConditions=1
   inner JOIN [FactPatient] AS p1 ON p1.[PatientId] = zsl1.[PatientId] 
          and p1.[AccountId] = @AccountID
   inner join  [FactPerson] as pe1 on pe1.PersonId=p1.PersonalId      
) as t1--��� ������ ���������� �� �������� �����.
inner join --�������� �� ����� ����������� ���� �� ����� �������� ������ ������ 3,0
 (Select zsl2.ZslMedicalEventId,
  sl2.ZmedicalEventId,
  pe2.PName,
  pe2.Surname,
  pe2.Patronymic,
  pe2.Birthday,
  p2.[INP],
        p2.[InsuranceDocNumber],
  sl2.eventbegin,
  sl2.eventend,
  p2.externalid,
  p2.accountid
  FROM [ZslFactMedicalEvent] AS zsl2
   inner join ZFactMedicalEvent as sl2 on sl2.ZslMedicalEventId=zsl2.ZslMedicalEventId
             and zsl2.AssistanceConditions in (2)
   inner JOIN [FactPatient] AS p2 ON p2.[PatientId] = zsl2.[PatientId] 
          
   inner join  [FactPerson] as pe2 on pe2.PersonId=p2.PersonalId  
 where zsl2.AcceptPrice>0        
) as t2 on   t1.PName=t2.PName
  and t1.Surname=t2.Surname
  and t1.Patronymic=t2.Patronymic
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and 
  (
    (cast([t1].[EventBegin]as date) >cast([t2].[EventBegin]as date) 
  and cast([t1].[EventBegin]as date) <cast([t2].[EventEnd]as date)
    )
  or 
    (cast([t2].[EventBegin]as date) >cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <cast([t1].[EventEnd]as date)
    )
  )', N'�������� ���������� ��������� � �����  ��� ����� �������� ������ ������� ���������  ������ 3,0', N'', N'�������� ���������� ��������� � �����  ��� ����� �������� ������ ������� ���������  ������ 3,0', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 74, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'select t1.ZmedicalEventId -- ������� ������� ������(�� ������ �����)
--,
--t1.externalid,
--t2.accountid,
--t2.externalid

  
  from
 (Select zsl1.ZslMedicalEventId,
 p1.externalid,
 
  sl1.ZmedicalEventId,
  pe1.PName,
  pe1.Surname,
  pe1.Patronymic,
  pe1.Birthday,
  p1.[INP],
        p1.[InsuranceDocNumber],  
  sl1.eventbegin,
  sl1.eventend
  
 FROM [ZslFactMedicalEvent] AS zsl1
   inner join ZFactMedicalEvent as sl1 on sl1.ZslMedicalEventId=zsl1.ZslMedicalEventId
            and zsl1.AssistanceConditions=1
   inner JOIN [FactPatient] AS p1 ON p1.[PatientId] = zsl1.[PatientId] 
          and p1.[AccountId] = @AccountID
   inner join  [FactPerson] as pe1 on pe1.PersonId=p1.PersonalId      
) as t1--��� ������ ���������� �� �������� �����.
inner join --�������� �� ����� ����������� �������������/������� �� ����� �������� ������ ������ 3,0
 (Select zsl2.ZslMedicalEventId,
  sl2.ZmedicalEventId,
  pe2.PName,
  pe2.Surname,
  pe2.Patronymic,
  pe2.Birthday,
  p2.[INP],
        p2.[InsuranceDocNumber],
  sl2.eventbegin,
  sl2.eventend,
  p2.externalid,
  p2.accountid
  FROM [ZslFactMedicalEvent] AS zsl2
   inner join ZFactMedicalEvent as sl2 on sl2.ZslMedicalEventId=zsl2.ZslMedicalEventId
             and zsl2.AssistanceConditions in (3,4)
   inner JOIN [FactPatient] AS p2 ON p2.[PatientId] = zsl2.[PatientId] 
          
   inner join  [FactPerson] as pe2 on pe2.PersonId=p2.PersonalId  
 where zsl2.AcceptPrice>0        
) as t2 on   t1.PName=t2.PName
  and t1.Surname=t2.Surname
  and t1.Patronymic=t2.Patronymic
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and 
  (
  cast([t2].[EventBegin]as date) >cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <cast([t1].[EventEnd]as date)
  )', N'�������� ���������� ��������� � �����  ��� ����� �������� ������ ����������� ��� ������ ������ 3,0', N'', N'�������� ���������� ��������� � �����  ��� ����� �������� ������ ����������� ��� ������ ������ 3,0', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 2, 70, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'--declare @AccountID int
--Set @AccountID=21152
SELECT [t5].[ZmedicalEventId]
FROM [ZslFactMedicalEvent] AS [t0]
inner join ZFactMedicalEvent as [t4] on t4.ZslMedicalEventId=t0.ZslMedicalEventId
inner JOIN [FactPatient] AS [t1] ON [t1].[PatientId] = [t0].[PatientId]
inner join  [FactPerson] as pe1 on pe1.PersonId=t1.PersonalId
CROSS JOIN ([ZslFactMedicalEvent] AS [t2]
   inner join ZFactMedicalEvent as [t5] on t5.ZslMedicalEventId=t2.ZslMedicalEventId
   inner JOIN [FactPatient] AS [t3] ON [t3].[PatientId] = [t2].[PatientId]
   inner join  [FactPerson] as pe2 on pe2.PersonId=t3.PersonalId)
WHERE ([t1].[AccountId] <> @AccountID) 
  AND ([t3].[AccountId] = @AccountID) 
  AND ([t4].[SpecialityCodeV021] = [t5].[SpecialityCodeV021])--��� ������������� � ������
   AND ([t4].[EventBegin] = [t5].[EventBegin])   
    AND ([t4].[EventEnd] = [t5].[EventEnd]) 
    AND ([t4].[ProfileCodeId] = [t5].[ProfileCodeId])--������� � ������
          AND ([t3].[Newborn] = [t1].[Newborn])
       AND  pe1.PName=pe2.PName
  and pe1.Surname=pe2.Surname
  and pe1.Patronymic=pe2.Patronymic
  and pe1.Birthday=pe2.Birthday
  and (t1.[INP]=t3.[INP] or  t1.[InsuranceDocNumber]= t3.[InsuranceDocNumber])

 and (t0.AcceptPrice > 0)', N'�������� ������������ �� ���� ������ ������ 3.0 (������ �� ����� ������) �� �������, ��� ��� ������ ������, ����� �������, ���� �������������021', N'', N'�������� ������������ �� ���� ������ ������ 3.0 (������ �� ����� ������)', 1, 0.0000, 4, 1.0000, 7, 3)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'53', 1, 52, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'          
 use medicine_ins           
--DECLARE @AccountID  INT=21530
SELECT e.ZmedicalEventId, p.ExternalId,e.Pcel,ksg.kksg ,ksg.Kkpg  
            
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID          
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
           --and ((ze.AssistanceForm=3 and ze.AssistanceConditions in (1,2)) or (ze.AssistanceForm=2 and ze.AssistanceConditions in (1)) or (Pdisp2=1)) 
          
left join  ZFactKsgKpg ksg on ksg. ZmedicalEventId=e.ZmedicalEventId               
where 
e.ProfileCodeId is NULL --�� �������� ������� �������� ��
  or (ze.AssistanceConditions in (1,2) and e.ProfileCodeBedId is null) --�� �������� ������� ����� � ����������
  or e.IsChildren is NULL --�� �������� ������� �������� �������
  or (e.Pcel=''1.3'' and e.Dn is null) -- �� ��������� ���� ������������ ����������
  or
   (ze.AssistanceConditions=3 and isnull(e.Pcel,'''')='''') --�� ��������� ���� � ���
  or e.History is NULL --�� �������� ����� ������� �������
  or e.EventBegin is NULL --�� ��������� ���� ������ ������
  or e.EventEnd is NULL --�� ��������� ���� ��������� ������
  or (ze.AssistanceConditions in (1,2) and isnull(e.Kday,0)=0) --�� ��������� ���������� �����-���� � ����������
  or SpecialityCodeV021 is NULL --�� ��������� ������������� �����
  or e.EventPrice is NULL --�� ��������� ����� ������������ ������
  or (ze.AssistanceType=32 and (HighTechAssistanceType is null or HighTechAssistanceMethod is null)) --�� �������� ��� ��� ����� ���
  or 
  (
  (ze.AssistanceType<>32)
   and (ze.AssistanceConditions in (1,2)) 
   and (
    ( 
   (isnull(ksg.kksg,0)<>0) and (isnull(ksg.Kkpg,0)<>0)  and  PaymentMethod in (33,43)
   )
    or 
    (
   (isnull(ksg.kksg,0)=0)and (isnull(ksg.Kkpg,0)=0) and  PaymentMethod in (33,43)
   )
  )
   AND YEAR(ze.EventEndZ2)<=2018
  )
  or 
  (
  (ze.AssistanceType<>32)
   and (ze.AssistanceConditions in (1,2)) 
   and (
    ( 
   (isnull(ksg.kksg,0)<>0) and (isnull(ksg.Kkpg,0)<>0)  and  PaymentMethod in (33)
   )
    or 
    (
   (isnull(ksg.kksg,0)=0)and (isnull(ksg.Kkpg,0)=0) and  PaymentMethod in (33)
   )
  )
   AND YEAR(ze.EventEndZ2)>2018
  )
                        


  
                        

', N'�������� ���� ������������ ����� ������(����� ����� ���)', N'�� ��������� ���� �� ������������ ����� ������', N'�������� ������������ ����� ������', 1, 0.0000, 4, 1.0000, 7, 1)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'53', 1, 52, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID          
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
          
where (
  (ze.AssistanceForm=3 and ze.AssistanceConditions in (1,2))  
  or 
   (ze.AssistanceForm=2 and ze.AssistanceConditions in (1))
     or (Pdisp2=1)) and (ze.ReferralOrganization is null or ze.ReferralDate is null)
 --    order by p.ExternalId 
 
  
                        

', N'�������� ���� ������������ ����� ����������� ������', N'�� ��������� ���� �� ������������ ����� ����������� ������', N'�������� ������������ ����� ��� ������', 1, 0.0000, 4, 1.0000, 7, 1)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 65, N'', 1, 1, CAST(0x0000A91F00000000 AS DateTime), NULL, 2, N'---�������� �������, ����� ����� ����(��������)��� ������ ���� ����� ����� ���_� � �������

SELECT z.ZmedicalEventId--fp.AccountId , fp.externalid


  FROM [medicine_ins].[dbo].[ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId 
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId and zfme.ZslMedicalEventId in

(select t1.ZslMedicalEventId
from
(SELECT zfme.ZslMedicalEventId,sum(z.eventprice)as sum_m

  FROM [medicine_ins].[dbo].[ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId 
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId and fp.AccountId=@AccountID
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId --and a.date=''20180501'' and a.Source=38000

group by zfme.ZslMedicalEventId) t1
join (SELECT zfme.ZslMedicalEventId,zfme.price

  FROM  ZslFactMedicalEvent AS zfme 
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId and fp.AccountId=@AccountID
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId --and a.date=''20180501'' and a.Source=38000

) t2 on t1.ZslMedicalEventId=t2.ZslMedicalEventId and t1.sum_m<>t2.price)', N'�������� �������, ����� ����� ����(��������)��� ������ ���� ����� ����� ���_� � �������', N'', N'����� ����(��������)��� ������ �� ����� ����� ���_� � �������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'53', 1, 52, N'', 1, 1, CAST(0x0000A8B500000000 AS DateTime), NULL, 2, N'SELECT 
distinct z.ZmedicalEventId
--fp.AccountId , fp.externalid  
--,usl.MedicalOrganizationCode,usl.Profile,usl.IsChildren,usl.ServiceBegin,usl.ServiceEnd,usl.Diagnosis,usl.ServiceCode,usl.ServiceName,usl.Quantity,usl.Price,usl.SpecialityCodeV021

  FROM [medicine_ins].[dbo].[ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId and fp.AccountId=@AccountId
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId and  a.Source<>38000--a.date=''20180501'' and a.Source=38000
  join  ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId  
where usl.MedicalOrganizationCode is  null 
  or  usl.Profile is null
  or usl.IsChildren is null
  or usl.ServiceBegin is null
  or usl.ServiceEnd is null
  or usl.Diagnosis is null
  or isnull(usl.ServiceCode,'''')=''''
  or usl.ServiceName is null
  or usl.Quantity is null
  or usl.Price is null
  or usl.SpecialityCodeV021 is null
  
                        

', N'�������� ���� ������������ ����� ������', N'�� ��������� ���� �� ������������ ����� � ������', N'�������� ������������ ����� � ������', 1, 0.0000, 4, 1.0000, 7, 1)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId and p.AccountId=@AccountId 
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and ze.PaymentMethod<>11
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId  and e.Pcel not in (''2.2'')    
inner join V009 on v009.Id = ze.Result and ((v009.IDRMP < 316 or v009.IDRMP>358) and v009.IDRMP<>312)
   
where (EventBegin <ze.EventBeginZ1 or  EventEnd>ze.EventEndZ2)', N'���� ������ ������� �� ����� ��� ������', N'���� ������ ������� �� ����� ��� ������', N'���� ������ �� ������������� ������� ������������ ������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 55, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId and p.AccountId=@AccountId 
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId  
  
where (ze.EventEndZ2> dateadd(day,-1,dateadd(month,(1),dateadd(day,(1)-datepart(day,a.date),a.date))))', N'���� ������ ��� �� ������ ���������� ��� ������ ���� �������', N'���� ������������ ������ �� ������������� ������� �������', N'���� ������������ ������ �� ������������� ������� �������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId =p.AccountId and p.AccountId=@AccountId
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId 
inner join v021 v21 on v21.id=SpecialityCodeV021
LEFT JOIN V002_V021 v ON v.[IDPR_2] = e.ProfileCodeId AND v.[IDSPEC] = v21.IDSPEC
WHERE   v.[IDPR_2] IS NULL and v21.IDSPEC not in (85,86,97,98,99,101) and e.ProfileCodeId not in (158,160)', N'������� �� ������������ ������������� �����', N'������� �� ������������ ������������� �����', N'������������ ������� �� � ����. �����', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId and p.AccountId=@AccountId
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId    and ze.AssistanceConditions=3
inner join V009 on v009.Id = ze.Result 
   
where (
  (ze.EventBeginZ1 <>ze.EventEndZ2 and e.Pcel  in (''1.0'',''1.1'',''1.2'',''2.1'',''2.5'',''2.6'') )   
       or 
       (ze.EventBeginZ1 =ze.EventEndZ2 and e.Pcel in (''3.0'',''3.1'') and e.ProfileCodeId not in (63,85,86,87,88,89,90,171))
       )', N'���� �� ������������� ������� �������', N'���� �� ������������� ������� �������', N'���� �� ������������� ������� �������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 62, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId =p.AccountId and p.AccountId=@AccountId
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]-- and month(a.date)=7
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId   
inner join V009 on v009.Id = ze.Result and ((v009.IDRMP > 316 and v009.IDRMP<319) or v009.IDRMP=312 or (v009.IDRMP > 326 and v009.IDRMP<346)or (v009.IDRMP > 352 and v009.IDRMP<358))
   
', N'����������� �������� � ������������ � ����������� �����������', N'����������� �������� � ������������ � ����������� �����������', N'����������� �������� � ������������ � ����������� �����������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'--declare @AccountId  int =21274
select distinct z.ZmedicalEventId
 --distinct
 --zfme.ZslIdGuid,
 --zusl.SurgeryType
 --,sv.[VidVME]
 --,z.ProfileCodeId [z_ProfileCodeId]
 --,sv.[Profil] [sv_Profil]
 --,zusl.Profile [zusl_Profile]
 --,sv.[Profil] [sv_Profil]
 --,v21.idspec [v21_idspec]
 --,sv.[Spec] [sv_[Spec]
 --,zfme.AssistanceType as [zfme_AssistanceType]
 --,sv.[VidPom] [sv_VidPom]
 ---------------------------
 --,a.Source    
 --,f001.ShortName     
 --,a.Date
 --,a.AccountNumber
 --,p.AccountId
 --,p.ExternalId     
 --,pe.Surname     
 --,pe.PName    
 --,pe.Patronymic     
 --,pe.Birthday
FROM [medicine_ins].[dbo].[ZFactMedicalEvent] z
JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId  
JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId  and fp.AccountId=@AccountId 
      -- and  a.Source<>38000
JOIN ZFactMedicalServices AS zusl ON zusl.ZmedicalEventId = z.ZmedicalEventId
join v021 v21 on v21.id=zusl.SpecialityCodeV021
join v021 on v021.id=z.SpecialityCodeV021
join SprVME_Prof_Spec SV on zusl.SurgeryType=sv.[VidVME]
        and 
        (
        z.ProfileCodeId<>sv.[Profil] 
        or zusl.Profile<>sv.[Profil]
        or v21.idspec<>sv.[Spec]
        or v021.idspec<>sv.[Spec]
        or zfme.AssistanceType<>sv.[VidPom]
        )
-----------------------------------
inner JOIN [FactPatient] p ON zfme.PatientId=p.PatientId 
inner join FactPerson pe on pe.PersonId = p.PersonalId 
left join localF001 f001 on f001.OKATO = a.Source
', N'��� ������ �� ������������� �������, ������������� ��� ���� ������ (�� ����������������� ������� ���������� SprVME_Prof_Spec)', N'��� ������ �� ������������� �������, ������������� ��� ���� ������', N'��� ������ �� ������������� �������, ������������� ��� ���� ������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT distinct e.ZmedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId =p.AccountId and p.AccountId=@AccountId
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId 
inner join ZFactMedicalServices u on u.ZmedicalEventId=e.ZmedicalEventId
inner join v021 v21 on v21.id=u.SpecialityCodeV021
LEFT JOIN V002_V021 v ON v.[IDPR_2] = u.Profile AND v.[IDSPEC] = v21.IDSPEC
WHERE   v.[IDPR_2] IS NULL and v21.IDSPEC not in (85,86,97,98,99,101) and e.ProfileCodeId not in (158,160)', N'������� �� ������������ ������������� ����� � ������', N' � ������ ������� �� ������������ ������������� �����', N'������������ ������� �� � ����. ����� � ������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'--declare @AccountId int =23569
SELECT e.ZmedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId --and month(a.date)=11
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and ze.ZslMedicalEventId in (
SELECT ze.ZslMedicalEventId--, p.AccountId ,p.ExternalId       
FROM FactTerritoryAccount a --�����
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId and p.AccountId=@AccountId 
--inner join FactPerson pe on pe.PersonId = p.PersonalId--������������ ������ ���������
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]-- and ze.PaymentMethod<>11
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId -- and e.Pcel not in (''2.2'')    
--inner join V009 on v009.Id = ze.Result --and ((v009.IDRMP < 316 or v009.IDRMP>358) and v009.IDRMP<>312)
group by ze.ZslMedicalEventId
having count(*)=1 
)
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId -- and e.Pcel not in (''2.2'')    
--inner join V009 on v009.Id = ze.Result --and ((v009.IDRMP < 316 or v009.IDRMP>358) and v009.IDRMP<>312)
where (EventBegin <>ze.EventBeginZ1 or  EventEnd<>ze.EventEndZ2)
--order by p.AccountId', N'���� ������� � ������ �� ������������� ������� ������� � ����������� ������ (����������� �� ���������� ���� ������)', N'���� ������� � ������ �� ������������� ������� ������� � ����������� ������', N'���� ������� � ������ �� ������������� ������� ������� � ����������� ������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
          
where 
  (ze.AssistanceConditions in (4) and ze.PaymentMethod not IN (24))  
  or 
    (ze.AssistanceConditions in (3) and ze.PaymentMethod not IN (28,29,30)) 
     or 
   (ze.AssistanceConditions in (1,2) and ze.PaymentMethod not IN (32,33))', N'��� ������� � 2019 ����', N'������ ������ �� ������������� ������� �������� ��', N'������ ������ �� ������������� ������� �������� ��', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   --and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
          
where 
  (ze.AssistanceConditions in (1) and ze.AssistanceType not IN (31,32))  
  or 
    (ze.AssistanceConditions in (2) and ze.AssistanceType not IN (13,32,31)) 
     or 
    (ze.AssistanceConditions in (3) and ze.AssistanceType not IN (11,12,13)) 
     or 
    (ze.AssistanceConditions in (4) and ze.AssistanceType not IN (21)) ', N'��� ���������� 31,32, ��� �������� 13,31,32', N'������� �������� �� �� ������������� ���� ������', N'������� �������� �� �� ������������� ���� ������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
          
where (e.Pcel IN (''1.0'',''1.1'',''1.2'',''1.3'',''2.1'',''2.5'',''2.6'') and ze.PaymentMethod NOT IN (29))
       OR
       (e.Pcel IN (''2.3'') and ze.PaymentMethod NOT IN (28,29))
       OR (e.Pcel  not IN (''2.3'') and ze.PaymentMethod IN (28))
       OR
       (e.Pcel IN (''3.0'',''3.1'') and ze.PaymentMethod NOT IN (30))', N'��� 2019 � �����', N'������ ������ �� ������������� ����', N'������ ������ �� ������������� ����', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'--DECLARE @AccountID INT =24172

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--fp.AccountId , fp.externalid,v9.[IDRMP],v12.[IDIZ],zsl.AssistanceConditions


  FROM [medicine_ins].[dbo].[ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  --join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  join v009 v9 on v9.id= Result
 --join v012 v12 on v12.id=Outcome
where SUBSTRING(CAST(v9.[IDRMP] AS VARCHAR(3)), 1, 1)<>zsl.AssistanceConditions-- or SUBSTRING(CAST(v12.[IDIZ] AS VARCHAR(3)), 1, 1)<>zsl.AssistanceConditions 
--order by fp.AccountId , fp.externalid', N'��������� �� �� ������������� ������� ��������', N'��������� �� �� ������������� ������� ��������', N'��������� �� �� ������������� ������� ��������', 1, 0.0000, 4, 1.0000,7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--fp.AccountId , fp.externalid,v9.[IDRMP],v12.[IDIZ],zsl.AssistanceConditions


  FROM [medicine_ins].[dbo].[ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  --join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  --join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where SUBSTRING(CAST(v12.[IDIZ] AS VARCHAR(3)), 1, 1)<>zsl.AssistanceConditions 
--order by fp.AccountId , fp.externalid', N'����� �� �� ������������� ������� ��������', N'����� �� �� ������������� ������� ��������', N'����� �� �� ������������� ������� ��������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'
SELECT z.ZmedicalEventId--, fp.AccountId,fp.ExternalId   
--fp.AccountId , fp.externalid,v9.[IDRMP],v12.[IDIZ],zsl.AssistanceConditions


  FROM [medicine_ins].[dbo].[ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  --join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where (v9.[IDRMP] IN (205,206) AND v12.[IDIZ] NOT IN (204))
         OR 
  (v9.[IDRMP] IN (405,406) AND v12.[IDIZ] NOT IN (403))
  OR
  (v9.[IDRMP] IN (313) AND v12.[IDIZ] NOT IN (304))
    OR
  (v9.[IDRMP] IN (411) AND v12.[IDIZ] NOT IN (402))', N'��������� ��������� �� ������������� ������', N'��������� ��������� �� ������������� ������', N'��������� ��������� �� ������������� ������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   --and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
INNER JOIN   FactPerson pe ON pe.PersonId=p.PersonalId    
left join v021 v21 on v21.id=SpecialityCodeV021
   
where dbo.f_GetAge(pe.Birthday,e.EventBegin)<18
      AND ze.AssistanceConditions=3
      AND e.ProfileCodeId in (1,14,23,29,60,87,88,89,90,97,108,112,122,164)
      AND e.Pcel not in (''1.0'',''1.1'',''3.0'')', N'������� ��� ������ �� ������������� �������� ��������', N'������� ��� ������ �� ������������� �������� ��������', N'������� ��� ������ �� ������������� �������� ��������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'
SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   --and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
INNER JOIN   FactPerson pe ON pe.PersonId=p.PersonalId    

   
where dbo.f_GetAge(pe.Birthday,e.EventBegin)>=1
         AND e.ProfileCodeId in (55)', N'������� ��� ������ ������������ �� ������������� �������� ��������', N'������� ��� ������ ������������ �� ������������� �������� ��������', N'������� ��� ������ ������������ �� ������������� �������� ��������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   --and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
INNER JOIN   FactPerson pe ON pe.PersonId=p.PersonalId    

   
where dbo.f_GetAge(pe.Birthday,e.EventBegin)<65
         AND e.ProfileCodeId in (14)', N'������� ��� ������ ��������� �� ������������� �������� ��������', N'������� ��� ������ ��������� �� ������������� �������� ��������', N'������� ��� ������ ��������� �� ������������� �������� ��������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   --and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
   
where (ze.AssistanceConditions=3 AND e.ProfileCodeId IN (68,97,57,151) AND ze.AssistanceType<>12)
OR (ze.AssistanceConditions=3  AND ze.AssistanceType=12 AND e.ProfileCodeId not IN (68,97,57,151))
OR (ze.AssistanceConditions=3  AND e.ProfileCodeId IN (58,3,82,83,42,85) AND ze.AssistanceType<>11 )
OR (ze.AssistanceConditions=3  AND ze.AssistanceType=11 AND e.ProfileCodeId not IN (58,3,82,83,42,85))         
OR (ze.AssistanceConditions=4  AND ze.AssistanceType=21 AND e.ProfileCodeId not IN (84)) 
OR (ze.AssistanceConditions=4  AND ze.AssistanceType<>21 AND e.ProfileCodeId  IN (84)) ', N'��� ������ �� ������������� ������� �������', N'��� ������ �� ������������� ������� �������', N'��� ������ �� ������������� ������� �������', 1, 0.0000, 4, 1.0000, 7, 2)
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A94200000000 AS DateTime), NULL, 2, N'SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   --and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
   
where ze.AssistanceConditions=3 AND ((ze.AssistanceForm=2 AND e.Pcel NOT IN (''1.1''))
OR (ze.AssistanceForm<>2 AND e.Pcel IN (''1.1'')))', N'����� ������ �� ������������� ���� ���������', N'����� ������ �� ������������� ���� ���������', N'����� ������ �� ������������� ���� ���������', 1, 0.0000, 4, 1.0000, 7, 2)


UPDATE f SET f.DateBegin = '20190101' 
FROM [FactExpertCriterion] f

EXEC [dbo].[versionUpdate] 557
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