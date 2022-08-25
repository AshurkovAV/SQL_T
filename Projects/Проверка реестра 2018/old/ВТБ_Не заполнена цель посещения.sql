--Не заполнена цель посещения'
declare  @p1 int
Set  @p1=2077
SELECT zsl.ID, zsl.SUMV, 'Не заполнена цель посещения' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID = @p1 and zsl.USL_OK = 3
		and sl.P_CEL is null
group by zsl.ID, zsl.SUMV