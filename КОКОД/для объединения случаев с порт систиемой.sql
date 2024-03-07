update zs set SUMV=109705.73
--UPDATE ksg SET ksg.IT_SL=NULL,ksg.SL_K=0

--updATE s SET sum_m=ROUND(sum_m/1.3,2)
--select sch.id,zs.ID,SUMV,sum(sum_m)--,

--s.TARIF,zs.vb_p,s.p_per,sum_m,s.id,p.fam,zs.date_z_1,zs.date_z_2
--,ksg.N_KSG,s.date_1,s.date_2,ksg.IT_SL,ksg.SL_K
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.id=495--@p1
  --and sch.year=2019 and sch.month=1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2)      
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
  LEFT JOIN D3_SL_KOEF_OMS AS dsko
                 ON dsko.D3_KSGID = Ksg.ID
 --join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 --where s.nhistory in ('376/00883','1518/05756')
WHERE sch.id=685
-- s.nhistory in ('377/00884','1520/05755')
 --group by sch.id,zs.ID,SUMV