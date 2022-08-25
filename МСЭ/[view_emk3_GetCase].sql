


 ALTER VIEW [dbo].[view_emk3_GetCase]
 AS
 SELECT NEWID()id,  PAT.PATIENTS_ID,      CAST
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
                          ETF.ED_TREATMENT_FORM_CODE AS IdCaseAidType, 1 AS IdPaymentType, (CASE WHEN DAPC.ED_OUTCOMES_ID IN (1, 12, 16) THEN 1 WHEN DAPC.ED_OUTCOMES_ID IN (2, 3, 6, 9, 13) 
                          THEN 2 WHEN DAPC.ED_OUTCOMES_ID IN (4, 7, 10, 14) THEN 3 WHEN DAPC.ED_OUTCOMES_ID IN (5, 8, 11, 15) THEN 4 WHEN DAPC.ED_OUTCOMES_ID IN (18) THEN 5 ELSE 1 END) AS IdCaseResult, 
                          MOT.REC_NAME AS Comment, PAT.KRN_GUID AS IdPatientMis, (CASE WHEN DAPC.VID_PRIEMA = 1 OR
                          DAPC.VID_PRIEMA = 20 THEN 1 WHEN DAPC.VID_PRIEMA = 13 THEN 2 WHEN DAPC.VID_PRIEMA = 11 THEN 3 WHEN DAPC.VID_PRIEMA = 16 THEN 4 WHEN DAPC.VID_PRIEMA = 2 THEN 5 ELSE 12 END) 
                          AS IdCasePurpose, ISNULL((CASE WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 3 OR
                         DAPC.ED_MED_PROVISION_CONDITIONS_ID = 4 THEN 2 WHEN DAPC.ED_MED_PROVISION_CONDITIONS_ID = 1 THEN 3 END), 2) AS IdCaseType, 
                          (CASE WHEN DAPC.ED_OUTCOMES_ID = 16 THEN 1 WHEN DAPC.ED_OUTCOMES_ID = 3 THEN 2 WHEN DAPC.ED_OUTCOMES_ID = 18 OR
                          DAPC.ED_OUTCOMES_ID = 2 OR
                          DAPC.ED_OUTCOMES_ID = 4 OR
                          DAPC.ED_OUTCOMES_ID = 5 THEN 3 ELSE 17 END) AS IdAmbResult, 1 AS IsActive,
                              (SELECT        TOP (1) IEMK_OID
                                FROM            dbo.FM_ORG
                                WHERE        (FM_ORG_ID = 1)) AS CaseDto_DoctorInCharge_IdLpu, SPEC.NSI_SPECIALISATION_ID AS CaseDto_DoctorInCharge_IdSpeciality, SPEC.DOLZGNOST AS CaseDto_DoctorInCharge_IdPosition, 
                          MED.NOM AS Person_HumanName_FamilyName,
                              (SELECT        SUBSTRING(MED.PRENOM, 0, CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Person_HumanName_GivenName,
                              (SELECT        SUBSTRING(MED.PRENOM, CHARINDEX(' ', MED.PRENOM), LEN(MED.PRENOM) + CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS Person_HumanName_MiddleName, 
                          223 AS Person_Documents_IdentityDocument_IdDocumentType, MED.SYS_SNILS AS Person_Documents_IdentityDocument_DocN, MOT.EMK3_SENDED,
                          case when mot.REMD_BodyPreparedReport IS NOT NULL THEN 'Осмотр врача' ELSE 'Нет документа' END REMD_BodyPreparedReport, 
                          mot.REMD_ECP_SIGN_DATA, mot.REMD_ECP_SIGN_DATA_ORG,
                          CASE WHEN mot.REC_NAME LIKE 'Направление на МСЭ%' THEN 'MSE' ELSE NULL END [MSE],
                          CASE WHEN mot.MSE_BodyPreparedReport IS NOT NULL THEN 'Направление на МСЭ' ELSE 'Нет документа' END MSE_BodyPreparedReport 
                          
                          ,SPEC.NAME specName
                          ,pat.NOM, PAT.PRENOM, pat.PATRONYME, PAT.POL, pat.NE_LE
                          ,CASE WHEN napr.DATA_W438_MSE_NAPRAV_ID IS NOT NULL THEN 'Есть наплавление на МСЭ' ELSE NULL END [MSE_N],
                          mot.MSE_BodyPreparedReport as MSE_BodyPreparedReport_1, mot.MSE_ECP_SIGN_DATA , mot.MSE_ECP_SIGN_DATA_ORG,
                          napr.MOTCONSU_ID AS MOTCONSU_ID_SLUCHAI_ZABOL
                          
                          
 FROM           
dbo.MOTCONSU AS MOT WITH (NOLOCK) LEFT OUTER JOIN
dbo.DATA_AMBULAT_PATIENT_COUPON AS DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID LEFT OUTER JOIN
 DATA_W438_MSE_NAPRAV napr ON napr.SLUCHAI_ZABOL = MOT.MOTCONSU_ID LEFT JOIN
dbo.ED_TREATMENT_FORM AS ETF ON ETF.ED_TREATMENT_FORM_ID = DAPC.ED_TREATMENT_FORM_ID LEFT OUTER JOIN
dbo.ED_LEVEL_ACCESS AS ELA ON ELA.ED_LEVEL_ACCESS_ID = MOT.UROVEN_DOSTUPA_K_SEMD LEFT OUTER JOIN
dbo.PATIENTS AS PAT ON PAT.PATIENTS_ID = MOT.PATIENTS_ID LEFT OUTER JOIN
dbo.MEDECINS AS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH LEFT OUTER JOIN
dbo.SPECIALISATION AS SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID LEFT OUTER JOIN
dbo.DATA_MOTCONSU_BILLDET AS DMB ON DMB.MOTCONSU_ID = MOT.MOTCONSU_ID
 WHERE-- mot.MOTCONSU_ID = 809347  --  MOT.EMK3_SEND_DATE IS NOT NULL AND MOT.EMK3_SENDED = 2 AND 
 --CAST ((SELECT        TOP (1) DATE_CONSULTATION
 --                                 FROM            (SELECT        MOTCONSU_EV_ID, MOTCONSU_ID, DATE_CONSULTATION, EV_DATE_CLOSE
 --                                                           FROM            dbo.MOTCONSU
 --                                                           WHERE        (EV_DATE_CLOSE IS NOT NULL)
 --                                                           GROUP BY MOTCONSU_EV_ID, MOTCONSU_ID, DATE_CONSULTATION, EV_DATE_CLOSE) AS SVOD
 --                                 WHERE        (MOTCONSU_EV_ID = MOT.MOTCONSU_EV_ID)) AS date) >= '20180401'
-- AND mot.REMD_ECP_SIGN_DATA_ORG IS NOT null
  --MED.SYS_SNILS ='15545345268' AND 
  --EV_DATE_CLOSE IS NOT NULL AND 
   (MOT.MOTCONSU_ID IN
                              (SELECT        MOTCONSU_ID
                                FROM            (SELECT        MOTCONSU_ID, MOTCONSU_EV_ID
                                                          FROM            dbo.MOTCONSU AS MOTCONSU_1
                                                          GROUP BY MOTCONSU_ID, MOTCONSU_EV_ID
                                                          HAVING         (COUNT(*) = 1)) AS E)) --AND (PAT.NOM = 'Ашурков') AND (MOT.REC_NAME LIKE '%Маз%при%')
 























GO


