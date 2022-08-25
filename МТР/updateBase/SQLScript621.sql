BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 620

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
	
	VALUES ('',1,55,'',1,1,'01.04.2020',NULL,2,'--5.1.6. дата случая не соответствует периоду счета
SELECT distinct--top 10 p.AccountId ,p.ExternalId, a.date, dateadd(month,1,dateadd(day,1-day(a.date),a.date))-1
e.ZmedicalEventId--, p.ExternalId,Pdisp2       
           
FROM      
FactTerritoryAccount a --счета            
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId    
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID          
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
          
where ze.EventEndZ2 not between a.date and dateadd(month,1,dateadd(day,1-day(a.date),a.date))-1--EOMONTH (a.date)','Дата случая не соответствует периоду счета','Дата случая не соответствует периоду счета','Дата случая не соответствует периоду счета',1,0.00,4,1.00,9,2,'','CBD62079-371E-4667-9F9D-AACE7F462B8F')
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'CBD62079-371E-4667-9F9D-AACE7F462B8F' ) 	
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


EXEC [dbo].[versionUpdate] 621
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