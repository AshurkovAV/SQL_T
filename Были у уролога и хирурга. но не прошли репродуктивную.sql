DROP TABLE ztemp_02012024
DROP TABLE ztemp_zavod0910

SELECT distinct t.*
INTO ztemp_02012024
FROM(
	SELECT dpo.FAM, dpo.im,dpo.ot,dpo.DR, 
	
	    dbo.GROUP_CONCAT_DS(DISTINCT dso2.DS1,     N' , ', 1)DS1, 
		dbo.GROUP_CONCAT_DS(DISTINCT convert(NVARCHAR(10), dzo.DATE_Z_1, 102), N' , ', 1)DATE_Z_1,
		MAX(convert(NVARCHAR(10), dzo.DATE_Z_1, 102)) maxdate,
		dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID,  N' , ', 1)LPU_ID, 
		dbo.GROUP_CONCAT_DS(DISTINCT ysme.NameWithID,  N' , ', 1)NameWithID
	FROM D3_SCHET_OMS AS dso
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso2.IDDOKT
	WHERE dso.[YEAR] = 2024
	AND dso2.PROFIL IN(108,112)
	AND dpo.W = 1
	AND year(dpo.DR) BETWEEN 1975 AND 2005
	GROUP BY dpo.FAM, dpo.im,dpo.ot,dpo.DR) AS t 

LEFT JOIN(

		SELECT 
			dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) dr 
			
		FROM D3_ZSL_OMS AS dzo
			JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
					JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%сдан%'
						LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
							LEFT JOIN D3_SANK_OMS AS dso3 ON dso3.D3_ZSLID = dzo.ID
		WHERE  dso2.[MONTH] IN (1,2,3,4,5,6,7, 8,9) 
		AND dso2.[YEAR] = 2024
		AND dso2.SchetType = 'DD') AS t1 ON t1.FAM = t.FAM AND t1.im = t.im AND t1.ot = t.ot AND t1.DR = t.DR
WHERE t1.FAM is NULL


DROP TABLE zt

SELECT tt.*, t.tel--, ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
		INTO zt
		FROM ztemp_02012024 tt 
			LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
			
SELECT DISTINCT z.*
INTO ztemp_zavod0910
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p 
							ON p.‘амили€ = fam
							AND p.»м€ = im
							AND p.ќтчество = ot
WHERE p.‘амили€ IS NOT NULL
	AND maxdate< '20240701'


----смотрим где он был за послдение 2 мес€ца т.к. осмотр у уролога был давно	
SELECT *
FROM ztemp_zavod0910 t
	JOIN(
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION, 
				dbo.GROUP_CONCAT_DS(DISTINCT convert(NVARCHAR(10), dzo.DATE_Z_1, 102), N' , ', 1)DATE_Z_1,
				dbo.GROUP_CONCAT_DS(DISTINCT ysme.NameWithID,  N' , ', 1)NameWithID
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
								LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
				WHERE dso2.[YEAR] IN (2024) AND dso2.[MONTH] IN (8,9) AND (dzo.PR_NOV =0 OR dzo.PR_NOV IS NULL)			
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR
	) AS t1 ON t1.FAM = t.fam AND t.IM = t1.IM AND t.ot = t1.OT AND t.dr = t1.DR