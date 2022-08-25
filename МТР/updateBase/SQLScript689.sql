BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 688

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
---s_tip2 (type)  = 52 
---s_osn (reasonid) = NULL
---s_sum (amount)= 0.00
---s_sum2= 0.00
---s_com (comment)- Повторные обращения по одному и тому же заболеванию в АПП
if object_id (''ztemp_app_mee'') is not null drop table ztemp_app_mee  
 select distinct ze.ZslMedicalEventId zid,
 a.TerritoryAccountId,
 e.ZmedicalEventId,
 p.Newborn novor,
 ze.AssistanceConditions usl_ok,
 case when isnull(p.INP,'''')='''' then p.[InsuranceDocNumber] else isnull(p.INP,'''') end  enp,
    pe.PName im,
    pe.Surname fam,
    pe.Patronymic ot,
    pe.Birthday dr,
    ze.EventBeginZ1 date_z_1,
 ze.EventEndZ2 date_z_2,
 e.ProfileCodeId,
 m.IDDS,
 ze.AcceptPrice
 into ztemp_app_mee 
FROM FactTerritoryAccount a --счета        
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId 
inner join factperson pe on pe.PersonId=p.PersonalId           
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
left join [globalAccountType] gl on gl.TypeCode=a.type
inner join localF001 ter on ter.OKATO = a.Source 
left join m001 m on m.Id=e.DiagnosisGeneral
where ze.AssistanceConditions=3
and e.Pcel=''3.0''
and ze.AcceptPrice<>0
and not 
  (
   (m.IDDS between ''O10'' and ''O16.z'')
   or 
   (m.IDDS between ''O20'' and ''O29.z'')
   or
   (m.IDDS between ''O30'' and ''O48.z'')
   or
   (m.IDDS between ''O98'' and ''O99.z'')
   or
   (m.IDDS between ''Z00'' and ''Z99.z'')
  )
  

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
   and a.TerritoryAccountId=@AccountID 
           --and ( a.EconomicDate between ''20210601'' and ''20211231'' ) 
inner join factperson pe on pe.PersonId=p.PersonalId           
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
left join [globalAccountType] gl on gl.TypeCode=a.type
inner join localF001 ter on ter.OKATO = a.Source 
left join m001 m on m.Id=e.DiagnosisGeneral
where ze.AssistanceConditions=3
and e.Pcel=''3.0''
and ze.AcceptPrice<>0
and not 
  (
   (m.IDDS between ''O10'' and ''O16.z'')
   or 
   (m.IDDS between ''O20'' and ''O29.z'')
   or
   (m.IDDS between ''O30'' and ''O48.z'')
   or
   (m.IDDS between ''O98'' and ''O99.z'')
   or
   (m.IDDS between ''Z00'' and ''Z99.z'')
  )
  

and (
EXISTS (SELECT *
from ztemp_app_mee  z
where z.enp=case when isnull(p.INP,'''')='''' then p.[InsuranceDocNumber] else isnull(p.INP,'''') end 
and z.novor=p.Newborn
and z.IDDS=m.IDDS
and z.ProfileCodeId=e.ProfileCodeId
and ze.ZslMedicalEventId <>z.ZmedicalEventId
and abs(datediff(day, ze.EventEndZ2, z.date_z_1)) between 0 and 14
)  
or 
EXISTS (SELECT *
from ztemp_app_mee  z
where 
isnull(pe.PName,'''') =isnull(z.im,'''')
and isnull(pe.Surname,'''') = isnull(z.fam,'''')
and isnull(pe.Patronymic,'''')=isnull(z.ot,'''')
and pe.Birthday=z.dr
and z.novor=p.Newborn
and z.IDDS=m.IDDS
and z.ProfileCodeId=e.ProfileCodeId
and ze.ZslMedicalEventId <>z.ZmedicalEventId
and abs(datediff(day, ze.EventEndZ2, z.date_z_1)) between 0 and 14
)  )
','52.Повторные обращения по одному и тому же заболеванию в АПП','52.Повторные обращения по одному и тому же заболеванию в АПП','52.Повторные обращения по одному и тому же заболеванию в АПП',1,0.00,4,1.00,9,2,'','1D962318-E7CA-4B10-B78B-7F29496EFF37',52)
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '1D962318-E7CA-4B10-B78B-7F29496EFF37' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '1D962318-E7CA-4B10-B78B-7F29496EFF37')--[Description] LIKE '003K.00.0501%' ) 	
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

EXEC [dbo].[versionUpdate] 689
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