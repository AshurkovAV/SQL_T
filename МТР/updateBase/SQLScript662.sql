BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 661

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
	
	VALUES ('',1,53,'',1,1,'01.12.2020',NULL,2,'--койко-дни в законченном случае не равны сумме койко-дней в случае
--DECLARE @AccountID INT =32863
SELECT 
distinct z.ZmedicalEventId
--fp.AccountId , fp.externalid--,zfme.Kdz,datediff(dd,EventBeginZ1,EventEndZ2)
--fp.AccountId , fp.externalid,zfme.ZslMedicalEventId,zfme.Kdz,sum(z.Kday)

---3----
--update zfme
--set zfme.AssistanceType=13
  FROM [ZFactMedicalEvent] z
  where z.ZslMedicalEventId in
  (SELECT 
distinct zfme.ZslMedicalEventId
--fp.AccountId , fp.externalid--,zfme.Kdz,datediff(dd,EventBeginZ1,EventEndZ2)
--fp.AccountId , fp.externalid,zfme.ZslMedicalEventId,zfme.Kdz,sum(z.Kday)
  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId  
           
               

  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId 
  join FactPerson pe on pe.PersonId=fp.PersonalId
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  where   a.TerritoryAccountId=@AccountID 
  group by fp.AccountId , fp.externalid,zfme.ZslMedicalEventId,zfme.Kdz
  having sum(z.Kday)<>zfme.Kdz)
       
    
  and a.TerritoryAccountId=@AccountID 

','Койко-дни в законченном случае не равны сумме койко-дней в случае','Койко-дни в законченном случае не равны сумме койко-дней в случае','Койко-дни в законченном случае не равны сумме койко-дней в случае',1,0.00,4,1.00,9,2,'','0B464FBE-8610-4B3A-B8EE-C3311BD0D2C1')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '0B464FBE-8610-4B3A-B8EE-C3311BD0D2C1' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '0B464FBE-8610-4B3A-B8EE-C3311BD0D2C1')--[Description] LIKE '003K.00.0501%' ) 	
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



EXEC [dbo].[versionUpdate] 662
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