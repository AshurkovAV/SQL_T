select   sch.id AS schit,sch.SchetType, zs.id zslid,s.podr,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,zs.vidpom,v23.NameWithID, zs.ishod,v12.IZNAME,v009.NameWithID v9, zs.sumv,zs.usl_ok
--into ztemp_desh_Cdelete_062020
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  --and sch.year=2019 and sch.month=1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  -- and zs.usl_ok in (1,2)      
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 join d3_onk_usl_oms ou on ou.D3_ONKSLID=onk.id
 join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
  left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
 where sch.code_mo=460061
      and sch.year=2020 
	  and sch.month=7
	 -- and sch.id=348
       and ou.usl_tip in (2,4) 
   --    and   lp.CODE_SH like 'sh348'
   and lp.regnum like '000438'