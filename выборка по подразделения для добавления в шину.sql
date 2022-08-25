SELECT 
[LPUFullName],
 [LPUShortName],
   [SystemType]
      ,[WSDLRef]
      ,[District]
      ,[Our]
      ,CAST([ExternaLpulID] AS NVARCHAR(10)) + cast(ROW_NUMBER() OVER(ORDER BY [ExternaLpulID] ASC) AS NVARCHAR(3)) [ExternaLpulID]
      ,[UseDoctorReferal]
      ,[AgeGroup]
      ,[OID]
      ,[IsActive]
      ,[BindingName]
      ,[z_order]
      ,[WSDLRef_v2]
      ,[SubscriptionEnabled]
      ,[NewOID]
      ,[DepartmentName]
      ,[PARequestEnabled]
      ,[IsCtoView]     
FROM(
SELECT 
fm.depart_name + ' ' + org.RECIEVER [LPUFullName],
fm.depart_name + ' ' + org.LABEL [LPUShortName],
 '8B00BDB8-6B00-4988-87BE-6824F8C80BF7'  [SystemType]
      ,'http://192.168.46.8:42023/?wsdl'[WSDLRef]
      ,2[District]
      ,0[Our]
      ,org.CODE [ExternaLpulID]
      ,0[UseDoctorReferal]
      ,0[AgeGroup]
      ,fm.depart_oid [OID]
      ,1[IsActive]
      ,'BasicHttpBinding'[BindingName]
      ,0[z_order]
      ,'http://192.168.46.8:42023/?wsdl'[WSDLRef_v2]
      ,0[SubscriptionEnabled]
      ,fm.depart_oid [NewOID]
      ,fm.depart_name + ' ' + org.LABEL [DepartmentName]
      ,1 [PARequestEnabled]
      ,1[IsCtoView]    

FROM PL_SUBJ AS ps
JOIN SPECIALISATION AS s ON ps.SPECIALISATION_ID = s.SPECIALISATION_ID
JOIN meddep m ON m.MEDECINS_ID = ps.MEDECINS_ID
LEFT JOIN (SELECT * FROM fm_dep_frmo fm  WHERE mo_oid IN (SELECT IEMK_OID FROM fm_org WHERE FM_ORG_ID = 1) )fm ON fm.FM_DEP_FRMO_ID = m.FM_DEP_FRMO_ID
CROSS JOIN (SELECT * FROM fm_org WHERE FM_ORG_ID = 1)  org   
WHERE ps.FP_ACCESS = 1 AND ps.SPECIALISATION_ID IS NOT NULL 
	  AND s.NSI_SPECIALISATION_ID IS NOT NULL AND ps.ARCHIVE != 1 --AND fm.depart_oid IS NOT NULL
) AS t
GROUP BY [LPUFullName],
 [LPUShortName],
   [SystemType]
      ,[WSDLRef]
      ,[District]
      ,[Our]
      ,[ExternaLpulID]
      ,[UseDoctorReferal]
      ,[AgeGroup]
      ,[OID]
      ,[IsActive]
      ,[BindingName]
      ,[z_order]
      ,[WSDLRef_v2]
      ,[SubscriptionEnabled]
      ,[NewOID]
      ,[DepartmentName]
      ,[PARequestEnabled]
      ,[IsCtoView]     