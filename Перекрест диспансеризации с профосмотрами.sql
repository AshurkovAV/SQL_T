DECLARE @OsobSluch INT  = 47
if OBJECT_ID('ztemp_stacionar') is not null drop table ztemp_stacionar

declare @p_vd int = 23680
declare @p_po int = 23679
--SELECT t_pol.*--, t_stac.DATE_1, t_stac.DATE_2
SELECT zsl_id
INTO ztemp_stacionar
FROM(
	SELECT zsl.ID zsl_id, p.FAM, im, ot, CAST(p.DR AS DATE) dr, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1, 
	(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
	FROM [D3_ZSL_OMS] zsl
		JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
			LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 97) AS ds ON zsl.ID = ds.D3_ZSLID
	WHERE zsl.D3_SCID = @p_vd AND zsl.OS_SLUCH_REGION = 47 AND (p.PR_NOV IS NULL OR p.PR_NOV = 0)
            
) AS t_pol
JOIN 
(
	SELECT zsl.ID, p.FAM, im, ot, CAST(p.DR AS DATE) dr, p.SMO, CAST(zsl.DATE_Z_1 AS DATE)DATE_Z_1,  CAST(zsl.DATE_Z_2 AS DATE)DATE_Z_2,
	(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = ds.IDDOKT) AS doc
	FROM [D3_ZSL_OMS] zsl
		JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID
			LEFT JOIN (SELECT * FROM D3_SL_OMS AS ds WHERE ds.PROFIL = 97) AS ds ON zsl.ID = ds.D3_ZSLID
	WHERE zsl.D3_SCID = @p_po AND zsl.OS_SLUCH_REGION = 49) AS t_stac ON t_stac.FAM = t_pol.FAM AND t_stac.IM = t_pol.IM AND t_stac.OT = t_pol.OT AND t_stac.DR = t_pol.DR

WHERE CAST(t_pol.DATE_Z_1 AS DATE) BETWEEN CAST(dateadd(day,0,t_stac.DATE_Z_1) AS DATE) AND CAST(t_stac.DATE_Z_2 AS DATE)


UPDATE D3_ZSL_OMS SET D3_SCID = @p_vd, EXP_COMENT = 'Перекрест диспансеризации с профосмотром' 
WHERE id IN (
SELECT Zsl_id
FROM ztemp_stacionar)