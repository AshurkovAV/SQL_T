DECLARE @D3_SCID INT = 2077
SELECT zsl.ID, zsl.SUMV, 'Перекрест случай услуга.' com
FROM D3_ZSL_OMS zsl
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join ( SELECT (CASE WHEN u.PROFIL in (2,3,136,137) THEN 990 ELSE u.PROFIL END) PROFIL, u.DATE_OUT, pa.FAM, pa.IM, pa.OT, pa.DR, u.d3_slid, u.ds, Zsl.USL_OK
	   FROM D3_USL_OMS u
	   join D3_SL_OMS sl on sl.id=u.d3_slid
	   join D3_ZSL_OMS zsl on sl.D3_ZSLID=zsl.id
	   join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	   where zsl.d3_SCID =@D3_SCID and zsl.USL_OK =3 
	 ) as u on pa.FAM = u.FAM and pa.IM = u.IM and pa.OT = u.OT and pa.DR = u.DR and sl.DATE_2 = u.DATE_OUT and sl.ds1=u.ds
			   and (CASE WHEN sl.PROFIL in (2,3,136,137) THEN 990 ELSE sl.PROFIL END) = u.PROFIL
where zsl.d3_SCID = @D3_SCID and zsl.USL_OK =3 and zsl.OS_SLUCH_REGION is null and sl.id<>u.d3_slid
GROUP BY zsl.ID, zsl.SUMV