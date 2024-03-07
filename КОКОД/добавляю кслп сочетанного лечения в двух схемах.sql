--BEGIN tran
--DELETE SlKoEf
--UPDATE s SET s.sum_m=zs.sumv, s.it_sl=1.32000, s.sl_k=1
--UPDATE Ksg SET Ksg.it_sl=1.32, Ksg.sl_k=1
--UPDATE zs SET zs.sumv=ROUND((sumv/1.02)*1.32,2)
--INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
--      ,[D3_KSGGID]
--      ,[IDSL]
--      ,[Z_SL])
--SELECT distinct ksg.ID, ksg.KSG_ID, 81, 1.3000
--distinct zs.ID, zs.SUMV,-- cr.crit,
--ksg.id, ksg.KSG_ID,ksg.SL_K,ksg.IT_SL,  dsko.*--,lp.*
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=9-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND zs.id=12357983
--join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
--left join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
--join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
LEFT JOIN D3_SL_KOEF_OMS AS dsko ON dsko.D3_KSGID = ksg.id

where zs.id=770351

--WHERE zs.id IN (
--Select DISTINCT  zs.ID--, zs.SUMV, '' com--,SUM(CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end)
----zs.lpu,sch.month,s.nhistory,zs.id zslid,ksg.N_KSG,cr.crit, lp.code_sh, CASE WHEN cr.crit= lp.code_sh THEN 1 ELSE 0 end
--FROM [D3_SCHET_OMS] sch                  
--join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2020 AND sch.month=4-- AND sch.code_mo=460061
--join D3_ZSL_OMS zs on zs.D3_PID=p.id 
--join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND zs.id=12357983
--join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
----join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
--join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
--join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
--WHERE cr.CRIT NOT LIKE 'нет' AND cr.CRIT LIKE '%sh%' AND zs.USL_OK=1
--GROUP BY zs.ID, zs.SUMV,onk.ID,ou.ID
--HAVING COUNT(*)>1) AND YEAR(zs.DATE_Z_2)=2020 AND MONTH(zs.DATE_Z_2)=4---OR dsko.IDSL=81