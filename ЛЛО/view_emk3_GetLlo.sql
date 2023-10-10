 CREATE VIEW [dbo].view_emk3_GetLlo
 AS 
	/* ИНФОРМАЦИЯ О организациии*/
     SELECT (
               SELECT fo.IEMK_OID
               FROM   FM_ORG AS fo
               WHERE  fo.FM_ORG_ID = 1
           )                              AS MO_OID
           
           
           
           --информация о случае
          ,dgp.MOTCONSU_ID                AS MOTCONSU_ID
          ,CONVERT(
               VARCHAR(17)
              ,REPLACE(
                   (
                       CONVERT(VARCHAR(10) ,dgp.DATE_CONSULTATION ,112) + CONVERT(VARCHAR(5) ,CONVERT(TIME ,dgp.DATE_CONSULTATION))
                   )
                  ,':'
                  ,''
               ) + '+0300'
           )                              AS EffectiveTime_Value
           ,dgp.DATE_CONSULTATION
           ,m.EMK3_SEND_DATE
           -- информация о пациенте
          ,ISNULL(p.pat_idx_EXTERNAL_ID, p.KRN_GUID )                        AS PATIENTS_ID
          ,REPLACE(REPLACE(p.SNILS, '-',''), ' ', '')                        AS SNILS_PATIENTS
          ,LTRIM(RTRIM(UPPER(p.NOM)))     AS PATIENTS_NOM
          ,LTRIM(RTRIM(UPPER(p.PRENOM)))  AS PATIENTS_PRENOM
          ,LTRIM(RTRIM(UPPER(p.PATRONYME))) AS PATIENTS_PATRONYME
          ,CASE 
                WHEN p.POL = 0 THEN '1'
                WHEN p.POL = 1 THEN '2'
           END                            AS PATIENTS_POL_CODE
          ,CASE 
                WHEN p.POL = 0 THEN 'Мужской'
                WHEN p.POL = 1 THEN 'Женский'
           END                            AS PATIENTS_POL
          ,CONVERT(VARCHAR(10) ,p.NE_LE ,112) AS BirthTime_Value
          
          /* данные об организции*/
          ,(
               SELECT fo.ORGN
               FROM   FM_ORG AS fo
               WHERE  fo.FM_ORG_ID = 1
           )                              AS ORG_OGRN
          ,(
               SELECT fo.LABEL
               FROM   FM_ORG AS fo
               WHERE  fo.FM_ORG_ID = 1
           )                              AS ORG_NAME
          ,(
               SELECT fo.MAIN_PHONE
               FROM   FM_ORG AS fo
               WHERE  fo.FM_ORG_ID = 1
           )                              AS ORG_PHONE
          ,(
               SELECT fo.LN_ADDRESS
               FROM   FM_ORG AS fo
               WHERE  fo.FM_ORG_ID = 1
           )                              AS ADDRESS_ORG
          ,CONVERT(
               VARCHAR(17)
              ,REPLACE(
                   (
                       CONVERT(VARCHAR(10) ,dgp.KRN_MODIFY_DATE ,112) + CONVERT(VARCHAR(5) ,CONVERT(TIME ,dgp.KRN_MODIFY_DATE))
                   )
                  ,':'
                  ,''
               ) + '+0300'
           )                                                 AS AssignedAuthorTime_Value
          ,m.LEHAHIJ_VRAH                                    AS AUTHOR_ID
          ,REPLACE(REPLACE(med.SNILS, '-',''), ' ', '')     AS AUTHOR_SNILS
          ,nd_author.CODE_NSI_DOLZGNOST AS AUTHOR_DOLZGNOST_CODE
          ,nd_author.DOLZGNOST_MED_PERSONALA
                                        AS AUTHOR_DOLZGNOST_NAME
          ,LTRIM(RTRIM(UPPER(med.NOM)))   AS AUTHOR_NOM
          ,UPPER(
               CONVERT(
                   VARCHAR(40)
                  ,CASE 
                        WHEN LEN(
                                 LTRIM(
                                     RTRIM(SUBSTRING(med.PRENOM ,0 ,CHARINDEX(' ' ,med.PRENOM)))
                                 )
                             ) = 0 THEN med.PRENOM
                        ELSE (
                                 LTRIM(
                                     RTRIM(SUBSTRING(med.PRENOM ,0 ,CHARINDEX(' ' ,med.PRENOM)))
                                 )
                             )
                   END
               )
           )                              AS AUTHOR_PRENOM
          ,UPPER(
               CONVERT(
                   VARCHAR(40)
                  ,LTRIM(
                       RTRIM(
                           SUBSTRING(
                               med.PRENOM
                              ,CHARINDEX(' ' ,med.PRENOM) + 1
                              ,(LEN(med.PRENOM) + CHARINDEX(' ' ,med.PRENOM))
                           )
                       )
                   )
               )
           )                              AS AUTHOR_PATRONYME
           
           ,(
               SELECT m.MEDECINS_ID 
               FROM   MEDECINS m
               WHERE  m.SPECIALISATION like 'Главный врач' 
                     
                      
           )                              AS SIGNED_DOCTOR_ID
           
           
           ,(
               SELECT REPLACE(REPLACE(m.SNILS, '-',''), ' ', '') 
               FROM   MEDECINS m
               WHERE  m.SPECIALISATION like 'Главный врач' 
               
           )                              AS SIGNED_DOCTOR_SNILS
            , '4' as SIGNED_DOCTOR_ZAVEDUYSHII
           , 'главный врач (начальник) медицинской организации' as NAME_DOCTOR_ZAVEDUYSHII
           
           ,(
               SELECT LTRIM(RTRIM(UPPER(m.NOM))) 
               FROM   MEDECINS m
               WHERE  m.SPECIALISATION like 'Главный врач' 
               
           )                              AS DOCTOR_ZAVEDUYSHII_NOM
           
           ,(
               SELECT UPPER(
               CONVERT(
                   VARCHAR(40)
                  ,CASE 
                        WHEN LEN(
                                 LTRIM(
                                     RTRIM(SUBSTRING(m.PRENOM ,0 ,CHARINDEX(' ' ,m.PRENOM)))
                                 )
                             ) = 0 THEN m.PRENOM
                        ELSE (
                                 LTRIM(
                                     RTRIM(SUBSTRING(m.PRENOM ,0 ,CHARINDEX(' ' ,m.PRENOM)))
                                 )
                             )
                   END
               )
           ) 
               FROM   MEDECINS m
               WHERE  m.SPECIALISATION like 'Главный врач' 
               
           )                              AS DOCTOR_ZAVEDUYSHII_PRENOM
           
           ,(
               SELECT UPPER(
               CONVERT(
                   VARCHAR(40)
                  ,LTRIM(
                       RTRIM(
                           SUBSTRING(
                               m.PRENOM
                              ,CHARINDEX(' ' ,m.PRENOM) + 1
                              ,(LEN(m.PRENOM) + CHARINDEX(' ' ,m.PRENOM))
                           )
                       )
                   )
               )
           ) 
               FROM   MEDECINS m
               WHERE  m.SPECIALISATION like 'Главный врач' 
               
           )                              AS DOCTOR_ZAVEDUYSHII_PATRONYME
           
         /*,dgp.LICO_PRIDAVSHEE_YURIDICHE AS SIGNED_DOCTOR_ID
          ,m_legalauth.SNILS              AS SIGNED_DOCTOR_SNILS
          ,nd_yur.CODE_NSI_DOLZGNOST  AS SIGNED_DOCTOR_ZAVEDUYSHII
         ,nd_yur.DOLZGNOST_MED_PERSONALA AS NAME_DOCTOR_ZAVEDUYSHII
          ,LTRIM(RTRIM(UPPER(m_legalauth.NOM))) AS DOCTOR_ZAVEDUYSHII_NOM
          
          ,UPPER(
               CONVERT(
                   VARCHAR(40)
                  ,CASE 
                        WHEN LEN(
                                 LTRIM(
                                     RTRIM(SUBSTRING(m_legalauth.PRENOM ,0 ,CHARINDEX(' ' ,m_legalauth.PRENOM)))
                                 )
                             ) = 0 THEN m_legalauth.PRENOM
                        ELSE (
                                 LTRIM(
                                     RTRIM(SUBSTRING(m_legalauth.PRENOM ,0 ,CHARINDEX(' ' ,m_legalauth.PRENOM)))
                                 )
                             )
                   END
               )
           )                              AS DOCTOR_ZAVEDUYSHII_PRENOM
          ,UPPER(
               CONVERT(
                   VARCHAR(40)
                  ,LTRIM(
                       RTRIM(
                           SUBSTRING(
                               m_legalauth.PRENOM
                              ,CHARINDEX(' ' ,m_legalauth.PRENOM) + 1
                              ,(LEN(m_legalauth.PRENOM) + CHARINDEX(' ' ,m_legalauth.PRENOM))
                           )
                       )
                   )
               )
           )                              AS DOCTOR_ZAVEDUYSHII_PATRONYME*/
           /* информация о полисе*/
            ,(
               SELECT TOP 1 NOMER_POLISA
               FROM   DATA_INS_POLICIES_OMI
               WHERE  PATIENTS_ID            = dgp.PATIENTS_ID
                      AND IS_MAIN            = 1
                      AND DEYSTVUYUSCHIY     = 1
           )                              AS PATIENTS_NOMER_POLISA
          ,(
               SELECT TOP 1 fo.NSI_SMO_TFOMS_ID
               FROM   DATA_INS_POLICIES_OMI dipo
                      LEFT JOIN FM_ORG AS fo
                           ON  fo.FM_ORG_ID = dipo.SMO
               WHERE  dipo.PATIENTS_ID = dgp.PATIENTS_ID
                      AND dipo.IS_MAIN = 1
                      AND dipo.DEYSTVUYUSCHIY = 1
                      
           )                              AS STRAH_SMCODE
          ,(
               SELECT TOP 1 nst.NAM_SMOK
               FROM   DATA_INS_POLICIES_OMI dipo
                      LEFT JOIN FM_ORG AS fo
                           ON  fo.FM_ORG_ID = dipo.SMO
                      LEFT JOIN DLO_REESTR_SMO AS nst
                           ON  nst.ID = fo.NSI_SMO_TFOMS_ID
               WHERE  dipo.PATIENTS_ID = dgp.PATIENTS_ID
                      AND dipo.IS_MAIN = 1
                      AND dipo.DEYSTVUYUSCHIY = 1
           )                              AS ORG_NAME_STRAH
          ,(
               SELECT TOP 1 LEFT(nst.PHONE ,13)
               FROM   DATA_INS_POLICIES_OMI dipo
                      LEFT JOIN FM_ORG AS fo
                           ON  fo.FM_ORG_ID = dipo.SMO
                      LEFT JOIN DLO_REESTR_SMO  AS nst
                           ON  nst.ID = fo.NSI_SMO_TFOMS_ID
               WHERE  dipo.PATIENTS_ID = dgp.PATIENTS_ID
                      AND dipo.IS_MAIN = 1
                      AND dipo.DEYSTVUYUSCHIY = 1
           )                              AS STRAH_TEL
          ,(
               SELECT TOP 1 nst.ADDR_F
               FROM   DATA_INS_POLICIES_OMI dipo
                      LEFT JOIN FM_ORG AS fo
                           ON  fo.FM_ORG_ID = dipo.SMO
                      LEFT JOIN DLO_REESTR_SMO  AS nst
                           ON  nst.ID = fo.NSI_SMO_TFOMS_ID
               WHERE  dipo.PATIENTS_ID = dgp.PATIENTS_ID
                      AND dipo.IS_MAIN = 1
                      AND dipo.DEYSTVUYUSCHIY = 1
           )                              AS STRAH_ADRESS
          ,(
               SELECT TOP 1 LEFT(nst.SMOCOD ,2)
               FROM   DATA_INS_POLICIES_OMI dipo
                      LEFT JOIN FM_ORG AS fo
                           ON  fo.FM_ORG_ID = dipo.SMO
                      LEFT JOIN DLO_REESTR_SMO  AS nst
                           ON  nst.ID = fo.NSI_SMO_TFOMS_ID
               WHERE  dipo.PATIENTS_ID = dgp.PATIENTS_ID
                      AND dipo.IS_MAIN = 1
                      AND dipo.DEYSTVUYUSCHIY = 1
           )  
                                       AS Participant_SMOREGION
                                       
              /* информация о рецепте*/
              
              , rdl.SERIES AS SERIA_RECEPTA
              , rdl.NUMBER AS NOMER_RECEPTA  
              , sr.SROK_DEYST_NAME AS SROK_RECIPE
              , RECIPE_DLO.dbo.calculateRecipeExpirationDate(sr.SROK_DEYST_NAME, CAST (rdl.DATE_RECIPE AS DATE)) AS DATA_OKONCHANIE_RECIPE
              , c.CODE AS COD_DIAGNOZ
              , c.CODE + ' '+ C.DESCRIPTION  AS DIAGNOZ
               , c.DESCRIPTION  AS DIAGNOZ_NAME
              /* <!-- R [1..1] СЕКЦИЯ: Коды льгот (с кодированными элементами) -->**/
              , ds.STANDARD_INN + ' ' + ds.STANDARD_FORM+ ' '+ds.STANDARD_DOZE AS NAME_LEK
               , dbs.CODE AS KOD_LGOT
               , CASE   
           WHEN dbs.SOURCE  = 1  THEN  'Федеральный бюджет' 
            else 'Бюджет субъекта РФ' end AS 'ISTOCHNIK_FIN'
            , dbs.NAME AS 'NAME_LGOTA'
            , esklp.ei_count_potreb AS COUNT_EDIN
            --, dl.SMNN_CODE
            , esklp.smnn_code AS COD_SMNN
             , ESKLP.klp_code  
              , dvl.[PERCENT]   AS 'NAME_VID'  
               , dvl.ID             
                                   
          FROM   DATA_GRACE_PRESCRIPTION    AS dgp
           LEFT JOIN PATIENTS             AS p
                ON  p.PATIENTS_ID = dgp.PATIENTS_ID
           LEFT JOIN MOTCONSU             AS m
                ON  m.MOTCONSU_ID = dgp.MOTCONSU_ID
           LEFT JOIN MEDECINS             AS med
                ON  med.MEDECINS_ID = m.LEHAHIJ_VRAH
           LEFT JOIN SPECIALISATION       AS s
                ON  s.SPECIALISATION_ID = med.SPECIALISATION_ID
           LEFT JOIN NSI_DOLZGNOST        AS nd_author
                ON  nd_author.CODE_NSI_DOLZGNOST = s.CODE_NSI_DOLZGNOST
           LEFT JOIN MEDECINS             AS m_legalauth
           
                ON  m_legalauth.MEDECINS_ID = dgp.LICO_PRIDAVSHEE_YURIDICHE
                LEFT JOIN SPECIALISATION       AS sp
                ON  sp.SPECIALISATION_ID = m_legalauth.SPECIALISATION_ID
           LEFT JOIN NSI_DOLZGNOST        AS nd_yur
                ON  nd_yur.CODE_NSI_DOLZGNOST = sp.CODE_NSI_DOLZGNOST
              LEFT JOIN CIM10                AS c
                ON  c.CIM10_ID = dgp.DIAGNOZ_MKB_10
           LEFT JOIN RECIPE_DLO.dbo.RECIPE_DLO_LPU rdl
                ON  rdl.KRN_GUID = dgp.KRN_GUID COLLATE SQL_Latin1_General_CP1251_CI_AS
           LEFT JOIN RECIPE_DLO.dbo.DLO_MEDICAMENTS dl 
                 ON dl.DLO_LEKS_ID = rdl.LEK_SR 
          LEFT JOIN DLO_SMNN ds
                 ON ds.smnn_code = dl.SMNN_CODE COLLATE SQL_Latin1_General_CP1251_CI_AS
          LEFT JOIN RECIPE_DLO.dbo.SROK_DEYST_RECIPE sr
                 ON sr.SROK_DEYST_RESIPE = rdl.SROK_DEYST_RESIPE
          LEFT JOIN DLO_BEFENITS_COLLATION  AS kl
                 ON  kl.KOD_KAT  = COALESCE(KOD_KAT_LGOT, KOD_KAT_LGOT_H, '')
          LEFT JOIN DLO_BENEFIT_CODES dbs
                 ON dbs.ID = CASE   
                      WHEN rdl.REG_RECEPT = 0 THEN  kl.nsi_fed_id 
            else kl.nsi_reg_id end
           LEFT JOIN RECIPE_DLO.dbo.ESKLP esklp
               ON esklp.klp_code = dl.klp_code COLLATE SQL_Latin1_General_CP1251_CI_AS
           LEFT JOIN DLO_VIDY_LGOT dvl
                 ON dvl.ID_LGOTA = dbs.CODE  and dl.MEDICAMENT_TYPE_ID = dvl.MEDICAMENT_TYPE_ID 
           LEFT JOIN (SELECT * FROM DATA_INS_POLICIES_OMI WHERE IS_MAIN = 1 AND DEYSTVUYUSCHIY = 1) 
dipo ON dipo.PATIENTS_ID = p.PATIENTS_ID
     --WHERE
     ---- med.MEDECINS_ID = 2600263 AND 
     dl.SMNN_CODE is not null 
				  and dvl.ID_LGOTA is not null 
				  and rdl.STATUS_RESIPE=0 
				  and dbs.CODE is not null 
				  and dbs.NAME is not null 
     
     
     
   GO  
     
     GRANT INSERT ON [dbo].[view_emk3_GetLlo] TO [iemk_user]
GRANT SELECT ON [dbo].[view_emk3_GetLlo] TO [iemk_user]
GRANT ALTER ON [dbo].[view_emk3_GetLlo] TO [iemk_user]
GRANT CONTROL ON [dbo].[view_emk3_GetLlo] TO [iemk_user]
