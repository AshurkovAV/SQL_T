SELECT sch.id,zs.id,P.FAM, p.im, p.npolis,p.smo,s.nhistory,ZS.DATE_Z_1, ZS.DATE_Z_2,s.profil, s.iddokt,code_usl,
--zs.id izslid, s.id slid,p.ID D3_PID
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD
t.DATE_Z_1, t.DATE_Z_2,zs.d3_scid zs_schid_app,t.zs_schid_st,p.d3_scid
--INTO ztemp_digCdelete
from d3_zsl_oms zs
join D3_PACIENT_OMS p on zs.d3_pid = p.id 
join  [D3_SCHET_OMS] sch on sch.id = zs.d3_scid and sch.year=2021 and sch.month=3  AND    sch.id IN (2008,2020, 2021)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND ZS.USL_OK IN (3)
 LEFT JOIN d3_usl_oms usl ON usl.D3_SLID=s.id 
--LEFT JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231')
JOIN
(
select sch.id AS schit, zs.id,zs.DATE_Z_1, zs.DATE_Z_2, p.npolis,zs.d3_scid zs_schid_st
from d3_zsl_oms zs
join D3_PACIENT_OMS p on zs.d3_pid = p.id 
join  [D3_SCHET_OMS] sch on sch.id = zs.d3_scid  and sch.year=2021 and sch.month=3 AND    sch.id IN (2008,2020, 2021)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
WHERE zs.usl_ok in ( 1,2)
) t ON t.npolis=p.npolis AND ((t.date_z_1<ZS.DATE_Z_1 AND ZS.DATE_Z_1<t.DATE_Z_2) OR (t.date_z_1<ZS.DATE_Z_2 AND ZS.DATE_Z_2<t.DATE_Z_2))
WHERE code_usl  IS NULL