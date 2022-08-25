--Применение КСЛП в стационарозамещениии
SELECT zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL zsl
join D3_SL sl on sl.d3_zslid=zsl.id
WHERE sl.usl_ok<>1 and sl.IT_SL>1 and zsl.D3_SCID=2071
group by zsl.ID, zsl.SUMV