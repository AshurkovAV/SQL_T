BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 689

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
	
	VALUES ('',1,53,'',2,1,'01.01.2022',NULL,2,'---s_tip( marker ) = 2
---s_tip2(type)  = 54 
---s_osn(reasonid) = NULL
---s_sum  (amount)= 0.00
---s_sum2= 0.00
---s_com  (comment)- Случаи с применением ХТ 
select distinct e.ZmedicalEventId
--,
 --a.TerritoryAccountId,
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
inner join factperson pe on pe.PersonId=p.PersonalId           
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
left  JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId  
left JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId
left join ZFactAnticancerDrug lp on lp.ZMedicalServiceOnkId=zso.ZmedicalServicesOnkId
left join  ZFactKsgKpg ksg on ksg. ZmedicalEventId=e.ZmedicalEventId 
where 
(
zso.ServicesOnkTypeId IN (2)
or
lp.CodeSh like ''sh%''
or
lp.CodeSh like ''gem%''
or
lp.CodeSh like ''%нет%''
or
left(ksg.Kksg ,4) in ( ''st19'',''ds19'',''st08'',''ds08'')

)','54.Случаи с применением ХТ','54.Случаи с применением ХТ','54.Случаи с применением ХТ',1,0.00,4,1.00,9,2,'','A2065FEC-DE81-448C-BFFF-AEF7F6C25C8F',54)
	
	DELETE FROM FactExpertCriterion WHERE OidCode = 'A2065FEC-DE81-448C-BFFF-AEF7F6C25C8F' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = 'A2065FEC-DE81-448C-BFFF-AEF7F6C25C8F')--[Description] LIKE '003K.00.0501%' ) 	
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


EXEC [dbo].[versionUpdate] 690
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