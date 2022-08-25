BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 632

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0481_Взаимное несоответствие результата лечения и условий оказания медицинской помощи   USL_OK=4 

--DECLARE @AccountID INT =28739
SELECT distinct  z.ZmedicalEventId--, fp.AccountId,fp.ExternalId ,v9.IDRMP ,zsl.AssistanceConditions  
--fp.AccountId , fp.externalid,v9.[IDRMP],v12.[IDIZ],zsl.AssistanceConditions


  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  --join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  join v009 v9 on v9.id= Result
 --join v012 v12 on v12.id=Outcome
where zsl.AssistanceConditions=4 and 
SUBSTRING(CAST(v9.IDRMP AS VARCHAR(3)), 1, 1)<>zsl.AssistanceConditions 
--order by fp.AccountId , fp.externalid
','003K.00.0481_Взаимное несоответствие результата лечения и условий оказания медицинской помощи   USL_OK=4 ','003K.00.0481_Взаимное несоответствие результата лечения и условий оказания медицинской помощи   USL_OK=4 ','Взаимное несоответствие результата лечения и условий оказания медицинской помощи',1,0.00,4,1.00,9,2,'003K.00.0481','06FA853B-45EE-4751-8D0D-A1AB7AEF24E6')
	
	DELETE FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0481%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0481%' ) 	
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


EXEC [dbo].[versionUpdate] 633
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



