
SELECT sch.id,sch.month,zs.id,zsl_id


,p.fam,p.im,p.ot,p.dr,s.podr,zs.usl_ok,s.nhistory,date_1,date_2,date_z_1,date_z_2,ds1,npr_date,zs.EXP_COMENT,profil_k,npolis
--distinct zs.ID, zs.SUMV,-- cr.crit,
--ksg.id, ksg.KSG_ID,ksg.SL_K,ksg.IT_SL,  dsko.*--,lp.*
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2021 AND sch.month=4-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND zs.id=12357983
--join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
--left join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
left join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
left JOIN ksg_DZP dzp ON dzp.ksg=ksg.n_ksg and date_2 between dzp.datе_begin and dzp.date_end
 left join SprBZTSZ spr on spr.usl_ok=zs.USL_OK                                  
                    and s.date_2 between spr.dbeg and spr.dend

where zs.EXP_COMENT like '%Случай госпитализации не идентифицирован на портале АИС ТФОМС%' and sch.id in (2203)--,2204,2221) 
order by fam
