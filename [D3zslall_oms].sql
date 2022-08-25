ALTER VIEW [dbo].[D3zslall_oms]
AS
 SELECT 
       oie.KRN_GUID AS [ID_PAC]
      ,[FAM]
      ,[IM]
      ,[OT]
      ,CASE WHEN [W]=0 THEN 1 ELSE 2 END AS W
      ,[DR]     
      ,CASE WHEN [FAM_P] = '' THEN NULL ELSE [FAM_P] END [FAM_P]  
      ,CASE WHEN [IM_P] = '' THEN NULL ELSE [IM_P] END [IM_P] 
      ,CASE WHEN [OT_P] = '' THEN NULL ELSE [OT_P] END [OT_P]        
      ,[W_P]
      ,[DR_P]
      ,CASE WHEN [MR] = '' THEN NULL ELSE [MR] END [MR]      
      ,CAST(od.CODE AS INT) AS [DOCTYPE]
      ,[DOCSER]
      ,[DOCNUM]
      ,CASE WHEN oip.[SNILS] = '' THEN NULL ELSE oip.[SNILS] END [SNILS_P]
      ,CASE WHEN [OKATOG] = '' THEN NULL ELSE [OKATOG] END [OKATOG]  
      ,CASE WHEN [OKATOP] = '' THEN NULL ELSE [OKATOP] END [OKATOP]        
      ,oie.OMI_POLICY_TYPES_ID AS [VPOLIS]
      ,CASE WHEN oie.[SPOLIS] = '' THEN NULL ELSE oie.[SPOLIS] END [SPOLIS]
      ,oie.[NPOLIS]
      ,NULL AS [ST_OKATO]
      ,fo.CODE_OMS AS SMO
      ,fo.ORGN [SMO_OGRN]
      ,[SMO_OK]
      ,fo.SHORT_LABEL AS [SMO_NAM]
      ,NULL AS [INV]
      ,NULL AS [MSE]
      ,[NOVOR]
      ,[VNOV_D]      
      ,[PR_NOV]
      ,NULL AS [VETERAN]      
      ,oip.PATIENTS_ID AS PATIENTS_ID_MIS
  
      ,oie.KRN_GUID AS [ZSL_ID]      
      ,oie.KRN_GUID AS[D3_PGID]
      , oie.MOTCONSU_EV_ID AS IDCASE       
      ,CASE WHEN ois.DATEUSL >= '20191010' THEN ov3.IDVMP
      	ELSE (SELECT TOP 1 pr FROM [EMK].[dbo].Reestr_V002  AS vv WHERE vv.IDPR = OMS_V002.IDPR) END AS [VIDPOM] --Вид медицинской помощи Справочник V008 
      ,CASE WHEN ois.DATEUSL >= '20191010' THEN oie.OMS_V014_ID
      	ELSE CASE WHEN SUBSTRING(OMS_CODE,11,1) = '3' AND MKB.CODE NOT LIKE 'Z%' THEN 2 ELSE CAST(oie.ED_AIDINGS_FORMS_ID AS INT) END END AS [FOR_POM]  
      ,NULL AS NPR_MO --Код МО, направившей на лечение (диагностику, консультацию, госпитализацию)
      ,NULL AS NPR_DATE --Дата направления на лечение (диагностику, консультацию, госпитализацию)
      ,NULL AS LPU --Код МО
      ,NULL AS [VBR] --Признак мобильной медицинской бригады 0 – нет; 1 – да.
      ,oie.BEGDATE AS [DATE_Z_1]
      ,oie.ENDDATE AS [DATE_Z_2]
      ,NULL AS [P_OTK]
      ,NULL AS [RSLT_D]
      ,NULL AS [KD_Z] --Продолжительность гопитализации (койко-дни/пациенто-дни)
      ,NULL AS [VNOV_M] --Вес при рождении
      ,CASE WHEN ois.DATEUSL >= '20191010' THEN ov5.IDRMP
      	ELSE CAST(ED_TREATMENT_RESULT_CODE AS INT) END AS [RSLT] --Результат обращения
      ,CASE WHEN ois.DATEUSL >= '20191010' THEN ov4.IDIZ 
      	ELSE CAST(ED_OUTCOMES_CODE AS INT ) END AS [ISHOD] --Исход заболевания
      ,NULL AS [OS_SLUCH]
      ,NULL AS [OS_SLUCH_REGION]      
      ,NULL AS [VB_P] -- Признак внутрибольничного перевода
      ,CASE WHEN fo.CODE_OMS LIKE '46%' AND ED_AIDINGS_FORMS_ID != 2 THEN 25 
	        WHEN                            ED_AIDINGS_FORMS_ID  = 2 THEN 29	 
       ELSE 25 END [IDSP] --Код способа оплаты медицинской помощи     
      ,ISNULL(oie.OMS_V006_ID, 3) AS [USL_OK]            
      ,1 AS [USERID]
      ,oie.OMI_INVOICES_ID
            
      ,oie.KRN_GUID AS [D3_ZSLGID]
      ,ois.KRN_GUID AS [SL_ID]      
      ,oie.VMP_KIND_ID AS [VID_HMP] --Вид высокотехнологичной медицинской помощи
      ,oie.ED_VMP_METHODS_ID AS [METOD_HMP] --Метод высокотехнологичной медицинской помощи
      ,CAST(301 AS NVARCHAR(3))AS [LPU_1] --Подразделение МО
      ,NULL AS  PODR --Код отделения
      ,OMS_V002.IDPR AS [PROFIL]
      ,(SELECT TOP 1 pr FROM [EMK].[dbo].Reestr_V002_with_child_profil  AS vv WHERE vv.[IDPR] = OMS_V002.IDPR) AS [DET]
      ,CASE WHEN ois.DATEUSL >= '20191010' THEN ov2.IDPC
      	ELSE
      CASE WHEN SUBSTRING(OMS_CODE,11,1) = '1' AND MKB.CODE NOT LIKE 'Z%' THEN '1.0'     
		 WHEN SUBSTRING(OMS_CODE,11,1) = '2' AND MKB.CODE LIKE 'Z%' THEN '2.1' 
		 WHEN SUBSTRING(OMS_CODE,11,1) = '3' AND MKB.CODE NOT LIKE 'Z%' THEN '1.1' ELSE 
		 	CASE WHEN MKB.CODE LIKE 'Z%' THEN '2.1' ELSE '1.0' END 
      END
      END AS [P_CEL]
      ,oie.oms_v027_id C_ZAB--Характер основного заболевания
      ,[NHISTORY] --Номер истории болезни/ талона амбулаторного пациента/ карты вызова скорой медицинской помощи
      ,NULL P_PER --Признак поступления/ перевода
      ,ois.DATEUSL AS [DATE_1]
      ,ois.DATEUSL AS [DATE_2]
      ,NULL AS [KD] --Продолжительность госпитализации (койко-дни/пациенто-дни)
      ,MKB1.CODE AS DS0 --Диагноз первичный
      ,MKB.CODE AS [DS1]--Диагноз основной       
      ,CASE WHEN oie.DN = 0 THEN 1 
     WHEN oie.DN = 1 THEN 2
     WHEN oie.DN = 2 THEN 3
     WHEN oie.DN = 3 THEN 4
     WHEN oie.DN = 4 THEN 6
     ELSE oie.DN END DN      
        ,CAST(oie.DS_ONK AS INT) AS DS_ONK
      --,[KSG_DKK]
      --,[SL_K]
      --,[IT_SL]
      --,[REAB]      
      ,ov.IDSPEC AS [PRVS]
      ,'V021' AS VERS_SPEC
      ,medecins.SNILS AS [IDDOKT]
      ,ois.ED_COL AS [ED_COL]      
      ,NULL AS [SUM_M]
      ,NULL AS [PROFIL_K]
      ,oie.OMI_INVOICES_EV_ID  
      ,CASE WHEN oion.OMI_INVOICES_EV_ID IS NOT NULL THEN 1 ELSE 0 END napr
      ,CASE WHEN oios.OMI_INVOICES_EV_ID IS NOT NULL THEN 1 ELSE 0 END onko
      ,CASE WHEN oiod.OMI_INVOICES_EV_ID IS NOT NULL THEN 1 ELSE 0 END diag
      ,NULL usl
      ,NULL cons
FROM OMI_INVOICES_PAT AS oip
JOIN OMI_INVOICES_EV AS oie ON oie.OMI_INVOICES_PAT_ID = oip.OMI_INVOICES_PAT_ID
JOIN OMI_INVOICES_SERV AS ois ON ois.OMI_INVOICES_EV_ID = oie.OMI_INVOICES_EV_ID
JOIN MEDECINS on MEDECINS.MEDECINS_ID = ois.MEDECINS_ID
LEFT JOIN FM_ORG AS fo ON oie.POLIS_SMO_ID = fo.FM_ORG_ID
LEFT JOIN OMI_DOCTYPE AS od ON oip.OMS_DOCTYPE_ID = od.OMS_DOCTYPE_ID
LEFT JOIN ED_TREATMENT_RESULTS ON ED_TREATMENT_RESULTS.ED_TREATMENT_RESULT_ID = oie.ED_TREATMENT_RESULT_ID
LEFT JOIN ED_OUTCOMES ON ED_OUTCOMES.ED_OUTCOMES_ID = oie.ED_OUTCOMES_ID
LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = oie.MOTCONSU_EV_ID AND dd.VID_ZABOLEVANIQ = 0 AND DD.N_LINE = 1
LEFT JOIN CIM10 MKB on MKB.CIM10_ID = oie.DS_MAIN
LEFT JOIN CIM10 MKB1 on MKB1.CIM10_ID = oie.DS_IN
LEFT JOIN FM_SERV on FM_SERV.FM_SERV_ID = ois.FM_SERV_ID
LEFT JOIN SPECIALISATION AS s ON s.SPECIALISATION_ID = oie.SPECIALISATION_ID
LEFT JOIN OMS_V021 AS ov ON ov.OMS_V021_ID = s.OMS_V021_ID
LEFT JOIN FM_DEP_PROF FM_DEP_PROF ON FM_DEP_PROF.FM_DEP_PROF_ID = oie.FM_DEP_PROF_ID 
LEFT JOIN OMS_V002 OMS_V002 ON OMS_V002.OMS_V002_ID = FM_DEP_PROF.OMS_V002_ID 
LEFT JOIN OMS_V025 AS ov2 ON oie.OMS_V025_ID = ov2.OMS_V025_ID
LEFT JOIN OMS_V008 AS ov3 ON oie.OMS_V008_ID = ov3.OMS_V008_ID
LEFT JOIN OMS_V012 AS ov4 ON oie.OMS_V012_ID = ov4.OMS_V012_ID
LEFT JOIN OMS_V009 AS ov5 ON oie.OMS_V009_ID = ov5.OMS_V009_ID
LEFT JOIN (SELECT OMI_INVOICES_ONKO_DIAG.OMI_INVOICES_EV_ID 
           FROM OMI_INVOICES_ONKO_DIAG 
           GROUP BY OMI_INVOICES_ONKO_DIAG.OMI_INVOICES_EV_ID) AS oiod ON oie.OMI_INVOICES_EV_ID = oiod.OMI_INVOICES_EV_ID
LEFT JOIN (SELECT OMI_INVOICES_ONKO_SLUCH.OMI_INVOICES_EV_ID
             FROM OMI_INVOICES_ONKO_SLUCH GROUP BY OMI_INVOICES_ONKO_SLUCH.OMI_INVOICES_EV_ID) AS oios ON oios.OMI_INVOICES_EV_ID = ois.OMI_INVOICES_EV_ID             
LEFT JOIN (SELECT OMI_INVOICES_ONKO_NAPR.OMI_INVOICES_EV_ID
             FROM OMI_INVOICES_ONKO_NAPR GROUP BY OMI_INVOICES_ONKO_NAPR.OMI_INVOICES_EV_ID) AS oion ON oion.OMI_INVOICES_EV_ID = oie.OMI_INVOICES_EV_ID
WHERE oie.SPECIALISATION_ID NOT IN (30,126,127,128,129,130,137,146, 187)
--AND oip.FAM = 'Тестов'
GO


