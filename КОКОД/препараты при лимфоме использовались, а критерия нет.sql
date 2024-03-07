select distinct sch.id AS shit,zs.ID AS zslid, s.id AS slid, ou.ID AS ouid,ksg.N_KSG,v23.[N_KSG],s.nhistory,lek.regnum,spr.[crit]

--sch.id,zs.ID, s.id,lek.regnum,SUMV,lek.REGNUM, lek.CODE_SH, lek.REGNUM, n021.ID_LEKP, n21.ID_LEKP, CASE WHEN n021.ID_LEKP=n21.ID_LEKP THEN 1 ELSE 0 END 
--,ksg.N_KSG,'' com --ѕлощадь поверхности тела расчитана неверно
--(SELECT distinct sch.id AS shit,zs.ID AS zslid, s.id AS slid, ou.ID AS ouid, lek.REGNUM, lek.code_sh
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and sch.month=2
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 left join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
   left join d3_crit_oms crit on crit.D3_KSGID=ksg.id
    left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
	left join IMP46_CRIT spr on spr.[code]=lek.regnum
   where ds1 between 'C81' and 'C96.z' and (crit.crit not like 'gem%'  or crit.id is null)
 --and lek.regnum in (select code from IMP46_CRIT)



   