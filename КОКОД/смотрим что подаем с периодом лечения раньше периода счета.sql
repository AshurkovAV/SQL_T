--update zs set zs.pr_nov=1
Select DISTINCT  sch.id,zs.ID,s.nhistory, zs.sumv,ds_onk,date_z_1,zs.pr_nov,fam--,cr.crit,ou.*--,lp.* --, zs.SUMV, '' com--,SUM(CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end)
--zs.lpu,sch.month,s.nhistory,zs.id zslidksg.N_KSG,cr.crit, lp.code_sh, CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=7-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
where year(zs.date_z_2)<sch.year or month(zs.date_z_2)<sch.month --and sch.id=348
