--BEGIN TRAN --commit tran

--ставим всем состоит на учете при цели дисп наблюдение
UPDATE s SET dn=1
----Select zs.id as ID, zs.sumv as SUMV,s.P_CEL25,dn
--FROM [D3_SCHET_OMS] sch									
--  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id--and sch.month=11
--									and sch.year=2022   and sch.month in (4) --and sch.id IN (3274,3275,3279) --and sch.code_mo not like '460061'
-- inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
-- join D3_SL_OMS s on s.D3_ZSLID=zs.ID
--WHERE s.P_CEL25 LIKE '1.3' AND dn<>1

--всем , у кого категория пациента дисп наблюдение ставим цель 1,3
--UPDATE s SET dn=1
--P_cel25='1.3'
--select distinct sch.id,zs.id,p.fam, p.im, p.ot,date_z_1,date_z_2, s.P_CEL25, idsp,kp.fam+' '+kp.im+' '+kp.ot

--sch.id,zs.ID, s.id,lek.regnum,SUMV,lek.REGNUM, lek.CODE_SH, lek.REGNUM, n021.ID_LEKP, n21.ID_LEKP, CASE WHEN n021.ID_LEKP=n21.ID_LEKP THEN 1 ELSE 0 END 
--,ksg.N_KSG,'' com --Площадь поверхности тела расчитана неверно
--SELECT distinct sch.id AS shit,zs.ID AS zslid, s.id AS slid, dn, s.IDDOKT,s.NHISTORY
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=10 --and sch.id in (8231)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (3) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   

 --join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
--WHERE onk.DS1_T=4 AND s.P_CEL25 NOT LIKE '1.3'
WHERE s.P_CEL25 LIKE '1.3' 
--AND-- dn=1 
--AND s.IDDOKT LIKE '145-571-317 62'--
                                 AND  (s.dn IS NULL or dn<>1)