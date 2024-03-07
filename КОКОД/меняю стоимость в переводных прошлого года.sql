--BEGIN TRAN  --commit tran
--UPDATE s SET iddokt='029-796-491 19'
--UPDATE u SET code_md='029-796-491 19'
--UPDATE u SET u.code_usl='R01.001.027' --u.VID_VME LIKE 'A08.09.011'--1
--UPDATE u SET u.code_usl='R01.001.020' --u.VID_VME LIKE 'A12.05.123'--3
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A12.20.001'--719
--UPDATE u SET u.code_usl='R01.001.009' --u.VID_VME LIKE 'A26.06.033'--13
--UPDATE u SET u.code_usl='R01.001.007' --u.VID_VME LIKE 'A26.19.011'--67
--UPDATE s SET s.ds1 ='Z01.7'
--UPDATE zs SET ISHOD = 304
--UPDATE p SET p.smo='46007'
--UPDATE zs SET sump=NULL
--UPDATE p SET p.npolis='7758630820000225'
--UPDATE p SET p.vpolis=3
--UPDATE p SET p.im='ƒ¿Õ»À'


--UPDATE ksg SET bztsz=28003.89
--UPDATE zs SET sumv=sum_m
--UPDATE s SET tarif=97979.08, sum_m=round(97979.08*0.5,2)
Select --sum(sumv)

--s.iddokt,u.CODE_MD
distinct
 zs.id, zs.sumv,p.fam, s.DATE_1, s.DATE_2, s.TARIF, s.SUM_M,s.DS1,s.id, ksg.*
 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=11
 AND sch.YEAR=2024  

  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id
WHERE zs. id IN (29501810) --AND s.id=30110457
--,29498180,29501810)


