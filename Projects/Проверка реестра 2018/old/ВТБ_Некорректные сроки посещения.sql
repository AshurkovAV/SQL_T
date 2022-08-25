--Некорректные сроки посещения
select zsl.id, zsl.SUMV, 'Некорректные сроки посещения' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
WHERE zsl.D3_SCID =2077 and zsl.USL_OK = 3 and OS_SLUCH_REGION is NULL and DATE_1 <> DATE_2
group by zsl.id, zsl.SUMV