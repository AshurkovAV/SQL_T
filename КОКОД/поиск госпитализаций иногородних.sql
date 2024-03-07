 select sch.id,zs.usl_ok,s.nhistory,p.fam,p.im,p.ot,zs.date_z_1,zs.date_z_2, zs.npr_mo,zs.npr_date
--в химиотерапии не заполнена площадь поверхности тела
--,ksg.N_KSG--,'' com 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  --and sch.year=2019 and sch.month=1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  -- and zs.usl_ok in (1,2)      
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
-- join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
-- join d3_onk_usl_oms ou on ou.D3_ONKSLID=onk.id
 where sch.year=2020 and sch.month=5 and p.smo not like '46%'
       and 
	  zs.usl_ok in (1,2)