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
		AND( d.DIAG10 IN ('I27.0', 'I27.2', 'I27.8', 'I50.0', 'I50.1', 'I50.9', 'I51.4', 'I69.0','I69.1','I69.2','I69.3','I69.4','I67.8', 'I65.2',
'Z95.0', 'Z95.1', 'Z95.2', 'Z95.3', 'Z95.4','Z95.5', 'Z95.8', 'Z95.9') OR
d.DIAG10 BETWEEN 'I05' AND 'I05.9' OR
d.DIAG10 BETWEEN 'I06' AND 'I06.9' OR
d.DIAG10 BETWEEN 'I07' AND 'I07.9' OR
d.DIAG10 BETWEEN 'I08' AND 'I08.9' OR
d.DIAG10 BETWEEN 'I09' AND 'I09.9' OR

d.DIAG10 BETWEEN 'I10' AND 'I10.9' OR 
d.DIAG10 BETWEEN 'I11' AND 'I11.9' OR 
d.DIAG10 BETWEEN 'I12' AND 'I12.9' OR 
d.DIAG10 BETWEEN 'I13' AND 'I13.9' OR 
d.DIAG10 BETWEEN 'I15' AND 'I15.9' OR
d.DIAG10 BETWEEN 'I20' AND 'I20.9' OR
d.DIAG10 BETWEEN 'I21' AND 'I21.9' OR
d.DIAG10 BETWEEN 'I22' AND 'I22.9' OR
d.DIAG10 BETWEEN 'I23' AND 'I23.9' OR
d.DIAG10 BETWEEN 'I24' AND 'I24.9' OR
d.DIAG10 BETWEEN 'I25' AND 'I25.9' OR
d.DIAG10 BETWEEN 'I26' AND 'I26.9' OR
d.DIAG10 BETWEEN 'I28' AND 'I28.9' OR
d.DIAG10 BETWEEN 'I33' AND 'I33.9' OR
d.DIAG10 BETWEEN 'I34' AND 'I34.9' OR
d.DIAG10 BETWEEN 'I35' AND 'I35.9' OR
d.DIAG10 BETWEEN 'I36' AND 'I36.9' OR
d.DIAG10 BETWEEN 'I37' AND 'I37.9' OR
d.DIAG10 BETWEEN 'I38' AND 'I38.9' OR
d.DIAG10 BETWEEN 'I39' AND 'I39.9' OR
d.DIAG10 BETWEEN 'I40' AND 'I40.9' OR
d.DIAG10 BETWEEN 'I41' AND 'I41.9' OR
d.DIAG10 BETWEEN 'I42' AND 'I42.9' OR
d.DIAG10 BETWEEN 'I44' AND 'I44.9' OR
d.DIAG10 BETWEEN 'I45' AND 'I45.9' OR
d.DIAG10 BETWEEN 'I46' AND 'I46.9' OR
d.DIAG10 BETWEEN 'I47' AND 'I47.9' OR
d.DIAG10 BETWEEN 'I48' AND 'I48.9' OR
d.DIAG10 BETWEEN 'I49' AND 'I49.9' OR
d.DIAG10 BETWEEN 'I51' AND 'I51.2' OR
d.DIAG10 BETWEEN 'I71' AND 'I71.9' OR
d.DIAG10 BETWEEN 'Q20' AND 'Q28.9' OR

d.DIAG10 BETWEEN 'E78' AND 'E78.9' 
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
		WHERE dso2.[YEAR] in (2023)
		--AND (dso2.NSCHET LIKE '%+' OR dso2.[MONTH] = 8)
		--AND dso2.SchetType IN ('C','H')	
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
		WHERE dso2.[YEAR] in (2023)
		AND dso2.SchetType IN ('DP','DO')	
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dzo.OS_SLUCH_REGION 
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr
