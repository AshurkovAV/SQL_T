DECLARE @D3_SCID INT = 2071
-------пустая дата в услуге
select zsl.ID,
--pa.FAM,PA.im,pa.ot,zsl.date_z_1,zsl.DATE_Z_2,
 zsl.SUMV, convert(nvarchar(3),isnull(zsl.os_sluch_region,'')) com
FROM D3_ZSL zsl
--JOIN PACIENT pa on zsl.D3_PID = pa.ID
join D3_SL sl on sl.d3_zslid=zsl.id
join D3_USL u on sl.ID = u.D3_SLID
where zsl.D3_SCID = @D3_SCID and (u.DATE_IN is null or u.DATE_OUT is null) and ((zsl.os_sluch_region<>9 and zsl.os_sluch_region<>22) or zsl.os_sluch_region is null)
group by zsl.ID, zsl.SUMV, zsl.os_sluch_region