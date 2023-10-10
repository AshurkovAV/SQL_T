IF OBJECT_ID (N'dbo.ztemp_du03082023', N'U') IS NOT NULL  
DROP TABLE ztemp_du03082023
IF OBJECT_ID (N'dbo.ztemp_du_sl', N'U') IS NOT NULL  
DROP TABLE ztemp_du_sl

SELECT  ap.Fam, ap.Im, ap.Ot, ap.Dr, dbo.GROUP_CONCAT_DS(DISTINCT DIAG10, N' , ', 1) DS,
    CASE WHEN ysme.LPU_ID = 460006 THEN 'ЗАВОДСКАЯ' 
         WHEN ysme.LPU_ID = 460026 THEN 'СОЮЗНАЯ' 
    ELSE 'МО не определена' END gb,
	ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
INTO ztemp_du03082023
	FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
	INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
	LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = d.snils
WHERE ap.active=1 
		AND ap.prmo=460026 
		AND d.MO IN (460026, 460006) 
		AND ap.Ds IS NULL
		AND d.dateend IS NULL
		AND( d.DIAG10 IN ('I50.0', 'I50.1', 'I20.1','I20.8', 'I50.9', 'I20.9','I25.1','I25.2','I25.5', 'I25.6','I25.8','I25.9','I69.0','I69.1','I69.2','I69.3','I69.4','I67.8', 'I65.2') OR
		d.DIAG10 BETWEEN 'I10' AND 'I10.9' OR 
		d.DIAG10 BETWEEN 'I11' AND 'I11.9' OR 
		d.DIAG10 BETWEEN 'I12' AND 'I12.9' OR 
		d.DIAG10 BETWEEN 'I13' AND 'I13.9' OR 
		d.DIAG10 BETWEEN 'I15' AND 'I15.9' OR
		d.DIAG10 BETWEEN 'I48' AND 'I48.9' OR
		d.DIAG10 BETWEEN 'I47' AND 'I47.9' 
		) 
GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr, ysme.LPU_ID, ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-')


SELECT t.Fam, t.Im, t.Ot, t.Dr, t.DS, t.gb, addr, t.MOBIL_TELEFON, MIN(t.посещал)[посещал]
INTO ztemp_du_sl
FROM(
SELECT DISTINCT t_du.*, t.MOBIL_TELEFON,
CASE WHEN CHARINDEX(DS, t_p.DS1) IS NULL THEN 'не посещал' 
     WHEN CHARINDEX(DS, t_p.DS1) = 0 THEN 'посещал, но с другим МКБ'
     WHEN CHARINDEX(DS, t_p.DS1) = 1 THEN 'посещал'
     ELSE 'посещал' END [посещал] 
FROM ztemp_du03082023 AS t_du
LEFT JOIN (	
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR,  dso.DS1--, dzo.DATE_Z_1, dzo.DATE_Z_2, 
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] in (2018,2019,2020,2021,2022,2023)
		--AND (dso2.NSCHET LIKE '%+' OR dso2.[MONTH] = 8)
		AND dso2.SchetType IN ('C','H')	
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dso.DS1 
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr
LEFT JOIN telefon1 AS t ON t_du.FAM = t.NOM AND t_du.IM = t.PRENOM AND t_du.OT = t.PATRONYME AND t_du.DR = t.NE_LE 
) AS t
GROUP BY t.Fam, t.Im, t.Ot, t.Dr, t.DS, addr, t.gb, t.MOBIL_TELEFON

SELECT t_du.*,
CASE WHEN OS_SLUCH_REGION IS NOT NULL THEN (SELECT osd.NameWithID
                                              FROM OsobSluchDb AS osd WHERE osd.Id = OS_SLUCH_REGION) 
     ELSE 'не проходил Д и П' END [D P] 
FROM ztemp_du_sl AS t_du
LEFT JOIN (	
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] in (2018,2019,2020,2021,2022,2023)
		AND dso2.SchetType IN ('DP','DO')	
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dzo.OS_SLUCH_REGION 
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr
