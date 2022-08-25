DECLARE @D3_SCID INT = 2077

------несоответствие диагноза полу
select zsl.ID,
pa.FAM,PA.im,pa.ot,zsl.date_z_1,zsl.DATE_Z_2,
 zsl.SUMV, 'Мужские болезни у женщин' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
where zsl.D3_SCID = @D3_SCID and pa.W=2  and ( ds1 in ('D07.4', 'D07.5', 'D07.6')
	or ds1 like 'C60%' or ds1 like 'C61%' or ds1 like 'C62%' or ds1 like 'C63%' or ds1 like 'D29%' or ds1 like 'D40%'
	or ds1 like 'E29%' or ds1 like 'Q53%' or ds1 like 'Q54%' or ds1 like 'Q55%' or ds1 like 'N41%' or ds1 like 'N42%'
	or ds1 like 'N43%' or ds1 like 'N44%' or ds1 like 'N45%' or ds1 like 'N46%' or ds1 like 'N47%' or ds1 like 'N48%'
	or ds1 like 'N49%' or ds1 like 'N50%' or ds1 like 'N51%' or ds1 like 'Q53%' or ds1 like 'Q54%' or ds1 like 'Q55%')	
--group by zsl.ID, zsl.SUMV
union
select zsl.ID,
pa.FAM,PA.im,pa.ot,zsl.date_z_1,zsl.DATE_Z_2,
 zsl.SUMV, 'Женские болезни у мужчин' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN d3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
where zsl.D3_SCID = @D3_SCID and pa.W=1  and (ds1 in ('C79.6', 'D07.1', 'D07.2', 'D07.3', 'D07.0', 'E28.0', 'Е28.2', 'E28.3', 'T28.8')
	or ds1 like 'C51%' or ds1 like 'C52%' or ds1 like 'C53%' or ds1 like 'C54%' or ds1 like 'C55%' or ds1 like 'C56%' 
	or ds1 like 'C57%' or ds1 like 'C58%' or ds1 like 'D06%' or ds1 like 'D25%' or ds1 like 'D26%' 
	or ds1 like 'D27%' or ds1 like 'D28%' or ds1 like 'D39%' or ds1 like 'N7%'  or ds1 like 'N8%'  or (ds1 like 'N9%' and  ds1 not like 'N99%')
	or ds1 like 'O%'   or ds1 like 'Q50%' or ds1 like 'Q51%' or ds1 like 'Q52%'
	or (ds1 like 'Z31%' and ds1 not like 'Z31.1.8' and ds1 not like 'Z31.1.9' and ds1 not like 'Z31.3%'	and
		ds1	not like 'Z31.4%' and ds1 not like 'Z31.5%' and ds1 not like 'Z31.6%')
	or ds1 like 'Z30%' or  ds1 like 'Z32%' or ds1 like 'Z33%' or ds1 like 'Z34%' or ds1 like 'Z35%'
	or ds1 like 'Z36%' or ds1 like 'Z37%' or ds1 like 'Z39%')
--group by zsl.ID, zsl.SUMV