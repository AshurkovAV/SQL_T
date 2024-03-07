
SELECT distinct sch.id AS shit,zs.ID AS zslid, s.id AS slid,
 ou.*,ou.ONKUSL_ID,ou.USL_TIP,  lek.*
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  --and sch.year=2020 and sch.month=9 and sch.id=894
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID-- AND ou.USL_TIP IN (2,4)
left JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
 WHERE ou.usl_tip in (2,4) --and lek.id is not null
  and zs.id=1179923