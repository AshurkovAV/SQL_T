--BEGIN TRAN --commit tran
--update s SET ds_onk=NULL
--DELETE dss
SELECT distinct s.ds1, dss.ds, dss.DS_TYPE
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.[MONTH]=6 --and sch.id in (7041)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 LEFT JOIN D3_DSS_OMS AS dss ON dss.D3_SLID=s.id
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 --left join D3_CONS_OMS cons on cons.D3_slid=s.id
WHERE zs.id=7354266 --AND ds='N40'