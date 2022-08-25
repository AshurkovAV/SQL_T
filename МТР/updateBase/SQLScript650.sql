BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 649

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0560_Количество единиц оплаты в случае не совпадает с количеством блоков услуг по случаю 
--ED_COL должно равняться количеству элементов USL, входящих в случай (правило не применяется к стоматологическим профилям)  

--DECLARE @AccountID INT =24742
SELECT distinct z.ZmedicalEventId--,fp.AccountId , fp.externalid,z.Quantity,count(distinct usl.ZmedicalServicesId)

  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId  
           
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId 
  join FactPerson pe on pe.PersonId=fp.PersonalId
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  left join ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId
 where  zfme.AssistanceConditions=3 and zfme.PaymentMethod in (28)
  and z.ProfileCodeId not in (85,86,87,88,89,90,140)
 group by z.ZmedicalEventId,fp.AccountId , fp.externalid,z.Quantity
 having z.Quantity<>count(distinct usl.ZmedicalServicesId)
 and fp.AccountId=@AccountID ','003K.00.0560_Количество единиц оплаты в случае не совпадает с количеством блоков услуг по случаю','003K.00.0560_Количество единиц оплаты в случае не совпадает с количеством блоков услуг по случаю','Количество единиц оплаты в случае не совпадает с количеством блоков услуг по случаю',1,0.00,4,1.00,9,2,'003K.00.0560','12481532-424E-4556-95AF-E804A1AC16FE')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '12481532-424E-4556-95AF-E804A1AC16FE' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '12481532-424E-4556-95AF-E804A1AC16FE')--[Description] LIKE '003K.00.0501%' ) 	
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


EXEC [dbo].[versionUpdate] 650
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



