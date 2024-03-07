SELECT distinct sch.id,month(ZS.DATE_Z_2),s.p_cel25,idsp,s.profil,v002.PRName, sumv
--,code_usl
, zs.OS_SLUCH_REGION

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=1 AND sch.id IN (171)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND ZS.USL_OK IN (3)
 --JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.ID
 LEFT JOIN v002 ON v002.IDPR=s.PROFIL
ORDER BY v002.PRName