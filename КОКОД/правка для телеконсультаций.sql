--UPDATE usl SET usl.SUMV_USL=415.30
--UPDATE s SET s.tarif=0,s.sum_m=415.30
--UPDATE zs SET zs.sumv=415.30
SELECT sch.id,sch.SchetType,  zs.id,P.FAM,  p.npolis,ZS.DATE_Z_1, ZS.DATE_Z_2,s.profil, s.iddokt,code_usl,
 zs.SUMV,s.TARIF,s.SUM_M,usl.SUMV_USL,usl.TARIF
--INTO ztemp_digCdelete
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=4--- AND sch.id not IN (210)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND ZS.USL_OK IN (3)
  JOIN d3_usl_oms usl ON usl.D3_SLID=s.id AND usl.code_usl LIKE 'R03%'