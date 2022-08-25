BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 683




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
	
	VALUES ('',1,222,'',1,1,'01.01.2022',NULL,2,'--declare @AccountID int = 1
  ------003K.00.0410 ZL_LIST/ZAP/Z_SL/SL/DATE_1
   --Ошибка фиксируется, если USL_OK<>4, 
   --и в реестре счета совпадают: 
   --дата начала лечения, 
   --дата окончания лечения,
   --условия оказания медицинской помощи,
   --признак новорожденного,
   --код медицинской специальности,
   --профиль медицинской помощи,
   --ФИО и дата рождения пациента,
   --за исключением оказания в один день амбулаторных посещений и отдельных медицинских услуг (КТ и МРТ).  
  with z as (
 SELECT distinct  
 ROW_NUMBER() OVER (PARTITION BY pe.PName,pe.Surname,pe.Patronymic,pe.Birthday,e.EventBegin,e.EventEnd,p.Newborn,ProfileCodeId ,SpecialityCodeV021,ze.AssistanceConditions,ze.AcceptPrice
 ORDER BY ze.ZslMedicalEventId desc) rn, 
 ROW_NUMBER() OVER (PARTITION BY isnull(p.INP,p.[InsuranceDocNumber]) ,e.EventBegin,e.EventEnd,p.Newborn,ProfileCodeId ,SpecialityCodeV021,ze.AssistanceConditions,ze.AcceptPrice
 ORDER BY ze.ZslMedicalEventId desc) rn1, 
 ze.ZslMedicalEventId zid,
 a.TerritoryAccountId,
 e.ZmedicalEventId,
 p.Newborn novor,
 ze.AssistanceConditions usl_ok,
 p.INP enp,
    pe.PName im,
    pe.Surname fam,
    pe.Patronymic ot,
    pe.Birthday dr,
    p.[InsuranceDocNumber],
    e.EventBegin date_1,
 e.EventEnd date_2,
 e.SpecialityCodeV021,
 e.ProfileCodeId,
 ze.AcceptPrice
 ,ze.AssistanceType
 --,ze.*
 FROM FactTerritoryAccount a --счета
    inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId 
    inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]           
    inner join FactPerson pe on pe.PersonId=p.PersonalId       
    INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
    left join ZFactSank mec on mec.ZmedicalEventId = e.ZmedicalEventId 
    left join [ZFactExternalRefuse] sank on sank.ZslMedicalEventId=ze.ZslMedicalEventId 
 WHERE  ze.PaymentMethod<>28
 and  p.AccountId = @AccountID
 and ze.AssistanceConditions<>4
 --and ze.AcceptPrice <>0
 --and a.Source<>''38000''
 --and e.ProfileCodeId not in (63,85,86,87,88,89,90,171)
 )
 select distinct ZmedicalEventId
 from z 
 where (rn>1 or rn1>1)


    --ROW_NUMBER() OVER (PARTITION BY v.FAM, v.IM, v.OT, v.DR, v.PROFIL ORDER BY v.p_cel25 desc) rn,
 ','1.10.2 - дублирование случаев оказания медицинской помощи в одном реестре по DATE_1','1.10.2 - дублирование случаев оказания медицинской помощи в одном реестре по DATE_1','1.10.2 - дублирование случаев оказания медицинской помощи в одном реестре по DATE_1',1,0.00,4,1.00,9,3,'','C69CFEF6-CA2C-4DEF-9296-8549C209453D')
	
	DELETE FROM FactExpertCriterion WHERE OidCode = 'C69CFEF6-CA2C-4DEF-9296-8549C209453D' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'C69CFEF6-CA2C-4DEF-9296-8549C209453D')--[Description] LIKE '003K.00.0501%' ) 	
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



EXEC [dbo].[versionUpdate] 684
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