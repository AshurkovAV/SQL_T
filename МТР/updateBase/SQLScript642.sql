BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 641

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
	
	VALUES ('',1,53,'',1,1,'01.11.2019',NULL,2,'--003K.00.0501
--DECLARE @AccountID INT =24172
--003K.00.0501_Несоответствие специальности виду оказываемой медицинской помощи
----VIDPOM={12, 13, 31}
--Значение PRVS не должно входить в множество {100, 101, 206, 207, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281, 284}
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where ( v21.IDSPEC  IN (100, 101, 206, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281) 
AND zsl.AssistanceType IN (12, 13, 31) )','003K.00.0501_Несоответствие специальности виду оказываемой медицинской помощи{100, 101, 206, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281}','003K.00.0501_Несоответствие специальности виду оказываемой медицинской помощи {100, 101, 206, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281}','Несоответствие специальности виду оказываемой медицинской помощи',1,0.00,4,1.00,9,2,'003K.00.0501','E7A655FF-C9E4-472A-BBE4-78DFD7E79489')
	
	DELETE FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE [Description] LIKE '003K.00.0501%' ) 	
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


EXEC [dbo].[versionUpdate] 642
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



