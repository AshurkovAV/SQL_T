--S_sum=ÁÑ*koef_z*((1-ÄÇÏ/100)+ (ÄÇÏ/100)*koef_u*it_sl*koef_up)


SELECT distinct spr.nksg,v023.N_KSG,round(cast(bs.BZTSZ as float)*koef_z*((1-dzp.d/100)+ (dzp.d/100)*u.upr*1*case when spr.nksg like 'st%' then 1.1 else 1 end),2) as [stoim_ksg 2021]
--distinct zs.ID, zs.SUMV,-- cr.crit,
--ksg.id, ksg.KSG_ID,ksg.SL_K,ksg.IT_SL,  dsko.*--,lp.*
FROM (select distinct dop_kr,nksg from SprKSGDecode where year(dbeg)=2021 and (dop_kr like 'sh%')) spr
 JOIN ksg_DZP dzp ON dzp.ksg=spr.nksg 
 join SprBZTSZ bs on bs.usl_ok=case when spr.nksg like 'st%' then 1 else 2 end and year(bs.dbeg)=2021                                  
                   --and s.date_2 between spr.dbeg and spr.dend

join v023 on v023.k_ksg=spr.nksg and year(datebeg)=2021
left join CalcUprk u on u.idksg=spr.nksg and year(tbeg)=2021

--select * from CalcUprk where year(tbeg)=2021
--select * from SprKSGDecode where year(dbeg)=2021 and (dop_kr like 'sh%')
