BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 684


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
	
	VALUES ('',1,211,'',1,1,'01.01.2022',NULL,2,'--DECLARE @AccountID INT = 27978

SELECT DISTINCT  e.ZmedicalEventId --не оплачивается в системе омс
 FROM FactPatient AS p     
  inner join ZslFactMedicalEvent AS ze ON ze.PatientId = p.PatientId
  inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
  left join ZFactMedicalServices usl on usl.ZmedicalEventId=e.ZmedicalEventId
  left join  [M001] m on m.id=e.DiagnosisPrimary
  left join [M001_oplata_status] m1 on m1.IDDS=m.IDDS
  left join v021 v21 on v21.Id=e.SpecialityCodeV021
  left join v002 v02 on v02.Id=e.ProfileCodeId
 WHERE 
  p.AccountId = @AccountID
  and  
  (
  usl.Comments like ''%аутопсия%''
  or
  usl.ServiceName like ''%аутопсия%''
  or 
  m1.osn is not null
  or
  v21.IDSPEC in (85,86,97,98,99,101)
  or
  v02.IDPR in (72,73,74,95,165,173,174,175,176,110,52,73,119,157,159,32,33,146,170,45,172)
  )
 ','1.6.1 - включение в реестр счетов видов медицинской помощи, а также заболеваний и состояний, не входящих в программу обязательного медицинского страхования; (базовая программа)','1.6.1 - включение в реестр счетов видов медицинской помощи, а также заболеваний и состояний, не входящих в программу обязательного медицинского страхования; (базовая программа)','1.6.1 - включение в реестр счетов видов медицинской помощи, а также заболеваний и состояний',1,0.00,4,1.00,9,2,'','1991DFE2-D1B7-4BFE-8D7E-665B25175E84')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '1991DFE2-D1B7-4BFE-8D7E-665B25175E84' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '1991DFE2-D1B7-4BFE-8D7E-665B25175E84')--[Description] LIKE '003K.00.0501%' ) 	
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



EXEC [dbo].[versionUpdate] 685
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