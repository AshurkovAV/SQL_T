BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 658

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
	
	VALUES ('',1,61,'',1,1,'01.11.2019',NULL,2,'    --5.3.1. Тест на ковид без госпитализации или диагноза.
--DECLARE @AccountID  INT=31443
select distinct t1.ZmedicalEventId
from
(
--поиск тест ковид
select distinct  a.source,a.Date,a.TerritoryAccountId,e.ZmedicalEventId,pe.PName,pe.Surname,pe.Patronymic,pe.Birthday,p.INP,p.InsuranceDocNumber,p.InsuranceDocSeries
--a.TerritoryAccountId,p.ExternalId,ter.ShortName,ze.AssistanceType,	
--ze.AssistanceConditions,ze.ZslMedicalEventId,v002.IDPR, v002.PRNAME,m1.idds, e.EventPrice,usl.ServiceName,e.Comments	
FROM FactTerritoryAccount a --счета   inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId             							
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId             							
          and  a.TerritoryAccountId = @AccountID             	
           -- and a.Destination=38000	
           -- AND a.type=1	
           and  a.Date>''20200601''	
          --  AND a.Source IN (45000,40000)--г.Москва и Санкт-Петербург          	
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]            	
                             -- and ze.AcceptPrice>0               	
                              AND ze.[AssistanceConditions] in (3)  	
                           --   AND ze.AssistanceForm=3	
inner join FactPerson pe on pe.PersonId=p.PersonalId
INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId  	
inner join localF001 ter on ter.OKATO = a.Source 	
inner JOIN [V006] AS [t2] ON [t2].[id] = ze.[AssistanceConditions]  	
INNER JOIN v002 ON v002.Id = e.ProfileCodeId 	
left JOIN ZFactMedicalServices usl on usl.ZmedicalEventId=e.ZmedicalEventId	
left join m001 m1 on m1.Id=e.DiagnosisGeneral	
	
WHERE v002.IDPR in (34,38) --клинич лаб диагно или лаб диагностика
      and 
	  (m1.IDDS like ''Z11.5%'' or usl.ServiceName like ''%Тестирование групп риска на выявление новой коронавирусной инфекции%'' 
                             or usl.ServiceName like ''%Определение антител к коронавирусу%''
							 or usl.ServiceName like ''%на антитела к коронавирусу%''
							 or e.Comments like ''%Тестирование групп риска на выявление новой коронавирусной инфекции%'' 
                             or e.Comments like ''%Определение антител к коронавирусу%''
							 or e.Comments like ''%на антитела к коронавирусу%'')
) t1
left join 
(
--поиск тест ковид
select distinct  a.source,a.Date,TerritoryAccountId,e.ZmedicalEventId,pe.PName,pe.Surname,pe.Patronymic,pe.Birthday,p.INP,p.InsuranceDocNumber,p.InsuranceDocSeries
--a.TerritoryAccountId,p.ExternalId,ter.ShortName,ze.AssistanceType,	
--ze.AssistanceConditions,ze.ZslMedicalEventId,v002.IDPR, v002.PRNAME,m1.idds, e.EventPrice,usl.ServiceName,e.Comments	
FROM FactTerritoryAccount a --счета        0000000000	
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId             	
          --  and a.Destination=38000	
            --AND a.type=1	
         and  a.Date>''20200601'' 	
          --  AND a.Source IN (45000,40000)--г.Москва и Санкт-Петербург          	
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]            	

inner join FactPerson pe on pe.PersonId=p.PersonalId
INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId  	
inner join localF001 ter on ter.OKATO = a.Source 	
inner JOIN [V006] AS [t2] ON [t2].[id] = ze.[AssistanceConditions]  	
INNER JOIN v002 ON v002.Id = e.ProfileCodeId 	
left JOIN ZFactMedicalServices usl on usl.ZmedicalEventId=e.ZmedicalEventId	
left join m001 m1 on m1.Id=e.DiagnosisGeneral	
	
WHERE  ze.[AssistanceConditions] in (1,2)
) t2 on t1.source=t2.source and t1.Date=t2.date
        and (t1.PName=t2.PName and t1.Surname=t2.Surname and t1.Patronymic=t2.Patronymic and t1.Birthday=t2.Birthday
		        or isnull(t1.INP,t1.InsuranceDocNumber)=isnull(t2.INP,t2.InsuranceDocNumber)
             )
left join 
--поиск поликлинического случая с J
(
select distinct  a.source,a.Date,a.TerritoryAccountId,e.ZmedicalEventId,pe.PName,pe.Surname,pe.Patronymic,pe.Birthday,p.INP,p.InsuranceDocNumber,p.InsuranceDocSeries
--a.TerritoryAccountId,p.ExternalId,ter.ShortName,ze.AssistanceType,	
--ze.AssistanceConditions,ze.ZslMedicalEventId,v002.IDPR, v002.PRNAME,m1.idds, e.EventPrice,usl.ServiceName,e.Comments	
FROM FactTerritoryAccount a --счета        0000000000	
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId             	
          --  and a.Destination=38000	
           -- AND a.type=1	
           and  a.Date>''20200601'' 	
                   	
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]inner join FactPerson pe on pe.PersonId=p.PersonalId
INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId  	
inner join localF001 ter on ter.OKATO = a.Source 	
inner JOIN [V006] AS [t2] ON [t2].[id] = ze.[AssistanceConditions]  	
INNER JOIN v002 ON v002.Id = e.ProfileCodeId 	
left JOIN ZFactMedicalServices usl on usl.ZmedicalEventId=e.ZmedicalEventId	
left join m001 m1 on m1.Id=e.DiagnosisGeneral	
	
WHERE  ze.[AssistanceConditions] in (3)  	
      and 
	  (m1.IDDS like ''J%'' or m1.IDDS like ''U07%'') 
) t3 on t1.source=t3.source and t1.Date=t3.date 
        and (t1.PName=t2.PName and t3.Surname=t2.Surname and t1.Patronymic=t3.Patronymic and t1.Birthday=t3.Birthday
		        or isnull(t1.INP,t1.InsuranceDocNumber)=isnull(t3.INP,t3.InsuranceDocNumber)
             )
where t2.ZmedicalEventId is null and t3.ZmedicalEventId is null

','Тест на ковид без госпитализации или диагноза','Тест на ковид без госпитализации или диагноза','Тест на ковид без госпитализации или диагноза',1,0.00,4,1.00,9,2,'','AA9C84EC-B728-460B-8E5B-FB3C9E15B315')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = 'AA9C84EC-B728-460B-8E5B-FB3C9E15B315' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'AA9C84EC-B728-460B-8E5B-FB3C9E15B315')--[Description] LIKE '003K.00.0501%' ) 	
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

EXEC [dbo].[versionUpdate] 659
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



