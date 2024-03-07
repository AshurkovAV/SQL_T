WITH cre AS(
select date_z_2,

zs.id,p.fam,p.im,p.ot,p.dr, p.smo

,ds1
, iddokt	,kp.fam+' '+kp.im+' '+kp.ot [врач]--, usl.CODE_USL
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021-- or sch.id  IN (1291))
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=s.id 
LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
WHERE zs.USL_OK=3 AND (date_2='20210918'  OR date_2='20210925' ) AND usl.id IS null
)

--выбираем тех, кто был потом повторно
--SELECT DISTINCT * FROM cre AS c
--LEFT JOIN
--(select date_z_2,

--zs.id,p.fam,p.im,p.ot,p.dr

--,ds1
--, iddokt	,kp.fam+' '+kp.im+' '+kp.ot [врач], usl.CODE_USL
--FROM [D3_SCHET_OMS] sch                  
--  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
--  and sch.year=2021 and sch.month=9-- or sch.id  IN (1291))
--  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
-- join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
-- LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=s.id 
--LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
--WHERE zs.USL_OK=3 ) t ON t.fam=c.fam AND t.im=c.im AND t.ot=c.ot AND t.dr=c.dr AND t.date_z_2>c.date_z_2 AND c.id<>t.id

--WHERE t.id IS NOT null

--выбираем иногородних
SELECT DISTINCT * FROM cre 
 WHERE smo not LIKE '46%'