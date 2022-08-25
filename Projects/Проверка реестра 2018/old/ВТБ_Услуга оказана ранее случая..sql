DECLARE @D3_SCID INT = 2071

--Услуга оказана ранее случая.
select zsl.ID, zsl.SUMV, 'Услуга оказана ранее случая.' com
FROM D3_ZSL zsl
join D3_SL sl on sl.d3_zslid=zsl.id
join D3_USL u on sl.id = u.D3_SLID
where zsl.D3_SCID = @D3_SCID and OS_SLUCH_REGION is NULL and (u.DATE_IN < sl.DATE_1 or u.DATE_OUT < sl.DATE_1) AND u.NPL != 4
group by zsl.id, zsl.SUMV