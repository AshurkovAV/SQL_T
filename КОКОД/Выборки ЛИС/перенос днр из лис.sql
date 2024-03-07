SELECT distinct --sch.id AS schid_old,usl.CODE_USL,zs.id AS zslid,p.ID AS pid,p.fam,p.im,p.ot,p.dr, usl.VID_VMe, p.npolis,usl.DATE_IN,usl.DATE_OUT,zs.sumv
zs.id izslid, s.id slid,p.ID D3_PID
INTO ztemp_lis_dnr_072022
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=7 AND   sch.id   IN (8221)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
WHERE npolis LIKE '%днр%' OR npolis LIKE '%нет%'