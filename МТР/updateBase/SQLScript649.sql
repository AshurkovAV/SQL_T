BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 648

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0550_ Не указано количество посещений 
--ED_COL должно быть заполнено ненулевым значением  

--DECLARE @AccountID INT =24172
SELECT distinct z.ZmedicalEventId--,fp.AccountId , fp.externalid,z.Quantity

  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId  
           
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId 
  join FactPerson pe on pe.PersonId=fp.PersonalId
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 

 where  zfme.AssistanceConditions=3 and zfme.PaymentMethod in (25,29)
 and isnull(Quantity,0)=0
 and fp.AccountId=@AccountID ','003K.00.0550_ Не указано количество посещений ','003K.00.0550_ Не указано количество посещений ','Не указано количество посещений',1,0.00,4,1.00,9,2,'003K.00.0550','78B90429-D924-4DF0-BA2E-5C460B6B20C9')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '78B90429-D924-4DF0-BA2E-5C460B6B20C9' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '78B90429-D924-4DF0-BA2E-5C460B6B20C9')--[Description] LIKE '003K.00.0501%' ) 	
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


EXEC [dbo].[versionUpdate] 649
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



