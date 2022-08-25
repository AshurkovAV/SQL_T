BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 647

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0540_Метод ВМП не соответствует основному диагнозу
--DECLARE @AccountID INT =24172
SELECT distinct z.ZmedicalEventId--,fp.AccountId , fp.externalid,z.HighTechAssistanceType,HighTechAssistanceMethod,m1.idds,v19.[DIAG],v19.[DATEBEG],v19.[DATEEND]

  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId  
           
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId 
  join FactPerson pe on pe.PersonId=fp.PersonalId
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 join m001 m1 on m1.Id=z.DiagnosisGeneral
 left join f003 f3 on f3.Id=zfme.ReferralOrganization 
 left join v019 v19 on v19.[IDHM]=HighTechAssistanceMethod and z.EventEnd between v19.[DATEBEG] and v19.[DATEEND]
 where  zfme.AssistanceType=32
 and (CHARINDEX(m1.idds,v19.[DIAG])=0 and CHARINDEX(left(m1.idds,3),v19.[DIAG])=0 )
 and fp.AccountId=@AccountID 

','003K.00.0540_Метод ВМП не соответствует основному диагнозу','003K.00.0540_Метод ВМП не соответствует основному диагнозу','Метод ВМП не соответствует основному диагнозу',1,0.00,4,1.00,9,2,'003K.00.0540','7B395675-3F7D-47D7-8276-8BAEE5490277')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '7B395675-3F7D-47D7-8276-8BAEE5490277' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '7B395675-3F7D-47D7-8276-8BAEE5490277')--[Description] LIKE '003K.00.0501%' ) 	
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


EXEC [dbo].[versionUpdate] 648
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



