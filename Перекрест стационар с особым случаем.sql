if OBJECT_ID('ztemp_stacionar') is not null drop table ztemp_stacionar
GO
--declare @p1 int = 20530
DECLARE @year INT = 2023
DECLARE @month INT = 12

SELECT zsl_id, sl_id, D3_PID, t_pol.DATE_1, t_pol.DATE_2, t_pol.OS_SLUCH_REGION
INTO ztemp_stacionar
FROM(
SELECT zsl.id zsl_id, sl.ID sl_id, pa.ID D3_PID, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION
            FROM D3_ZSL_OMS zsl
            JOIN D3_SL_OMS sl on sl.d3_zslid=zsl.id
            JOIN D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
            JOIN D3_PACIENT_OMS AS pa ON pa.id = zsl.D3_PID            
WHERE zsl.USL_OK = 3 AND sc.[YEAR] = @year AND sc.[MONTH] = @month 
            AND zsl.OS_SLUCH_REGION IS NOT NULL
) AS t_pol
JOIN 
(
SELECT pv.FAM, pv.IM, pv.OT, pv.DR, sl.DATE_Z_1, sl.DATE_Z_2
FROM D3_ZSL_OMS AS sl
JOIN D3_PACIENT_oms AS pv ON pv.ID = sl.D3_PID
INNER JOIN D3_SCHET_OMS AS s ON s.ID = sl.D3_SCID AND s.[YEAR] = @year AND s.[MONTH] = @month 
WHERE sl.USL_OK IN (1, 2)) AS t_stac ON t_stac.FAM = t_pol.FAM AND t_stac.IM = t_pol.IM AND t_stac.OT = t_pol.OT AND t_stac.DR = t_pol.DR
WHERE CAST(t_pol.DATE_1 AS DATE) BETWEEN CAST(dateadd(day,0,t_stac.DATE_Z_1) AS DATE) AND CAST(t_stac.DATE_Z_2 AS DATE)

-- CAST(t_pol.DATE_1 AS DATE) < CAST(t_stac.DATE_2  AS DATE) and CAST(t_pol.DATE_2  AS DATE) > CAST(t_stac.DATE_2  AS DATE)
 --t_pol.DATE_1>t_stac.DATE_1 and t_pol.DATE_1<t_stac.DATE_2--втб

--DELETE FROM D3_SL_OMS
--WHERE ID IN (SELECT sl_id FROM ztemp_stacionar)

--DELETE FROM D3_ZSL_OMS
--WHERE ID IN (SELECT zsl_id FROM ztemp_stacionar)

--DELETE FROM D3_PACIENT_OMS
--WHERE ID IN (SELECT D3_PID FROM ztemp_stacionar)

UPDATE dzo SET EXP_COMENT = 'Перекрест стационар с особым случаем ' + cast(tz.OS_SLUCH_REGION AS NVARCHAR(2)) + ' ' + CONVERT(NVARCHAR(10), DATE_1,110)
--SELECT 'Перекрест стационар с особым случаем ' + cast(tz.OS_SLUCH_REGION AS NVARCHAR(2)) + ' ' + CONVERT(NVARCHAR(10), DATE_1,110)
	FROM D3_ZSL_OMS AS dzo
	JOIN ztemp_stacionar tz ON dzo.ID = tz.zsl_id
WHERE id IN (
		SELECT Zsl_id
		FROM ztemp_stacionar)