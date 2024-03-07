SELECT distinct sch.id, zs.id,s.nhistory, zs.NPR_MO, f003.nam_mok,usl.CODE_USL, usl.VID_VME,u.name, p.npolis,usl.DATE_IN, p.fam,p.im,isnull(p.ot,'') ot,zs.D3_SCID AS zs_schid,p.D3_SCID AS p_schid
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024 and   sch.id   IN (18443,18444)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
JOIN(
select usl.CODE_USL, usl.VID_VMe, isnull(p.npolis, p.ENP) npolis ,usl.DATE_IN,COUNT(*) kol_vo
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024 and    sch.id   IN (18443,18444)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20241231')
where isnull(p.npolis, p.ENP)<>''
GROUP BY  usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD, isnull(p.npolis, p.ENP),usl.DATE_IN
HAVING COUNT(*)>1
) t ON t.npolis=isnull(p.NPOLIS, p.enp) AND t.CODE_USL=usl.CODE_USL
ORDER BY npolis, usl.CODE_USL, usl.VID_VME,usl.date_in

