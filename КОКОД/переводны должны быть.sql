--if OBJECT_ID('ztemp_digCdelete_072021') is not null drop table ztemp_digCdelete_072021

--!!!!!!
SELECT distinct sch.code_mo [первая мо госпит],zs.usl_ok[1 усл ок],p.fam, p.im, p.ot, p.dr,p.npolis, s.ds1 [диагноз в первой госпит], zs.FOR_POM [1 formpom], zs.DATE_Z_1 [1 начало], zs.DATE_Z_2 [1 конец],v009.RMPNAME [результат в 1 госп], zs.sump, zs.sumv
, t.code_mo [2 мо госпит],t.usl_ok [2 усл ок],t.ds1 [диагноз в первой госпит], t.DATE_Z_1 [2 начало], t.DATE_Z_2 [2 конец], t.RMPNAME [результат в 2 госп],zs.FOR_POM [1 formpom],t.sumv,t.sump, zs.vidpom, t.vidpom
--INTO ztemp_digCdelete_102021_1
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021  AND sch.month>=10 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 LEFT JOIN v009 ON v009.IDRMP=zs.rslt

 
JOIN
(
SELECT distinct sch.code_mo,s.ds1, zs.id,zs.DATE_Z_1, zs.DATE_Z_2, p.npolis, v009.RMPNAME , s.NHISTORY, vidpom, sumv, sump, zs.USL_OK
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021  	 and sch.month=11-- AND sch.id IN (1275,1276,1278)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  LEFT JOIN v009 ON v009.IDRMP=zs.rslt
) t ON t.npolis=p.npolis AND t.date_z_1=zs.date_z_2 AND zs.id<>t.id AND zs.USL_OK<>t.USL_OK
--WHERE zs.DATE_Z_1
ORDER BY p.npolis
