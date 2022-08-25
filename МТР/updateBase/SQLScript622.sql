BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 621

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
	
	VALUES ('',1,53,'',1,1,'01.11.2019',NULL,2,'--003K.00.0321
--Недопустимый код вида медицинской помощи для условий оказания медицинской помощи

--DECLARE @AccountID INT =28739
SELECT distinct e.ZmedicalEventId--, p.AccountId,p.ExternalId       
           
FROM          
[FactPatient] p           
          
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] and  p.AccountId=@AccountID    
                                                                   --and  YEAR(ze.EventEndZ2)>=2019      
inner JOIN ZFactMedicalEvent e on ze.ZslMedicalEventId = e.ZslMedicalEventId            
          
where 
  --(ze.AssistanceConditions in (1) and ze.AssistanceType not IN (31,32))  
 -- or 
   -- (ze.AssistanceConditions in (2) and ze.AssistanceType not IN (13,32,31)) 
   --  or 
  --  (ze.AssistanceConditions in (3) and ze.AssistanceType not IN (11,12,13)) 
    -- or 
    ze.AssistanceConditions in (1) and ze.AssistanceType not IN (3, 21, 31, 32, 33)','003K.00.0321_Недопустимый код вида медицинской помощи для условий оказания медицинской помощи','003K.00.0321_Недопустимый код вида медицинской помощи для условий оказания медицинской помощи','Недопустимый код вида медицинской помощи для условий оказания медицинской помощи',1,0.00,4,1.00,9,2,'003K.00.0321','3B67F193-10A4-4160-B8A1-C27C0B6DAF4F')
	
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0321%' ) 	
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


EXEC [dbo].[versionUpdate] 622
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