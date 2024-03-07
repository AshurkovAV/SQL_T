declare @p1 int=751
--В.М. 23/12/19 Добивл в тип USL_TIP in (5) onk.DS1_T NOT  0,1,2
--Наташа вынесла онкоуслугу с типом 6 в отдельную проверку, что есть только одна услуга с типом 6 и тогда повод только 5
--declare @p1 int = 2525

select
	zs.id as ID, zs.sumv  as SUMV,'' com-- 'Тип онкоуслуги не соответствует поводу обращения в онкослучае
	--zs.ID,
	--,ou.USL_TIP --тип онкоуслуги
	--,onk.DS1_T --повод обращения в онкослучае
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join D3_ONK_SL_OMS onk on onk.D3_SLID=sl.id
		inner join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
WHERE 
	p.D3_SCID = @p1
	and
	(
		(ou.USL_TIP=1 AND onk.DS1_T NOT IN (0,1,2,5,6)
		)
	OR 
		(ou.USL_TIP in (2,3,4) AND onk.DS1_T NOT IN (0,1,2)
		)
	OR 
		(ou.USL_TIP in (5) AND onk.DS1_T NOT IN (0,1,2,6)
		)
	
	)
group by zs.id, zs.SUMV

union

--нахожу тех, у кого есть только одна онкоуслуга с типом 6, а повод при этом не 5-диагностика
select
	zs.id as ID, zs.sumv  as SUMV,'' com--,SUM(CASE WHEN ou.USL_TIP in (6) THEN 1 ELSE 0 END),count(ou.ID)
	--, onk.DS1_T-- 'Тип онкоуслуги не соответствует поводу обращения в онкослучае
	--zs.ID,
	--,usl.CODE_USL,y.Name
	--ou.USL_TIP,COUNT(*) --тип онкоуслуги
	--,onk.DS1_T --повод обращения в онкослучае
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join D3_ONK_SL_OMS onk on onk.D3_SLID=sl.id
		inner join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
		--LEFT JOIN d3_usl_oms usl on usl.D3_SLID=sl.id
		--LEFT JOIN Yamed_Spr_UslCode y ON y.ID=usl.CODE_USL
WHERE 
	p.D3_SCID = @p1
	AND onk.DS1_T<>5
group by zs.id, zs.SUMV, onk.DS1_T
HAVING SUM(CASE WHEN ou.USL_TIP in (6) THEN 1 ELSE 0 END)= count( ou.ID )
