BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		 
EXEC [dbo].[versionСheck] 607

SET IDENTITY_INSERT [dbo].[FactExpertCriterion] ON 

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [FactExpertCriterionID], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(N'2019-11-01 00:00:00.000' AS DateTime), NULL, 2, N'--002K.00.0630
--при диагнозе C81.0<=DS1<C97 код схема только "нет"
          
--DECLARE @AccountID  INT=24287
SELECT distinct sl.ZmedicalEventId
--p.AccountId,p.externalid, a.date,lp.codesh
FROM FactTerritoryAccount a
JOIN FactPatient AS p ON a.TerritoryAccountId=p.AccountId
JOIN ZslFactMedicalEvent AS zsl ON zsl.PatientId = p.PatientId and p.AccountId=@AccountID
JOIN [ZFactMedicalEvent] sl ON sl.ZslMedicalEventId=zsl.ZslMedicalEventId
join m001 m1 on m1.Id=sl.DiagnosisGeneral
left join ZFactMedicalEventOnk onk on onk.ZmedicalEventId=sl.ZmedicalEventId
left join ZFactMedicalServicesOnk ou on ou.ZmedicalEventOnkId=onk.ZmedicalEventOnkId
left join [ZFactAnticancerDrug] lp on lp.[ZMedicalServiceOnkId]=ou.ZmedicalServicesOnkId
where 
     ( m1.idds  between ''C81.0'' and ''C97.z'')
  and lp.codesh not like ''нет''
     -- DS_ONK=1 или C00.0<=DS1<D10или (DS1=D70 и (C00.0<=DS2<C81 или DS2=C97))
     --and a.date>=''20191201''
     --and a.Source<>38000 and year(a.date)=2019
     --and (zsl.[AssistanceConditions]=4 or 
     --sl.disp=1)
', N'002K.00.0630_при диагнозе C81.0<=DS1<C97 код схема только "нет"', N'002K.00.0630_при диагнозе C81.0<=DS1<C97 код схема только "нет"', N'при диагнозе C81.0<=DS1<C97 код схема только "нет"', 1, 0.0000, 4, 1.0000, 415, 9, 2)

SET IDENTITY_INSERT [dbo].[FactExpertCriterion] OFF

EXEC [dbo].[versionUpdate] 608
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