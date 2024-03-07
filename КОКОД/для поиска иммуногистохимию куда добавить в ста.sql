

select sch.id AS schit, zs.id,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,t.*
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=3-- AND sch.id not IN (210)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 LEFT JOIN  temp_gist_032020 t ON (t.polis=p.npolis OR (p.fam=t.fam AND p.im=p.im AND p.ot=t.ot AND p.dr=t.dr)) AND t.date_v>=zs.DATE_Z_1 AND t.date_v<=zs.DATE_Z_2
WHERE t.fam IS NOT null
 
 
-- SELECT * FROM temp_gist_032020
