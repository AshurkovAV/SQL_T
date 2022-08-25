BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 644

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0430_Количество койко-дней/пациенто-дней превышает длительность лечения в стационаре
--DECLARE @AccountID INT =29432

SELECT distinct z.ZmedicalEventId
--fp.AccountId , fp.externalid,kday,datediff(dd,z.EventBegin,z.EventEnd),z.EventBegin,z.EventEnd,zfme.AssistanceConditions


---3----
--update zfme
--set zfme.AssistanceType=13
  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId  
           
               

  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId 
  join FactPerson pe on pe.PersonId=fp.PersonalId
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 -- join ZFactKsgKpg ksg on ksg.ZmedicalEventId=z.ZmedicalEventId
 left join f003 f3 on f3.Id=zfme.ReferralOrganization
where  zfme.AssistanceConditions in (1) 
         and (isnull(Kday,0)=0 
       or 
        (datediff(dd,z.EventBegin,z.EventEnd)=0 and kday<>1
      or datediff(dd,z.EventBegin,z.EventEnd)<>0 and kday>datediff(dd,z.EventBegin,z.EventEnd)
      )
    )
       
    
  and a.TerritoryAccountId=@AccountID 

','003K.00.0430_Количество койко-дней/пациенто-дней превышает длительность лечения в стационаре','003K.00.0430_Количество койко-дней/пациенто-дней превышает длительность лечения в стационаре','Количество койко-дней/пациенто-дней превышает длительность лечения в стационаре',1,0.00,4,1.00,9,2,'003K.00.0430','FE3CC8AC-596B-4C4F-A66C-4A473A957897')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = 'FE3CC8AC-596B-4C4F-A66C-4A473A957897' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'FE3CC8AC-596B-4C4F-A66C-4A473A957897')--[Description] LIKE '003K.00.0501%' ) 	
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


EXEC [dbo].[versionUpdate] 645
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



