UPDATE s SET s.P_CEL='1.0', s.P_CEL25='1.0',dn=null
--update onk set ds1_t=3
--SELECT sch.id,zs.id,P.FAM,  p.npolis,ZS.DATE_Z_1, ZS.DATE_Z_2,s.profil, s.iddokt,s.P_CEL,s.dn,
 --s.P_CEL25,onk.DS1_T
-- ,zs.SUMV,s.TARIF,s.SUM_M
--INTO ztemp_digCdelete
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=12-- AND sch.id  IN (900)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND ZS.USL_OK IN (3)
 LEFT JOIN d3_onk_sl_oms onk ON onk.D3_SLID=s.ID
  --JOIN d3_usl_oms usl ON usl.D3_SLID=s.id AND usl.code_usl LIKE 'R03%'
WHERE s.p_cel LIKE '1.3' OR s.p_cel25 LIKE '1.3' 
OR
s.dn IS NOT NULL
  OR
 onk.DS1_T=4