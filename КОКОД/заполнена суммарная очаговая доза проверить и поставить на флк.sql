--003F.00.1040	ZL_LIST/ZAP/Z_SL/SL/ONK_SL/SOD	C, D, R, T		
--	USL_TIP<>{3, 4} во всех элементах ONK_USL, входящих в ONK_SL			
--			элемент должен отсутствовать при выполнении условия
Select zs.ID, zs.SUMV, '' com--, sch.month, sch.code_mo, sch.year
--zs.id, zs.sumv,
--onk.id
--onk_usl.USL_TIP,onk.SOD
--,SUM(CASE when onk_usl.USL_TIP IN (3,4) THEN 1 ELSE 0 end)
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id   
join D3_ZSL_OMS zs on zs.D3_PID=p.id
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  
left join D3_ONK_USL_OMS onk_usl on onk_usl.D3_ONKSLID=onk.id  
--join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id  
WHERE onk.SOD IS NOT NULL 
 and sch.id=@p1 
--AND s.nhistory LIKE '614/01457'
GROUP BY zs.id, zs.sumv,onk.id
HAVING SUM(CASE when onk_usl.USL_TIP IN (3,4) AND onk_usl.USL_TIP IS NOT null THEN 1 ELSE 0 end)=0