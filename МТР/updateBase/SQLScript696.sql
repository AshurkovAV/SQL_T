

BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 695


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
	
	VALUES ('',1,NULL,'',3,1,'01.01.2022',NULL,2,'---s_tip ( marker ) = 3
---s_tip2  (type)= 82
---s_osn (reasonid)= NULL
---s_sum (amount)= 0.00
---s_sum2= 0.00
---s_com  (comment) -Возникновение при оказании медицинской помощи застрахованному лицу в медицинской организации нового заболевания или состояния, входящего в другой класс МКБ-10
select distinct e.ZmedicalEventId
--,
 --a.TerritoryAccountId,p.ExternalId,count(distinct e.ZmedicalEventId)
 --e.ZmedicalEventId,
 --p.Newborn novor,
 --ze.AssistanceConditions usl_ok,
 --isnull(p.INP,p.[InsuranceDocNumber]) enp,
 --   pe.PName im,
 --   pe.Surname fam,
 --   pe.Patronymic ot,
 --   pe.Birthday dr,
 --   ze.EventBeginZ1 date_z_1,
 --ze.EventEndZ2 date_z_2,
 --e.ProfileCodeId,
 --m.IDDS,
 --ze.AcceptPrice
FROM FactTerritoryAccount a --счета        
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId    
   --and a.Destination=38000  ---????
   and   p.AccountId = @AccountID
           --and ( a.EconomicDate between ''20210601'' and ''20211231'' ) 
inner join factperson pe on pe.PersonId=p.PersonalId           
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
left join [globalAccountType] gl on gl.TypeCode=a.type
inner join localF001 ter on ter.OKATO = a.Source 
left join m001 m on m.Id=e.DiagnosisGeneral
where ze.AssistanceConditions=1
and ze.AcceptPrice<>0     
group by 
ze.ZslMedicalEventId ,a.TerritoryAccountId,p.ExternalId
having count(distinct e.ZmedicalEventId)>1
and count(distinct left (m.idds,1))>1
  
','82.Возникновение при оказании медицинской помощи застрахованному лицу в медицинской организации нового заболевания или состояния, входящего в другой класс МКБ-10','82.Возникновение при оказании медицинской помощи застрахованному лицу в медицинской организации нового заболевания или состояния, входящего в другой класс МКБ-10','82.Возникновение при оказании медицинской помощи застрахованному лицу в медицинской организации',1,0.00,4,0.00,9,2,'','D7A6BC97-E25F-4D24-B684-09199531CCE7',56)
	
	DELETE FROM FactExpertCriterion WHERE OidCode = 'D7A6BC97-E25F-4D24-B684-09199531CCE7' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'D7A6BC97-E25F-4D24-B684-09199531CCE7')--[Description] LIKE '003K.00.0501%' ) 	
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

EXEC [dbo].[versionUpdate] 696
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

