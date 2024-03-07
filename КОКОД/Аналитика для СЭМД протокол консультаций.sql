Select iddokt,kp.fam+' '+kp.im+' '+kp.ot [врач],count(distinct zs.id) [количество поданных законченных случаев],
--, sl.id, zs.OS_SLUCH_REGION, usl.id
COUNT(distinct CASE WHEN zs.os_sluch_region IN (56,57) THEN usl.id
	  else sl.id end ) [количество поданных случаев, по которым должны сформироватьс€ —Ёћƒ протокол осмотра]
  

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
  INNER JOIN D3_SL_OMS sl ON sl.D3_ZSLID=zs.id
 LEFT JOIN D3_USL_OMS usl ON usl.D3_SLID=sl.id

join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
	LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
WHERE   sch.month=11
 AND sch.YEAR=2023  
 --and   sch.id in  (11837,14895)
and zs.usl_ok=3 
AND MONTH(zs.DATE_Z_2)=11
AND zs.idsp IN (29,30) 
AND sch.code_mo=460061 
and (zs.os_sluch_region IS NULL OR zs.os_sluch_region NOT IN (59,63))
GROUP BY iddokt,kp.fam+' '+kp.im+' '+kp.ot
--10278	10463


--SELECT count(distinct zs.id), count(distinct sl.id), count(distinct usl.id)

--FROM [D3_SCHET_OMS] sch                  
-- inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
-- inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
--  INNER JOIN D3_SL_OMS sl ON sl.D3_ZSLID=zs.id
-- LEFT JOIN D3_USL_OMS usl ON usl.D3_SLID=sl.id

--join V009 rz on rz.IDRMP=zs.RSLT
--left join F011 doc on doc.Id=p.DOCTYPE
--WHERE   sch.month=5
-- AND sch.YEAR=2023  
-- and   sch.id in  (11837,14895)
--and zs.usl_ok=3 
--AND MONTH(zs.DATE_Z_2)=5 
--AND zs.idsp IN (29,30) 
--AND sch.code_mo=460061 
--and zs.os_sluch_region IN (59,56,57,63) 

--все случаи, где более 1 услуги
--SELECT sch.id,sl.ID, zs.id,count(distinct zs.id), count(distinct sl.id), count(distinct usl.id)

--FROM [D3_SCHET_OMS] sch                  
-- inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
-- inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
--  INNER JOIN D3_SL_OMS sl ON sl.D3_ZSLID=zs.id
-- LEFT JOIN D3_USL_OMS usl ON usl.D3_SLID=sl.id

--join V009 rz on rz.IDRMP=zs.RSLT
--left join F011 doc on doc.Id=p.DOCTYPE
--WHERE   sch.month=5
-- AND sch.YEAR=2023  
-- and   sch.id in  (11837,14895)
--and zs.usl_ok=3 
--AND MONTH(zs.DATE_Z_2)=5 
--AND zs.idsp IN (29,30) 
--AND sch.code_mo=460061 
--and zs.os_sluch_region IN (59,56,57,63) 
--GROUP BY sch.id,zs.id,sl.ID
--HAVING COUNT(*)>1
--ORDER BY count(distinct usl.id)

