select zs.id
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  --and sch.year=2019 and sch.month=1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  -- and zs.usl_ok in (1,2)      
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 join d3_onk_usl_oms ou on ou.D3_ONKSLID=onk.id
 join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
 where sch.code_mo=460061
      and sch.year=2020 
	  and sch.month=5
       and ou.usl_tip in (2,4) 
       and   lp.CODE_SH like 'sh348' 
 --AND onk.hei is NOT NULL 
 --and onk.bsa IS NOT NULL 
 --AND onk.BSA <>cast(SQRT(wei*hei/3600) AS NUMERIC(3,2))---<>1
