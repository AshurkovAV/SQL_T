DECLARE @D3_SCID INT = 2077
--Перекрёст законченный случай - случай.
SELECT zsl.ID, zsl.SUMV, 'Перекрёст законченный случай - случай.' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join ( SELECT pa.FAM, pa.IM, pa.OT, pa.DR, sl.D3_ZSLID, sl.DATE_2, sl.ds1, sl.USL_OK, 
			(CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END) PROFIL
	   FROM D3_SL_OMS sl
	   join D3_ZSL_OMS zsl on sl.D3_ZSLID=zsl.id
	   join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	   where zsl.d3_SCID = @D3_SCID and zsl.USL_OK =3 
	 ) as u on pa.FAM = u.FAM and pa.IM = u.IM and pa.OT = u.OT and pa.DR = u.DR and sl.DATE_2 = u.DATE_2 and sl.ds1=u.ds1
				and (CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END)=u.PROFIL
where zsl.d3_SCID = @D3_SCID and zsl.USL_OK =3 and zsl.OS_SLUCH_REGION is null and zsl.id<>u.d3_zslid
GROUP BY zsl.ID, zsl.SUMV

UPDATE D3_ZSL_OMS SET D3_SCID = 2084, MEK_COMENT = 'Перекрёст законченный случай - случай.'
WHERE ID IN (
SELECT zsl.ID
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join ( SELECT pa.FAM, pa.IM, pa.OT, pa.DR, sl.D3_ZSLID, sl.DATE_2, sl.ds1, sl.USL_OK, 
			(CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END) PROFIL
	   FROM D3_SL_OMS sl
	   join D3_ZSL_OMS zsl on sl.D3_ZSLID=zsl.id
	   join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	   where zsl.d3_SCID = @D3_SCID and zsl.USL_OK =3 
	 ) as u on pa.FAM = u.FAM and pa.IM = u.IM and pa.OT = u.OT and pa.DR = u.DR and sl.DATE_2 = u.DATE_2 and sl.ds1=u.ds1
				and (CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END)=u.PROFIL
where zsl.d3_SCID = @D3_SCID and zsl.USL_OK =3 and zsl.OS_SLUCH_REGION is null and zsl.id<>u.d3_zslid
GROUP BY zsl.ID, zsl.SUMV)