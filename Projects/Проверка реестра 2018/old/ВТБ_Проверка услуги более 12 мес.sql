--Проверка услуги более 12 мес
declare @p1 int=2077
select zsl.ID, zsl.SUMV, 'Услуга оказана более 12 месяцев назад.' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and 
	  (datediff(day, u.DATE_OUT,  sl.DATE_2)>365 and u.VID_VME not like 'A06.09.006%'  
	  	and u.VID_VME not like 'A06.20.004' and u.VID_VME not like 'A08.20.017%')
group by zsl.id, zsl.SUMV
union
--Проверка флюорографии
select zsl.ID, zsl.SUMV, 'Флюорография сделана более 24 месяцев назад.' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and 
	  datediff(day, u.DATE_OUT,  sl.DATE_2)>730 and u.VID_VME like 'A06.09.006%'
group by zsl.id, zsl.SUMV
union
--Проверка маммографии
select zsl.ID, zsl.SUMV, 'Маммография сделана более 24 месяцев назад.' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and 
	  datediff(day, u.DATE_OUT,  sl.DATE_2)>730 and u.VID_VME like 'A06.20.004'

group by zsl.id, zsl.SUMV
union
--Проверка соскоба матки
select zsl.ID, zsl.SUMV, 'Получение мазка с шейки матки (цервикального мазка) было более 3 лет назад' com 
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
join D3_USL_OMS u on sl.id = u.D3_SLID
where zsl.D3_SCID = @p1 and zsl.OS_SLUCH_REGION in(7,9,11,13,15,17,22) and u.NPL = 4 and
	  datediff(day, u.DATE_OUT,  sl.DATE_2)>1096 and u.CODE_USL like 'A08.20.017%' 
group by zsl.id, zsl.SUMV