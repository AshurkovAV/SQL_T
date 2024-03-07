SELECT p.fam,p.im,p.ot,dsko.*
--distinct zs.ID, zs.SUMV,-- cr.crit,
--ksg.id, ksg.KSG_ID,ksg.SL_K,ksg.IT_SL,  dsko.*--,lp.*
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=3-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND zs.id=12357983
--join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
--left join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
--join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
 JOIN D3_SL_KOEF_OMS AS dsko ON dsko.D3_KSGID = ksg.id

where month(date_z_2)=3 and p.smo=46003--p.fam like ''
--and dsko.Z_SL=1.6
and p.fam like ''