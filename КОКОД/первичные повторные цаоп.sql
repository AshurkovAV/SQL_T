WITH app AS (
SELECT p.FAM, p.IM, p.OT, p.DR,p.npolis,usl.DATE_IN,iddokt
			,kp.fam+' '+kp.im+' '+kp.ot [doctor], usl.id

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
 LEFT JOIN D3_USL_OMS usl ON usl.D3_SLID=s.ID
 LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok	
 
WHERE sch.id IN (9480,9397--январь сдан плюс мэк,
                 ,9605,9439,9606--февраль
                 ,10676,9591--март
                 )

AND zs.OS_SLUCH_REGION IN (58,63)
)
--SELECT * FROM app
SELECT iddokt,doctor,pr,COUNT(ID) kol_vo
FROM      (
			SELECT t1.*, CASE WHEN t2.fam IS NOT NULL THEN 'первично' else 'повторно' END pr
			FROM app t1
			LEFT JOIN temp_pervich_app_2023_1_3 t2  ON t2.npolis = t1.npolis-- AND t1.date_2=t2.date_min
) t
GROUP BY iddokt,doctor,pr