BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 636

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0400_Недопустимый код способа оплаты при межтерриториальных расчетах
SELECT e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
          
where 
ze.PaymentMethod not IN (24, 28, 29, 30, 32, 33)
 
   --003K.00.0400 ZL_LIST/ZAP/Z_SL/IDSP Недопустимый код способа оплаты при межтерриториальных расчетах D, R    IDSP = {24, 28, 29, 30, 32, 33} Ошибка фиксируется, если указано значение IDSP, не входящее в множество {24, 28, 29, 30, 32, 33} 01.11.2019 ','003K.00.0400_Недопустимый код способа оплаты при межтерриториальных расчетах','003K.00.0400_Недопустимый код способа оплаты при межтерриториальных расчетах','Недопустимый код способа оплаты при межтерриториальных расчетах',1,0.00,4,1.00,9,2,'003K.00.0400','1E8593AC-80C4-4CE2-AC93-000C8C2FDC1D')
	
	DELETE FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0400%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0400%' ) 	
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


EXEC [dbo].[versionUpdate] 637
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



