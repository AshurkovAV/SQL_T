SELECT distinct sch.id AS schid_old,zs.id AS zslid,p.ID AS pid,zs.ZSL_ID,p.fam,p.im,p.ot,p.dr,  p.npolis,zs.sumv, tkv.SchetType
INTO temp_kokod_V_9_H
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021   and sch.month in (9) and sch.id IN (3196,3195)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN temp_kokod_V_9_1 AS tkv ON tkv.ZSL_ID = zs.ZSL_ID
WHERE sch.id=3195



 
 
 
