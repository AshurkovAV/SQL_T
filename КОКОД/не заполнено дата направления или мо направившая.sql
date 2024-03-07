Select DISTINCT  sch.id,zs.ID,s.nhistory, zs.sumv,npr_mo,npr_date,date_z_1--,cr.crit,ou.*--,lp.* --, zs.SUMV, '' com--,SUM(CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end)
--zs.lpu,sch.month,s.nhistory,zs.id zslidksg.N_KSG,cr.crit, lp.code_sh, CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=5-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
where npr_date is not null and npr_mo is null or npr_date is  null and npr_mo is not null
