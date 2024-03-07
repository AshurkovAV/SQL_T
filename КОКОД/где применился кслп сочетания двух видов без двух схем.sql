Select DISTINCT  sch.id,zs.ID,s.podr,s.nhistory--,cr.crit,ou.*--,lp.* --, zs.SUMV, '' com--,SUM(CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end)
--zs.lpu,sch.month,s.nhistory,zs.id zslidksg.N_KSG,cr.crit, lp.code_sh, CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=7 AND sch.id=445
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
 left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  AND zs.USL_OK=1
left join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
left join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
join D3_SL_KOEF_OMS k on k.D3_KSGID=ksg.id and k.IDSL=81
left join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
--left join 
--(Select DISTINCT zs.ID--, zs.SUMV, '' com--,SUM(CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end)
----zs.lpu,sch.month,s.nhistory,zs.id zslidksg.N_KSG,cr.crit, lp.code_sh, CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end
--FROM [D3_SCHET_OMS] sch                  
--join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=5--sch.id=341-- AND sch.code_mo=460061
--join D3_ZSL_OMS zs on zs.D3_PID=p.id 
--join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND zs.id=12357983
--join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
----join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
--join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
--join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
--WHERE cr.CRIT NOT LIKE 'нет' AND cr.CRIT LIKE '%sh%' AND zs.USL_OK=1
--GROUP BY sch.id,zs.ID, zs.SUMV,s.nhistory,onk.ID,ou.ID,ksg.IT_SL
--HAVING COUNT(*)>1) t on t.id=zs.id
--where t.id is null
--order by zs.ID