UPDATE usl SET usl.ds='Z11.5'
--SELECT sch.id AS schid_old,usl.CODE_USL,zs.id AS zslid,p.ID AS pid,p.fam,p.im,p.ot,p.dr, usl.VID_VMe, p.npolis,usl.DATE_IN,usl.DATE_OUT,zs.sumv,s.profil,s.prvs,zs.npr_date,ds1,usl.DS--,
--zs.id izslid, s.id slid,p.ID D3_PID
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD
--t.DATE_Z_1, t.DATE_Z_2--,zs.D3_SCID AS zs_d3_schid,p.D3_SCID p_D3_SCID
--INTO ztemp_covid_102020
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=1-- AND sch.id  IN (1082)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id and code_usl  LIKE 'R01.001.007'