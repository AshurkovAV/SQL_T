



ALTER VIEW [dbo].[view_pix_GetPatient]
AS
SELECT        P.PATIENTS_ID, CAST(P.NE_LE AS DATE) AS BirthDate, P.NOM AS FamilyName, P.PRENOM AS GivenName, P.KRN_GUID AS IdPatientMIS, P.PATRONYME AS MiddleName, 
                         (CASE WHEN P.POL = 0 THEN 1 WHEN P.POL = 1 THEN 2 ELSE 3 END) AS Sex, P.SERIQ_DOKUMENTA AS DocS, P.PASPORT_N AS DocN, DIPO.NOMER_POLISA AS DocN1, P.SYS_SNILS AS DocN2, 
                         P.pat_idx_SENDED, ORG.SHORT_LABEL AS ProviderName1
FROM            dbo.PATIENTS AS P WITH (NOLOCK) LEFT OUTER JOIN
                             (SELECT        p.NOMER_POLISA, p.TIP_POLISA, p.PATIENTS_ID, p.SMO
                               FROM            dbo.DATA_INS_POLICIES_OMI AS p WITH (NOLOCK) INNER JOIN
                                                             (SELECT        PATIENTS_ID, MAX(DATA313_ID) AS DATA313_ID
                                                               FROM            dbo.DATA_INS_POLICIES_OMI WITH (NOLOCK)
                                                               WHERE        (IS_MAIN = 1) AND (DEYSTVUYUSCHIY = 1)                                                               
                                                               GROUP BY PATIENTS_ID) AS t ON t.DATA313_ID = p.DATA313_ID) AS DIPO ON DIPO.PATIENTS_ID = P.PATIENTS_ID LEFT OUTER JOIN
                         dbo.FM_ORG AS ORG WITH (NOLOCK) ON ORG.FM_ORG_ID = DIPO.SMO
--WHERE  p.KRN_GUID = '0420A147-7C29-44FA-A3C7-440445533496'



GO


