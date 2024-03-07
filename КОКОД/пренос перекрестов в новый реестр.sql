/*1262 - перекресты
1263 - Дубли
1264 - Протокольные
1264 - Дешевые*/

--UPDATE p 
--SET p.D3_SCID=1265


--UPDATE zs
--SET zs.D3_scid=1265

Select DISTINCT zs.ID,zs.SUMV, '' com,zs.D3_scid,p.D3_SCID--,SUM(CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end)

--zs.lpu,sch.month,s.nhistory,zs.id zslidksg.N_KSG,cr.crit, lp.code_sh, CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end

FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id --AND  sch.year=2020 AND sch.id=319-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id
--join temp_old_8 t on t.zsl_id=zs.ZSL_ID
--join ztemp_desh_Cdelete_082020 t on t.zslid=zs.id
join --ztemp_digCdelete_112020 
-- ztemp_desh_Cdelete_092020_ks_33
--ztemp_desh_Cdelete_092020_ks_50
--ztemp_covid_102020
ztemp_desh_Cdelete_112020
 t on t.zslid=zs.id

--select * from ztemp_desh_Cdelete_112020 where schettype='H' 