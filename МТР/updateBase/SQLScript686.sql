BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 685


DECLARE @FactExpertCriterion TABLE(
	[Code] [nvarchar](20) NULL,
	[Weight] [int] NULL,
	[Reason] [int] NULL,
	[PG] [nvarchar](100) NULL,
	[Type] [int] NULL,
	[IsEnable] [bit] NULL,
	[DateBegin] [datetime] NULL,
	[DateEnd] [datetime] NULL,
	[Scope] [int] NULL,
	[Query] [nvarchar](max) NULL,
	[Description] [nvarchar](254) NULL,
	[Comments] [nvarchar](254) NULL,
	[Name] [nvarchar](100) NULL,
	[IsAuto] [bit] NULL,
	[PenaltyPercent] [money] NULL,
	[ErrorScope] [int] NULL,
	[RefusalPercent] [money] NULL,	
	[Version] [int] NULL,
	[Group] [int] NULL,
	FedCode NVARCHAR(25),
	OidCode NVARCHAR(36))
	
	INSERT @FactExpertCriterion ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group], FedCode, OidCode)
	
	VALUES ('',1,221,'',1,1,'01.01.2022',NULL,2,'---651,650,649,648,649
--declare @AccountID int=43144
select t1.ZmedicalEventId -- снимаем текущий случай(из нового счета)
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
) as t1--все случаи стационара по текущему счету.
inner join --соединяю со всеми оплаченными поликлиниками/скорыми из ранее поданных счетов версии 3,0
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
) as t2 on t1.PName=t2.PName
  and isnull(t1.Surname,'')=isnull(t2.Surname,'')
  and isnull(t1.Patronymic,'')=isnull(t2.Patronymic,'')
  and t1.Birthday=t2.Birthday
  and (t1.[INP]=t2.[INP] or  t1.[InsuranceDocNumber]= t2.[InsuranceDocNumber])
  and 
  (
  cast([t2].[EventBegin]as date) >=cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <=cast([t1].[EventEnd]as date)
  )
  and t1.ZslMedicalEventId<>t1.ZslMedicalEventId
  union
  select t1.ZmedicalEventId -- снимаем текущий случай(из нового счета)
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
) as t1--все случаи стационара по текущему счету.
inner join --соединяю со всеми оплаченными стац из ранее поданных счетов версии 3,0
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
    (cast([t1].[EventBegin]as date) >=cast([t2].[EventBegin]as date) 
  and cast([t1].[EventBegin]as date) <=cast([t2].[EventEnd]as date)
    )
  or 
    (cast([t2].[EventBegin]as date) >=cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <=cast([t1].[EventEnd]as date)
    )
  )
  and t1.ZslMedicalEventId<>t1.ZslMedicalEventId
  union
  select t1.ZmedicalEventId -- снимаем текущий случай(из нового счета)
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
) as t1--все случаи стационара по текущему счету.
inner join --соединяю со всеми оплаченными стац из ранее поданных счетов версии 2,1
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
    (cast([t1].[EventBegin]as date) >=cast([t2].[EventBegin]as date) 
  and cast([t1].[EventBegin]as date) <=cast([t2].[EventEnd]as date)
    )
  or 
    (cast([t2].[EventBegin]as date) >=cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <=cast([t1].[EventEnd]as date)
    )
  )
  and t1.ZslMedicalEventId<>t1.ZslMedicalEventId
  union
  select t1.ZmedicalEventId -- снимаем текущий случай(из нового счета)
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
) as t1--все случаи стационара по текущему счету.
inner join --соединяю со всеми оплаченными стац из ранее поданных счетов версии 2,1
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
  )
  and t1.ZslMedicalEventId<>t1.ZslMedicalEventId
  union
  select t1.ZmedicalEventId -- снимаем текущий случай(из нового счета)
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
) as t1--все случаи стационара по текущему счету.
inner join --соединяю со всеми оплаченными стац из ранее поданных счетов версии 2,1
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
    cast([t2].[EventBegin]as date) >=cast([t1].[EventBegin]as date) 
  and cast([t2].[EventBegin]as date) <=cast([t2].[EventEnd]as date)
    
   )
   and t1.ZslMedicalEventId<>t1.ZslMedicalEventId',
   '1.10.1 - позиция реестра счетов оплачена ранее (повторное выставление счета на оплату случаев',
   '1.10.1 - позиция реестра счетов оплачена ранее (повторное выставление счета на оплату случаев',
   '1.10.1 - позиция реестра счетов оплачена ранее (повторное выставление счета на оплату случаев',1,0.00,4,1.00,9,2,'','D4606E84-BC42-415D-9EB5-680C947F8CE3')



   DELETE FROM FactExpertCriterion WHERE OidCode = 'D4606E84-BC42-415D-9EB5-680C947F8CE3' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'D4606E84-BC42-415D-9EB5-680C947F8CE3')--[Description] LIKE '003K.00.0501%' ) 	
	BEGIN
	
	INSERT INTO FactExpertCriterion
	(
		Code,
		[Weight],
		Reason,
		PG,
		[Type],
		IsEnable,
		DateBegin,
		DateEnd,
		Scope,
		[Query],
		[Description],
		Comments,
		Name,
		IsAuto,
		PenaltyPercent,
		ErrorScope,
		RefusalPercent,		
		[Version],
		[Group],
		[FedCode],
		[OidCode]
	)

	SELECT * from @FactExpertCriterion
	END


EXEC [dbo].[versionUpdate] 686
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