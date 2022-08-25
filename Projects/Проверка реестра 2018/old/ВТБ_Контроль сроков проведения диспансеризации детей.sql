--Контроль сроков проведения диспансеризации детей
declare @p1 int=2077
select zsl.ID, zsl.SUMV, '' com
FROM D3_ZSL_OMS zsl
where zsl.D3_SCID = @p1 and  OS_SLUCH_REGION in (7,17)	and DATEDIFF(DAY, zsl.DATE_Z_1, zsl.DATE_Z_2) > 14