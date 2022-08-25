DECLARE @p1 INT = 2119
DECLARE @pp1 INT = 2120

--Перекрест законченный случай - случай
UPDATE D3_ZSL_OMS SET D3_SCID = @pp1, MEK_COMENT = 'Перекрест законченный случай - случай'
WHERE ID IN (
SELECT sl.zsl_id
FROM(
select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL
            FROM D3_ZSL_OMS zsl
		    join D3_SL_OMS sl on sl.d3_zslid=zsl.id
            join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
            JOIN D3_PACIENT_OMS AS pa ON pa.id = zsl.D3_PID           
            where zsl.USL_OK = 3 and zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IS NULL AND sl.p_cel25 = '3.0'
) AS t_pol
JOIN (
	select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL
            FROM D3_ZSL_OMS zsl
		    join D3_SL_OMS sl on sl.d3_zslid=zsl.id
            join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
            JOIN D3_PACIENT_OMS AS pa ON pa.id = zsl.D3_PID           
            where zsl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.p_cel25 IN ( '1.0', '1.1') and zsl.D3_SCID = @p1 AND sc.year = 2018
) AS sl ON sl.FAM = t_pol.FAM AND sl.IM = t_pol.IM AND sl.OT = t_pol.OT AND sl.DR = t_pol.DR AND sl.DS1 = t_pol.DS1 AND sl.zsl_id <> t_pol.zsl_id AND sl.PROFIL = t_pol.PROFIL
WHERE  t_pol.DATE_2 = sl.DATE_2)

--/*******************************************
-- * Дубликат случай со случаем
-- *******************************************/
UPDATE D3_ZSL_OMS SET D3_SCID = @pp1, MEK_COMENT = 'Дубликат случай со случаем'
WHERE ID IN (
SELECT sl.zsl_id
FROM(
select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL
            FROM D3_ZSL_OMS zsl
		    join D3_SL_OMS sl on sl.d3_zslid=zsl.id
            join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
            JOIN D3_PACIENT_OMS AS pa ON pa.id = zsl.D3_PID           
            where zsl.USL_OK = 3 and zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IS NULL AND sl.p_cel25 = '1.0'
) AS t_pol
JOIN (
	select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL
            FROM D3_ZSL_OMS zsl
		    join D3_SL_OMS sl on sl.d3_zslid=zsl.id
            join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
            JOIN D3_PACIENT_OMS AS pa ON pa.id = zsl.D3_PID           
            where zsl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.p_cel25 IN ( '1.0') and zsl.D3_SCID = @p1 AND sc.year = 2018
) AS sl ON sl.FAM = t_pol.FAM AND sl.IM = t_pol.IM AND sl.OT = t_pol.OT AND sl.DR = t_pol.DR AND sl.DS1 = t_pol.DS1 AND sl.zsl_id <> t_pol.zsl_id AND sl.PROFIL = t_pol.PROFIL
WHERE  t_pol.DATE_2 = sl.DATE_2)

UPDATE D3_ZSL_OMS SET D3_SCID = @pp1, MEK_COMENT = 'Дубликат законченный случай - законченный случай '
WHERE ID IN (
SELECT sl.zsl_id
FROM(
select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, zsl.DATE_Z_1, zsl.DATE_Z_2, zsl.OS_SLUCH_REGION, sl.PROFIL
            FROM D3_ZSL_OMS zsl
		    join D3_SL_OMS sl on sl.d3_zslid=zsl.id
            join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
            JOIN D3_PACIENT_OMS AS pa ON pa.id = zsl.D3_PID           
            where zsl.USL_OK = 3 and zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IS NULL AND sl.p_cel25 = '3.0'
) AS t_pol
JOIN (
	select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, zsl.DATE_Z_1, zsl.DATE_Z_2, zsl.OS_SLUCH_REGION, sl.PROFIL
            FROM D3_ZSL_OMS zsl
		    join D3_SL_OMS sl on sl.d3_zslid=zsl.id
            join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
            JOIN D3_PACIENT_OMS AS pa ON pa.id = zsl.D3_PID           
            where zsl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL AND sl.p_cel25 IN ( '3.0') and zsl.D3_SCID = @p1 --AND sc.year = 2018
) AS sl ON sl.FAM = t_pol.FAM AND sl.IM = t_pol.IM AND sl.OT = t_pol.OT AND sl.DR = t_pol.DR AND sl.DS1 = t_pol.DS1 AND sl.zsl_id <> t_pol.zsl_id AND sl.PROFIL = t_pol.PROFIL
WHERE  t_pol.DATE_Z_1 = sl.DATE_Z_1 AND t_pol.DATE_Z_2 = sl.DATE_Z_2)