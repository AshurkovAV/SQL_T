BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 640

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0640_Несоответствие диагноза осложнения полу пациента
--Ошибка фиксируется при указании диагноза  из рубрики О МКБ-10 для W=1 

--DECLARE @AccountId  INT=25571

 
 SELECT             
 DISTINCT e.ZmedicalEventId
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId 
   JOIN   FactPerson pe ON pe.PersonId=p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
  INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
 join  ZFactDs dss on dss.ZmedicalEventId = e.ZmedicalEventId

WHERE   dss.DsType=3
        and dss.Ds  LIKE ''O%'' 

  and pe.Sex=1
  AND p.AccountId=@AccountId 
  --and a.date >''20200101''','003K.00.0640_Несоответствие диагноза осложнения полу пациента','003K.00.0640_Несоответствие диагноза осложнения полу пациента
--Ошибка фиксируется при указании диагноза  из рубрики О МКБ-10 для W=1 ','Несоответствие диагноза осложнения полу пациента',1,0.00,4,1.00,9,2,'003K.00.0640','19F663B2-F845-4318-9CA6-B1F7A2F416B5')
	
	DELETE FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0640%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0640%' ) 	
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


EXEC [dbo].[versionUpdate] 641
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



