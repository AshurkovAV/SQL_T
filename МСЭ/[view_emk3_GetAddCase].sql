/*	AND	(EMK3_SEND_DATE < MOT.KRN_MODIFY_DATE 
OR EMK3_SENDED IS NULL
OR EMK3_SENDED = 0)
AND MOT.MOTCONSU_EV_ID = 539
30.09.2020 ashur изменил idLpu подразделений
*/
ALTER VIEW [dbo].[view_emk3_GetAddCase]
AS

SELECT       CAST
                             ((SELECT        TOP (1) DATE_CONSULTATION
                                 FROM            (SELECT        MOTCONSU_EV_ID, MOTCONSU_ID, DATE_CONSULTATION, EV_DATE_CLOSE
                                                           FROM            dbo.MOTCONSU
                                                           WHERE        (EV_DATE_CLOSE IS NOT NULL)
                                                           GROUP BY MOTCONSU_EV_ID, MOTCONSU_ID, DATE_CONSULTATION, EV_DATE_CLOSE) AS SVOD
                                 WHERE        (MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID)) AS date) AS OpenDate, CAST
                             ((SELECT        TOP (1) EV_DATE_CLOSE
                                 FROM            (SELECT        MOTCONSU_EV_ID, MOTCONSU_ID, DATE_CONSULTATION, EV_DATE_CLOSE
                                                           FROM            dbo.MOTCONSU AS MOTCONSU_2
                                                           WHERE        (EV_DATE_CLOSE IS NOT NULL)
                                                           GROUP BY MOTCONSU_EV_ID, MOTCONSU_ID, DATE_CONSULTATION, EV_DATE_CLOSE) AS SVOD_1
                                 WHERE        (MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID)) AS date) AS CloseDate, MOT.MOTCONSU_ID AS HistoryNumber, MOT.MOTCONSU_ID AS IdCaseMis, MOT.MOTCONSU_ID, 
                         CASE WHEN ISNULL(ETF.ED_TREATMENT_FORM_CODE, '') = '' and ISNULL(DAPC.OMS_V008_ID, '') != ''
			THEN (CASE WHEN DAPC.OMS_V008_ID = 7 THEN '3'
			      WHEN DAPC.OMS_V008_ID = 6 then '1'
				  WHEN DAPC.OMS_V008_ID = 1 then '1'
				  WHEN DAPC.OMS_V008_ID = 2 then '2'
				  WHEN DAPC.OMS_V008_ID = 3 then '3'
				  ELSE '6' END) 
					ELSE 
					(CASE WHEN ISNULL(ETF.ED_TREATMENT_FORM_CODE, '') = '' 
					THEN 6 
					ELSE ETF.ED_TREATMENT_FORM_CODE END) END AS IdCaseAidType, 1 AS IdPaymentType, 2 AS Confidentiality, 2 AS DoctorConfidentiality, 2 AS CuratorConfidentiality,
                             (SELECT        TOP (1) IEMK_OID
                               FROM            dbo.FM_ORG
                               WHERE        (FM_ORG_ID = 1)) AS IdLpu, (CASE WHEN DAPC.ED_OUTCOMES_ID IN (1, 12, 16) THEN 1 WHEN DAPC.ED_OUTCOMES_ID IN (2, 3, 6, 9, 13) THEN 2 WHEN DAPC.ED_OUTCOMES_ID IN (4, 7, 10, 
                         14) THEN 3 WHEN DAPC.ED_OUTCOMES_ID IN (5, 8, 11, 15) THEN 4 WHEN DAPC.ED_OUTCOMES_ID IN (18) THEN 5 ELSE 1 END) AS IdCaseResult, MOT.REC_NAME AS Comment, 
                         PAT.KRN_GUID AS IdPatientMis, (CASE WHEN DAPC.VID_PRIEMA = 1 OR
                         DAPC.VID_PRIEMA = 20 THEN 1 WHEN DAPC.VID_PRIEMA = 13 THEN 2 WHEN DAPC.VID_PRIEMA = 11 THEN 3 WHEN DAPC.VID_PRIEMA = 16 THEN 4 WHEN DAPC.VID_PRIEMA = 2 THEN 5 ELSE 12 END) 
                         AS IdCasePurpose, (CASE WHEN ISNULL(DAPC.OMS_V006_ID, '') != ''
      THEN
			(CASE WHEN DAPC.OMS_V006_ID = 3 OR DAPC.OMS_V006_ID = 4 THEN 2
					WHEN DAPC.OMS_V006_ID = 1 THEN 3 ELSE 2 END)
				ELSE
			(CASE WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 3 OR DAPC.ED_MED_PROVISION_CONDITIONS_ID = 4 THEN 2
					WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 1 THEN 3 ELSE 2 END)
				END) AS IdCaseType,  --если пусто то ставим код 2 Амбулаторный случай
                         (CASE WHEN DAPC.ED_OUTCOMES_ID = 16 THEN 1 WHEN DAPC.ED_OUTCOMES_ID = 3 THEN 2 WHEN DAPC.ED_OUTCOMES_ID = 18 OR
                         DAPC.ED_OUTCOMES_ID = 2 OR
                         DAPC.ED_OUTCOMES_ID = 4 OR
                         DAPC.ED_OUTCOMES_ID = 5 THEN 3 ELSE 17 END) AS IdAmbResult, 1 AS IsActive,
                             fm.depart_oid  AS CaseDto_DoctorInCharge_IdLpu, SPEC.NSI_SPECIALISATION_ID AS CaseDto_DoctorInCharge_IdSpeciality, SPEC.DOLZGNOST AS CaseDto_DoctorInCharge_IdPosition, 
                         MED.DATA_ROGDENIQ AS DoctorInCharge_Person_BirthDate, MED.KRN_GUID AS DoctorInCharge_Person_IdPersonMis, MED.NOM AS Person_HumanName_FamilyName,
                             (SELECT        SUBSTRING(MED.PRENOM, 0, CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Person_HumanName_GivenName,
                             (SELECT        SUBSTRING(MED.PRENOM, CHARINDEX(' ', MED.PRENOM), LEN(MED.PRENOM) + CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Person_HumanName_MiddleName, 
                         223 AS Person_Documents_IdentityDocument_IdDocumentType, MED.SYS_SNILS AS Person_Documents_IdentityDocument_DocN, 'ПФР' AS Person_Documents_IdentityDocument_ProviderName,
                             fm.depart_oid  AS Authenticator_Doctor_IdLpu, SPEC.NSI_SPECIALISATION_ID AS Authenticator_Doctor_IdSpeciality, SPEC.DOLZGNOST AS Authenticator_Doctor_IdPosition, 
                         MED.DATA_ROGDENIQ AS Doctor_Person_BirthDate, MED.KRN_GUID AS Doctor_Person_IdPersonMis, MED.NOM AS Doctor_Person_HumanName_FamilyName,
                             (SELECT        SUBSTRING(MED.PRENOM, 0, CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Doctor_Person_HumanName_GivenName,
                             (SELECT        SUBSTRING(MED.PRENOM, CHARINDEX(' ', MED.PRENOM), LEN(MED.PRENOM) + CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Doctor_Person_HumanName_MiddleName, 
                         223 AS Doctor_Person_Documents_IdentityDocument_IdDocumentType, MED.SYS_SNILS AS Doctor_Person_Documents_IdentityDocument_DocN, 
                         'ПФР' AS Doctor_Person_Documents_IdentityDocument_ProviderName, 4 AS IdRole,
                             fm.depart_oid  AS Author_Doctor_IdLpu, SPEC.NSI_SPECIALISATION_ID AS Author_Doctor_IdSpeciality, SPEC.DOLZGNOST AS Author_Doctor_IdPosition, 
                         MED.DATA_ROGDENIQ AS Author_Doctor_Person_BirthDate, MED.KRN_GUID AS Author_Doctor_Person_IdPersonMis, MED.NOM AS Author_Doctor_Person_HumanName_FamilyName,
                             (SELECT        SUBSTRING(MED.PRENOM, 0, CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Author_Doctor_Person_HumanName_GivenName,
                             (SELECT        SUBSTRING(MED.PRENOM, CHARINDEX(' ', MED.PRENOM), LEN(MED.PRENOM) + CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Author_Doctor_Person_HumanName_MiddleName, 
                         223 AS Author_Doctor_Person_IdDocumentType, MED.SYS_SNILS AS Author_Doctor_Person_DocN, 'ПФР' AS Author_Doctor_Person_ProviderName,
                             fm.depart_oid  AS LegalAuthenticator_Doctor_IdLpu, SPEC.NSI_SPECIALISATION_ID AS LegalAuthenticator_Doctor_IdSpeciality, SPEC.DOLZGNOST AS LegalAuthenticator_Doctor_IdPosition, 
                         MED.DATA_ROGDENIQ AS LegalAuthenticator_Doctor_Person_BirthDate, MED.KRN_GUID AS LegalAuthenticator_Doctor_Person_IdPersonMis, MED.NOM AS LegalAuthenticator_Doctor_Person_FamilyName,
                             (SELECT        SUBSTRING(MED.PRENOM, 0, CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS LegalAuthenticator_Doctor_Person_GivenName,
                             (SELECT        SUBSTRING(MED.PRENOM, CHARINDEX(' ', MED.PRENOM), LEN(MED.PRENOM) + CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS LegalAuthenticator_Doctor_Person_MiddleName, 
                         223 AS LegalAuthenticator_Doctor_Person_IdDocumentType, MED.SYS_SNILS AS LegalAuthenticator_Doctor_Person_DocN, 'ПФР' AS LegalAuthenticator_Doctor_Person_ProviderName, 
                         MOT.DATE_CONSULTATION AS DateStart, MOT.DATE_CONSULTATION AS DateEnd, MOT.REC_NAME AS Steps_Comment, MOT.MOTCONSU_ID AS IdStepMis, 1 AS Steps_IdPaymentType, 
                         (CASE WHEN DMB.ED_RECEPTION_PLACE_ID = 1 THEN 1 WHEN DMB.ED_RECEPTION_PLACE_ID = 2 THEN 2 WHEN DMB.ED_RECEPTION_PLACE_ID = 3 THEN 4 WHEN DMB.ED_RECEPTION_PLACE_ID = 4 THEN
                          3 WHEN DMB.ED_RECEPTION_PLACE_ID = 5 THEN 5 ELSE 6 END) AS IdVisitPlace, 1 AS IdVisitPurpose, SPEC.NSI_SPECIALISATION_ID AS StepAmb_Doctor_IdSpecialit, 
                         SPEC.DOLZGNOST AS StepAmb_Doctor_IdPosition, MED.DATA_ROGDENIQ AS StepAmb_Doctor_BirthDate, MED.KRN_GUID AS StepAmb_Doctor_IdPersonMis, MED.NOM AS StepAmb_Doctor_FamilyName,
                             (SELECT        SUBSTRING(MED.PRENOM, 0, CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS StepAmb_Doctor_GivenName,
                             (SELECT        SUBSTRING(MED.PRENOM, CHARINDEX(' ', MED.PRENOM), LEN(MED.PRENOM) + CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS StepAmb_Doctor_MiddleName, 
                         223 AS StepAmb_Doctor_IdDocumentType, MED.SYS_SNILS AS StepAmb_Doctor_DocN, 'ПФР' AS StepAmb_Doctor_ProviderName, cast((case when DMB.VISIT_NUMBER = 0 THEN 1 when DMB.VISIT_NUMBER >= 1 THEN 2 ELSE 2 END)  AS NVARCHAR(2)) AS CaseVisitType,
                         napr.MOTCONSU_ID AS MOTCONSU_ID_SLUCHAI_ZABOL
FROM            dbo.MOTCONSU AS MOT WITH (NOLOCK) LEFT OUTER JOIN
                         dbo.DATA_AMBULAT_PATIENT_COUPON AS DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID LEFT OUTER JOIN
                          DATA_W438_MSE_NAPRAV napr ON napr.SLUCHAI_ZABOL = MOT.MOTCONSU_ID LEFT JOIN
                         dbo.ED_TREATMENT_FORM AS ETF ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID LEFT OUTER JOIN
                         
                         dbo.ED_LEVEL_ACCESS AS ELA ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD LEFT OUTER JOIN
                         dbo.PATIENTS AS PAT ON PAT.PATIENTS_ID = MOT.PATIENTS_ID LEFT OUTER JOIN
                         dbo.MEDECINS AS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH LEFT OUTER JOIN
                         dbo.SPECIALISATION AS SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID LEFT OUTER JOIN
                         dbo.DATA_MOTCONSU_BILLDET AS DMB ON DMB.MOTCONSU_ID = MOT.MOTCONSU_ID
                         JOIN (SELECT * FROM meddep WHERE ARCHIVE != 1) m ON m.MEDECINS_ID = med.MEDECINS_ID
LEFT JOIN (SELECT * FROM fm_dep_frmo fm  WHERE mo_oid IN (SELECT IEMK_OID FROM fm_org WHERE FM_ORG_ID = 1) )fm ON fm.FM_DEP_FRMO_ID = m.FM_DEP_FRMO_ID
--WHERE        (MOT.MOTCONSU_ID IN
--                             (SELECT        MOTCONSU_ID
--                               FROM            (SELECT        MOTCONSU_ID, MOTCONSU_EV_ID
--                                                         FROM            dbo.MOTCONSU AS MOTCONSU_1
--                                                         GROUP BY MOTCONSU_ID, MOTCONSU_EV_ID
--                                                         HAVING         (COUNT(*) = 1)) AS E)) AND (MOT.EV_CLOSE = 1) --AND (PAT.NOM = 'Ашурков') AND (MOT.REC_NAME LIKE '%Маз%при%')







GO


