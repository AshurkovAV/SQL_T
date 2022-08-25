DECLARE @p1 INT = 2071


UPDATE D3_ZSL SET D3_SCID = 2076, FLK_COMENT = 'ѕерекрест законченный случай - случай'
WHERE ID IN (
SELECT sl.zsl_id
FROM(
select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL
            FROM D3_ZSL zsl
		    join D3_SL sl on sl.d3_zslid=zsl.id
            join SCHET sc on zsl.D3_SCID = sc.ID
            JOIN PACIENT AS pa ON pa.id = zsl.D3_PID           
            where sl.USL_OK = 3 and zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IS NULL AND p_cel = '3.0'
) AS t_pol
JOIN (
	select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL, sc.MONTH
            FROM D3_ZSL zsl
		    join D3_SL sl on sl.d3_zslid=zsl.id
            join SCHET sc on zsl.D3_SCID = sc.ID
            JOIN PACIENT AS pa ON pa.id = zsl.D3_PID           
            where sl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL AND p_cel IN ( '1.3', '2.0') AND sc.year = 2019 AND sc.ID != @p1
) AS sl ON sl.FAM = t_pol.FAM AND sl.IM = t_pol.IM AND sl.OT = t_pol.OT AND sl.DR = t_pol.DR AND sl.DS1 = t_pol.DS1 AND sl.zsl_id <> t_pol.zsl_id AND sl.PROFIL = t_pol.PROFIL
WHERE  t_pol.DATE_2 = sl.DATE_2)-- as t on dz.id = t.zsl_id



--update dz SET FLK_COMENT = 'ƒубликат случай со случаем  id дубл€ - ' + cast(zsl1 as nvarchar(50)) + ' мес€ц - ' + cast(MONTH as nvarchar(50))
--from D3_ZSL dz
--join(
--SELECT t_pol.zsl_id, sl.zsl_id zsl1, MONTH
--FROM(
--select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL
--            FROM D3_ZSL zsl
--		    join D3_SL sl on sl.d3_zslid=zsl.id
--            join SCHET sc on zsl.D3_SCID = sc.ID
--            JOIN PACIENT AS pa ON pa.id = zsl.D3_PID           
--            where sl.USL_OK = 3 and zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IS NULL AND p_cel = '1.3'
--) AS t_pol
--JOIN (
--	select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.OS_SLUCH_REGION, sl.PROFIL, sc.MONTH
--            FROM D3_ZSL zsl
--		    join D3_SL sl on sl.d3_zslid=zsl.id
--            join SCHET sc on zsl.D3_SCID = sc.ID
--            JOIN PACIENT AS pa ON pa.id = zsl.D3_PID           
--            where sl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL AND p_cel IN ( '1.3') AND sc.year = 2018
--) AS sl ON sl.FAM = t_pol.FAM AND sl.IM = t_pol.IM AND sl.OT = t_pol.OT AND sl.DR = t_pol.DR AND sl.DS1 = t_pol.DS1 AND sl.zsl_id <> t_pol.zsl_id AND sl.PROFIL = t_pol.PROFIL
--WHERE  t_pol.DATE_2 = sl.DATE_2) as t on dz.id = t.zsl_id


--update dz SET FLK_COMENT = 'ƒубликат законченный случай - законченный случай - ' + cast(zsl1 as nvarchar(50)) + ' мес€ц - ' + cast(MONTH as nvarchar(50))
--from D3_ZSL dz
--join(
--SELECT t_pol.zsl_id, sl.zsl_id zsl1, MONTH
--FROM(
--select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, zsl.DATE_Z_1, zsl.DATE_Z_2, zsl.OS_SLUCH_REGION, sl.PROFIL
--            FROM D3_ZSL zsl
--		    join D3_SL sl on sl.d3_zslid=zsl.id
--            join SCHET sc on zsl.D3_SCID = sc.ID
--            JOIN PACIENT AS pa ON pa.id = zsl.D3_PID           
--            where sl.USL_OK = 3 and zsl.D3_SCID = @p1 AND zsl.OS_SLUCH_REGION IS NULL AND p_cel = '3.0'
--) AS t_pol
--JOIN (
--	select zsl.id zsl_id, sl.ID sl_id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, zsl.DATE_Z_1, zsl.DATE_Z_2, zsl.OS_SLUCH_REGION, sl.PROFIL, sc.MONTH
--            FROM D3_ZSL zsl
--		    join D3_SL sl on sl.d3_zslid=zsl.id
--            join SCHET sc on zsl.D3_SCID = sc.ID
--            JOIN PACIENT AS pa ON pa.id = zsl.D3_PID           
--            where sl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL AND p_cel IN ( '3.0') AND sc.year = 2018
--) AS sl ON sl.FAM = t_pol.FAM AND sl.IM = t_pol.IM AND sl.OT = t_pol.OT AND sl.DR = t_pol.DR AND sl.DS1 = t_pol.DS1 AND sl.zsl_id <> t_pol.zsl_id AND sl.PROFIL = t_pol.PROFIL
--WHERE  t_pol.DATE_Z_1 = sl.DATE_Z_1 AND t_pol.DATE_Z_2 = sl.DATE_Z_2)  as t on dz.id = t.zsl_id