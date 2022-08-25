BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 622


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
	
	VALUES ('',1,53,'',1,1,'01.11.2019',NULL,2,'--003K.00.0331
--Несоответствие результата обращения и исхода заболевания (летальность) RSLT={105, 106} ISHOD=104
--DECLARE @AccountID INT =24172
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId 
  and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND a.Date >= ''20191101''
 
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where v9.IDRMP IN (105, 106) 
AND v12.IDIZ  not IN (104)','003K.00.0331_Несоответствие результата обращения и исхода заболевания (летальность) RSLT={105, 106} ISHOD=104','003K.00.0331_Несоответствие результата обращения и исхода заболевания (летальность) RSLT={105, 106} ISHOD=104','Несоответствие результата обращения и исхода заболевания (летальность)',1,0.00,4,1.00,9,2,'003K.00.0331','4B907A21-89DF-4D44-85F6-20975B598329')
	
	DELETE FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0330%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0331%' ) 	
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



EXEC [dbo].[versionUpdate] 623
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