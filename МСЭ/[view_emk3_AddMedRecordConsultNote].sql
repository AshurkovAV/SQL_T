

/* для разборки скрипта, потом можно убрать*/
ALTER VIEW [dbo].[view_emk3_AddMedRecordConsultNote]
AS
SELECT     TOP (100)
                          (SELECT     TOP (1) IEMK_OID
                            FROM          dbo.FM_ORG
                            WHERE      (FM_ORG_ID = 1)) AS IdLpu, PAT.KRN_GUID AS IdPatientMis, MOT.MOTCONSU_ID AS IdCaseMis, CAST(MOT.DATE_CONSULTATION AS DATE) 
                      AS CreationDate,
                          (SELECT     CAST(N'' AS xml ).value('xs:base64Binary(sql:column("plain_text"))', 'varchar(max)') AS encoded_value
                            FROM          (SELECT     CAST('Медицинский документ ' + CONVERT(varchar(19), MOT.DATE_CONSULTATION, 121) AS varbinary(MAX)) AS plain_text) AS tmp) 
                      AS Base64binary, 'text/plain' AS MimeType, VD.PHYSICAL_PATH + '\' + LET.FOLDER + '\' + LET.FileName AS Url, MED.NOM AS FamilyName,
                          (SELECT     SUBSTRING(MED.PRENOM, 0, CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS GivenName,
                          (SELECT     SUBSTRING(MED.PRENOM, CHARINDEX(' ', MED.PRENOM), LEN(MED.PRENOM) + CHARINDEX(' ', MED.PRENOM)) AS Expr1) AS MiddleName, 
                      MED.KRN_GUID AS IdPersonMis, '223' AS IdDocumentType, MED.SYS_SNILS AS DocN, 'ПФР' AS ProviderName,
                          (SELECT     TOP (1) IEMK_OID
                            FROM          dbo.FM_ORG AS FM_ORG_1
                            WHERE      (FM_ORG_ID = 1)) AS Expr1, SPEC.Nsi_specialisation_ID AS IdSpeciality, SPEC.DOLZGNOST AS IdPosition, (CASE WHEN isnull(DOC.Description, '') 
                      = '' THEN 'Медицинский документ ' + CONVERT(varchar(19), MOT.DATE_CONSULTATION, 121) ELSE DOC.Description END) AS Header
FROM         dbo.MOTCONSU AS MOT WITH (nolock) LEFT OUTER JOIN
                      dbo.DATA_AMBULAT_PATIENT_COUPON AS DAPC ON DAPC.MOTCONSU_ID = MOT.MOTCONSU_EV_ID LEFT OUTER JOIN
                      dbo.PATIENTS AS PAT ON PAT.PATIENTS_ID = MOT.PATIENTS_ID LEFT OUTER JOIN
                      dbo.MEDECINS AS MED ON MED.MEDECINS_ID = MOT.LEHAHIJ_VRAH LEFT OUTER JOIN
                      dbo.SPECIALISATION AS SPEC ON SPEC.SPECIALISATION_ID = MED.SPECIALISATION_ID LEFT OUTER JOIN
                      dbo.LETTERS AS DOC ON DOC.MOTCONSU_ID = MOT.MOTCONSU_ID LEFT OUTER JOIN
                      dbo.DATA_GENERAL_EXAM AS DGE ON DGE.MOTCONSU_ID = MOT.MOTCONSU_ID LEFT OUTER JOIN
                          (SELECT     Letters_ID, PATIENTS_ID, Date_Consultation, FileName, Description, Rubrics_ID, D_Type, MOTCONSU_ID, VIRTUAL_DISKS_ID, FOLDER, 
                                                   KRN_CREATE_DATE, KRN_CREATE_USER_ID, KRN_MODIFY_DATE, KRN_MODIFY_USER_ID, KRN_CREATE_DATABASE_ID, 
                                                   KRN_MODIFY_DATABASE_ID, KRN_GUID, TEMPLATE_ID, APPROVE_AUTO_CREATED, PUBLISHED, APPROVE_STATUS
                            FROM          dbo.LETTERS
                            WHERE      (D_Type = 1)) AS LET ON LET.MOTCONSU_ID = MOT.MOTCONSU_ID LEFT OUTER JOIN
                      dbo.VIRTUAL_DISKS AS VD ON VD.VIRTUAL_DISKS_ID = LET.VIRTUAL_DISKS_ID
WHERE     (MOT.PUBLISHED = 1) AND (MOT.REC_STATUS = 'A')
ORDER BY IdCaseMis DESC



GO


