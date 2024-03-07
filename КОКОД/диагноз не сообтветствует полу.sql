select sch.id,zs.id,p.w,ds1,idsp,iddokt,profil, p.fam,s.nhistory,npolis, date_1
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and (sch.month=5)-- and sch.id IN (2427,2429,2428)-- or sch.id  IN (1291))
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 where (ds1 like 'C50%' or ds1 like 'C53%'or ds1 like 'C54%') and p.w=1
 or
 ds1 between 'C60%' and 'C63.z%' and p.w=2
 order by iddokt