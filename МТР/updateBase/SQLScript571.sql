BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[versionСheck] 570

SET IDENTITY_INSERT [dbo].[FactExpertCriterion] ON
INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [FactExpertCriterionID], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000A9C800000000 AS DateTime), NULL, 2, N'--DECLARE @AccountId int=25117
SELECT slid
--t1.*, t2.etal_kol
FROM
(select shit,t.ExternalId,zslid,slid,ouid,t.code_sh, SUM(CASE WHEN n021.ID_LEKP=n21.ID_LEKP THEN 1 ELSE 0 END) AS real_kol
FROM 
( SELECT 
 DISTINCT a.TerritoryAccountId AS shit,ze.ZslMedicalEventId AS zslid, e.ZmedicalEventId AS slid,zso.ZmedicalServicesOnkId AS ouid,zd.RegNum,
 zd.CodeSh AS code_sh, p.ExternalId
 --p.AccountId, p.ExternalId, zso.ServicesOnkTypeId, zd.RegNum, zd.CodeSh  
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
         AND p.AccountId=@AccountId        
    --and a.Destination=38000
    AND a.Date >= ''20190101''
 INNER JOIN FactPerson AS fp ON fp.PersonId = p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
       -- AND ze.[AssistanceConditions]  IN (1,2)
         
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId
 JOIN  ZFactMedicalEventOnk o ON o.ZmedicalEventId = e.ZmedicalEventId
  JOIN ZFactMedicalServicesOnk AS zso ON zso.ZmedicalEventOnkId = o.ZMedicalEventOnkId --онко услуги
           AND zso.ServicesOnkTypeId IN (2,4)
 LEFT  JOIN ZFactAnticancerDrug AS zd ON zd.ZMedicalServiceOnkId = zso.ZmedicalServicesOnkId -- лек препарат
  ) t
  JOIN [dbo].[N021] n021 ON n021.CODE_SH=t.CODE_SH AND n021.ID_LEKP=t.REGNUM
  LEFT JOIN [dbo].[N021] n21 ON n21.CODE_SH=t.CODE_SH 
GROUP BY shit,zslid,slid,ouid, t.code_sh, t.ExternalId ) t1
 JOIN 
(SELECT  CODE_SH, COUNT(id_LEKP) etal_kol
 FROM [dbo].[N021] n021
GROUP BY  CODE_SH
) T2 ON T1.code_sh=t2.CODE_SH
WHERE real_kol<>etal_kol', N'некорректно выполнена схема (кол-во препаратов не соответствует схеме лечения)', N'некорректно выполнена схема (кол-во препаратов не соответствует схеме лечения)', N'некорректно выполнена схема', 1, 0.0000, 4, 1.0000, 274, 7, 2)
SET IDENTITY_INSERT [dbo].[FactExpertCriterion] OFF
               
EXEC [dbo].[versionUpdate] 571
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