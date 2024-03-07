select --sch.id,p.fam,p.im,p.ot,s.nhistory,s.IDDOKT, s.ds1,s.DATE_1,usl.code_usl, usl.VID_VME,u.Name
count(zs.id),sum(zs.sumv)
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=9 AND sch.id not IN (881,895,903)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u on u.id=usl.vid_vme 
 LEFT JOIN KOKOD_PODR AS kp ON kp.IDDOCT=dbo.p_digit_only(s.IDDOKT)
WHERE usl.VID_VME LIKE 'A07.06.006' or usl.VID_VME LIKE 'A07.03.003.001' 
--ORDER BY p.npolis,date_1