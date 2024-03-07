SELECT distinct sch.id AS shit,sch.nschet,zs.ID AS zslid,  lek.code_sh, date_z_1, date_z_2, s.NHISTORY, p.fam, p.im, p.ot, p.dr--, sank.* 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
 --left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 			
				--on sank.[D3_ZSLID]=zs.id
				--and sank.s_tip=1
WHERE p.fam LIKE 'Штурнева' AND p.im LIKE 'Ирина' AND p.ot LIKE 'Витальевна'
 