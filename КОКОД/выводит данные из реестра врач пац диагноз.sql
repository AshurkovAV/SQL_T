
SELECT distinct sch.id AS shit,zs.ID AS zslid,  s.IDDOKT, kp.fam+' '+kp.im+' '+kp.ot [врач], p.fam, p.im, p.ot, p.dr,ds1,date_2
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022  and sch.id in (8857)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (3) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   

 --join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
--WHERE onk.DS1_T=4 AND s.P_CEL25 NOT LIKE '1.3'
WHERE s.P_CEL25 LIKE '1.3' 
