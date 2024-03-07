--BEGIN tran
--DELETE SlKoEf
---UPDATE s SET s.sum_m=zs.sumv, s.it_sl= Ksg.it_sl, s.sl_k=1
--UPDATE Ksg SET Ksg.it_sl=isnull(Ksg.it_sl,1)+0.04, Ksg.sl_k=1
--UPDATE zs SET zs.sumv=ROUND((zs.sumv*1.04),2)
--INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
--      ,[D3_KSGGID]
--      ,[IDSL]
--      ,[Z_SL])
Select-- distinct ksg.ID, ksg.KSG_ID, 141, 1.0400
distinct zs.ID, zs.SUMV,---ROUND((zs.sumv/ksg.it_sl)*(ksg.it_sl+0.04),2) AS sumv_et-- cr.crit,
ksg.id, ksg.KSG_ID,ksg.SL_K,ksg.IT_SL,usl.code_usl, usl.sumv_usl,  dsko.*
--INTO temp_perescher032020
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=4 AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND zs.id=12357983
--join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
--join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
--join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
JOIN d3_usl_oms usl ON usl.D3_SLID=s.ID and usl.CODE_USL='A08.30.013'
LEFT JOIN D3_SL_KOEF_OMS AS dsko ON dsko.D3_KSGID = ksg.id
WHERE zs.USL_OK=1  AND zs.id IN (347752,   350354 ,  346462, 348845, 348256 ,  351281)