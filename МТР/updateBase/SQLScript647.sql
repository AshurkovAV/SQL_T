BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 646

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
	
	VALUES ('',1,53,'',1,1,'01.04.2020',NULL,2,'--003K.00.0530_����� ��� �� ������������� ���� ���
--DECLARE @AccountID INT =24172
SELECT distinct z.ZmedicalEventId--,fp.AccountId , fp.externalid,z.HighTechAssistanceType,HighTechAssistanceMethod,z.HighTechAssistanceType,v19.[IDHM]

  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zfme ON zfme.ZslMedicalEventId =z.ZslMedicalEventId  
           
  JOIN FactPatient AS fp ON fp.PatientId = zfme.PatientId 
  join FactPerson pe on pe.PersonId=fp.PersonalId
  join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  --join ZFactKsgKpg ksg on ksg.ZmedicalEventId=z.ZmedicalEventId
 left join f003 f3 on f3.Id=zfme.ReferralOrganization 
 left join v019 v19 on v19.[IDHM]=HighTechAssistanceMethod and z.EventEnd between v19.[DATEBEG] and v19.[DATEEND]
 where  zfme.AssistanceType=32
 and v19.[IDHM]<>HighTechAssistanceMethod
 and fp.AccountId=@AccountID 

','003K.00.0530_����� ��� �� ������������� ���� ���','003K.00.0530_����� ��� �� ������������� ���� ���','����� ��� �� ������������� ���� ���',1,0.00,4,1.00,9,2,'003K.00.0530','CE800910-A871-40F6-A86C-3E0610AA06B0')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = 'CE800910-A871-40F6-A86C-3E0610AA06B0' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'CE800910-A871-40F6-A86C-3E0610AA06B0')--[Description] LIKE '003K.00.0501%' ) 	
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


EXEC [dbo].[versionUpdate] 647
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



