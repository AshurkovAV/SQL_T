

BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 694


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
---s_tip2  (type) = 81
---s_osn  (reasonid)= NULL
---s_sum (amount) = 0.00
---s_sum2= 0.00
---s_com  (comment) -Случаи COVID с сопутствующими ССС заболеваниями
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
           --and ( a.EconomicDate between ''20210601'' and ''20211231'' ) 
inner join factperson pe on pe.PersonId=p.PersonalId           
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId] 
inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
left join [globalAccountType] gl on gl.TypeCode=a.type
inner join localF001 ter on ter.OKATO = a.Source 
left join m001 m on m.Id=e.DiagnosisGeneral
join  ZFactDs dss on dss.ZmedicalEventId = e.ZmedicalEventId
where ze.AssistanceConditions=1
and ze.AcceptPrice<>0
and m.IDDS like ''U%''
and  dss.DsType=2
and ( dss.Ds between ''I20'' and ''I25.z''
or 
dss.Ds between ''E10'' and ''E14.z''
or 
dss.Ds between ''C00'' and ''C97.z''
or 
dss.Ds between ''D00'' and ''D09.z''
or 
dss.Ds between ''D45'' and ''D47.z''
or 
dss.Ds between ''J40'' and ''J47.z''
----------
or 
dss.Ds between ''I60'' and ''I63.z''
or 
dss.Ds between ''G45'' and ''G46.z''
or 
dss.Ds LIKE ''I48.z''
--or 
-- dss.Ds LIKE ''I49.z''
or 
dss.Ds LIKE ''N18.z''
or 
dss.Ds between ''E65'' and ''E68.z''
or 
dss.Ds LIKE ''I87.z''
                  
)                     

  
','81.Случаи COVID с сопутствующими ССС заболеваниями','81.Случаи COVID с сопутствующими ССС заболеваниями','81.Случаи COVID с сопутствующими ССС заболеваниями',1,0.00,4,0.00,9,2,'','990A36C1-D11F-41B6-854C-47D7A6B942B3',56)
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '990A36C1-D11F-41B6-854C-47D7A6B942B3' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '990A36C1-D11F-41B6-854C-47D7A6B942B3')--[Description] LIKE '003K.00.0501%' ) 	
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

EXEC [dbo].[versionUpdate] 695
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

