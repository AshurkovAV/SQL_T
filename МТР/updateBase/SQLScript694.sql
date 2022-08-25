

BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 693

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
---s_tip2 (type) = 77
---s_osn (reasonid) = NULL
---s_sum (amount)= 0.00
---s_sum2= 0.00
---s_com  (comment)- ѕерекрест стационара с другими услови¤ми
if object_id (''ztemp_stac'') is not null drop table ztemp_stac 
 select distinct ze.ZslMedicalEventId zid,
 a.TerritoryAccountId,
 p.Newborn novor,
 ze.AssistanceConditions usl_ok,
 p.INP,p.[InsuranceDocNumber],
 case when isnull(p.INP,'''')='''' then p.[InsuranceDocNumber] else isnull(p.INP,'''') end   enp,
    pe.PName im,
    pe.Surname fam,
    pe.Patronymic ot,
    pe.Birthday dr,
    ze.EventBeginZ1 date_z_1,
 ze.EventEndZ2 date_z_2,
 ze.AcceptPrice
 into ztemp_stac 
FROM FactTerritoryAccount a --счета        
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId 
inner join factperson pe on pe.PersonId=p.PersonalId           
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]
where ze.AssistanceConditions=1
and ze.AcceptPrice<>0
  

select distinct  e.ZmedicalEventId
--,
-- a.TerritoryAccountId,
-- p.Newborn novor,
-- ze.AssistanceConditions usl_ok,
-- isnull(p.INP,p.[InsuranceDocNumber]) enp,
--    pe.PName im,
--    pe.Surname fam,
--    pe.Patronymic ot,
--    pe.Birthday dr,
--    ze.EventBeginZ1 date_z_1,
-- ze.EventEndZ2 date_z_2,
-- ze.AcceptPrice
-- ,z.*
FROM FactTerritoryAccount a --счета        
inner JOIN [FactPatient] p on a.TerritoryAccountId = p.AccountId    
   --and a.Destination=38000  ---????
   and   p.AccountId = @AccountID
           --and ( a.EconomicDate between ''20210601'' and ''20211231'' ) 
inner join factperson pe on pe.PersonId=p.PersonalId           
inner JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]
inner join ZFactMedicalEvent AS e ON ze.ZslMedicalEventId = e.ZslMedicalEventId
 
--------по енп---------------------------------------------------
left join     ztemp_stac z on
z.enp=case when isnull(p.INP,'''')='''' then p.[InsuranceDocNumber] else isnull(p.INP,'''') end  
and z.novor=p.Newborn
and (
(ze.EventBeginZ1 between z.date_z_1 and z.date_z_2
and ze.EventBeginZ1<>z.date_z_1
and ze.EventBeginZ1<>z.date_z_2)
or
(ze.EventEndZ2 between z.date_z_1 and z.date_z_2
and ze.EventEndZ2<>z.date_z_1
and ze.EventEndZ2<>z.date_z_2)

  )
-----------------------------------------------------------------------------
----по фио др------------------------------------------------------------------
left join     ztemp_stac z1 on
isnull(pe.PName,'''') =isnull(z1.im,'''')
and isnull(pe.Surname,'''') = isnull(z1.fam,'''')
and isnull(pe.Patronymic,'')=isnull(z1.ot,'')
and pe.Birthday=z1.dr
and z1.novor=p.Newborn
and (
(ze.EventBeginZ1 between z1.date_z_1 and z1.date_z_2
and ze.EventBeginZ1<>z1.date_z_1
and ze.EventBeginZ1<>z1.date_z_2)
or
(ze.EventEndZ2 between z1.date_z_1 and z1.date_z_2
and ze.EventEndZ2<>z1.date_z_1
and ze.EventEndZ2<>z1.date_z_2)

  )
----------------------------------------------------------------------------
where ze.AssistanceConditions<>1
and ze.AcceptPrice<>0
and
(z.zid is not null or z1.zid is not null)
  

','77.Перекрест стационара с другими условиями','77.Перекрест стационара с другими условиями','77.Перекрест стационара с другими условиями',1,0.00,4,0.00,9,2,'','763DA62E-4971-4E6A-ACBB-19FBC9F3B4A0',56)
	
	DELETE FROM FactExpertCriterion WHERE OidCode = '763DA62E-4971-4E6A-ACBB-19FBC9F3B4A0' --[Description] LIKE '003K.00.0501%'
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = '763DA62E-4971-4E6A-ACBB-19FBC9F3B4A0')--[Description] LIKE '003K.00.0501%' ) 	
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

EXEC [dbo].[versionUpdate] 694
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
