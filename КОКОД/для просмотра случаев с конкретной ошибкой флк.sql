
SELECT sch.id,sch.month,zs.id,zsl_id


,p.fam,p.im,p.ot,s.nhistory,sumv,ksg.n_ksg,round(ksg.BZTSZ*koef_z*((1-dzp.D/100)+ (dzp.D/100)*koef_u*isnull(ksg.it_sl,1)*koef_up),2)
,abs(s.sum_m-round(ksg.BZTSZ*koef_z*((1-dzp.D/100)+ (dzp.D/100)*koef_u*isnull(ksg.it_sl,1)*koef_up),2)), s.tarif-sumv,zs.EXP_COMENT
--distinct zs.ID, zs.SUMV,-- cr.crit,
--ksg.id, ksg.KSG_ID,ksg.SL_K,ksg.IT_SL,  dsko.*--,lp.*
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2021 AND sch.month=4-- AND sch.code_mo=460061
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  --AND zs.id=12357983
--join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
--left join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id
join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
left JOIN ksg_DZP dzp ON dzp.ksg=ksg.n_ksg and date_2 between dzp.datе_begin and dzp.date_end
 left join SprBZTSZ spr on spr.usl_ok=zs.USL_OK                                  
                    and s.date_2 between spr.dbeg and spr.dend

where zs.EXP_COMENT like '%Некорректный тариф (Тариф должен быть с учётом всех примененных коэффициентов )%' and sch.id=2206 and  s.tarif-sumv<>0
order by n_ksg