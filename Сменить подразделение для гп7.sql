DECLARE @dateStart DATETIME = '20221012'
DECLARE @periodAllowCreate INT = 14


SELECT distinct NULL AS AriaNumber, 
		NULL Comment,
		(SELECT COUNT(*) FROM [dbo].[pl_GetMedecinGridFunc2](pl_Subj_ID, @dateStart, 
		DATEADD(DAY, CASE WHEN PERIOD_ALLOW_CREATE > 14 THEN @periodAllowCreate ELSE ISNULL(PERIOD_ALLOW_CREATE, @periodAllowCreate) END, CAST(@dateStart AS DATETIME) - 1), 0) AS t WHERE EType = 0) CountFreeParticipantIE, 
		CAST(pl_Subj_ID AS NVARCHAR(50)) AS IdDoc,
		NULL NearestDate, 
		ps.NAME AS Name,
		NULL LastDate,
		(SELECT top 1 m.snils FROM MEDECINS AS m WHERE m.MEDECINS_ID = ps.MEDECINS_ID)Snils, ps.EXCHANGE_CODE,
		fm.FM_DEP_FRMO_ID
--UPDATE m SET FM_DEP_FRMO_ID=3295
FROM PL_SUBJ AS ps
		JOIN SPECIALISATION AS s ON ps.SPECIALISATION_ID = s.SPECIALISATION_ID
		JOIN meddep m ON m.MEDECINS_ID = ps.MEDECINS_ID
		JOIN (SELECT * FROM fm_dep_frmo fm  WHERE mo_oid IN ('1.2.643.5.1.13.13.12.2.46.4393') )fm ON fm.FM_DEP_FRMO_ID = m.FM_DEP_FRMO_ID		
	
		WHERE ps.FP_ACCESS = 1 
		--AND ps.SPECIALISATION_ID = @idSpesiality 
		--AND fm.depart_oid = @depart_oid
		AND s.CODE != 'COVID-19'
		AND s.NSI_SPECIALISATION_ID IS NOT NULL AND ps.ARCHIVE != 1
		
		3329
		
		
		
		SELECT *
		FROM fm_dep_frmo
		WHERE mo_oid = '1.2.643.5.1.13.13.12.2.46.4393'