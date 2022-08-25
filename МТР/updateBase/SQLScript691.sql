BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 690

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
	OidCode NVARCHAR(36),
	VidId [int])
	
	INSERT @FactExpertCriterion ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group], FedCode, OidCode, VidId)
	
	VALUES ('',1,53,'',2,1,'01.01.2022',NULL,2,'---s_tip ( marker )= 2
---s_tip2 (type) = 56
---s_osn(reasonid) = NULL
---s_sum (amount)= 0.00
---s_sum2= 0.00
---s_com  (comment)- Случаи летального исхода до приезда скорой медицинской помощи 
select distinct e.ZmedicalEventId
FROM FactTerritoryAccount a --счета        
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId    
   --and a.Destination=38000  ---????
   and p.AccountId = @AccountID 
inner join factperson pe on pe.PersonId=p.PersonalId  
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]
inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
left join v009 v on v.Id=ze.Result
where v.IDRMP= 411','56.Случаи летального исхода до приезда скорой медицинской помощи','56.Случаи летального исхода до приезда скорой медицинской помощи','56.Случаи летального исхода до приезда скорой медицинской помощи',1,0.00,4,1.00,9,2,'','13931575-C552-40F6-ABAC-508946226FD4',56)
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '13931575-C552-40F6-ABAC-508946226FD4' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '13931575-C552-40F6-ABAC-508946226FD4')--[Description] LIKE '003K.00.0501%' ) 	
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
		[OidCode],
		[VidId]
	)

	SELECT * from @FactExpertCriterion
	END
	

EXEC [dbo].[versionUpdate] 691
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