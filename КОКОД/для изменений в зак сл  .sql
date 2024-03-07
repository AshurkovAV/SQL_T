UPDATE s  SET kd=26,
----  VB_P=1
 date_1='20211110'
--BEGIN tran
--COMMIT tran
--DELETE s

--UPDATE zs SET kd_z=26,
----  VB_P=1
--    date_z_1='20211110'
----               date_z_2=date_2,
----               rslt=101 
--   pr_nov=0
--SELECT sch.id,zs.id zslid,zsl_id,s.id slid,ds1, ksg.n_ksg,date_1, date_2, date_z_1, date_z_2, rslt,sum_m, zs.PR_NOV, kd_z, kd, zs.VB_P, rslt



FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2021 
--AND sch.id IN (3540)
             -- (3540)
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
LEFT JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
WHERE --s.id=3522324
zs.id=3729835 --AND s.id=2610844