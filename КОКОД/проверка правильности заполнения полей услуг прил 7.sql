--UPDATE s SET s.p_cel=ms.p_cel25,s.p_cel25=ms.p_cel25
select sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD,ms.tarif,s.sum_m,ms.p_cel25,s.P_CEL

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=2 --AND sch.id IN (190)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20201231')
WHERE ms.tarif<>s.sum_m
OR ms.vidpom<>zs.VIDPOM
OR ms.profil<>s.PROFIL
OR ms.prvs<>s.PRVS
OR ms.for_pom<>zs.FOR_POM
OR ms.ishod<>zs.ISHOD
OR ms.rslt<>zs.RsLT
OR ms.p_cel25<>s.P_CEL
OR ms.idsp<>zs.IDSP
OR date_1<>date_2
OR date_in<>usl.DATE_OUT
OR date_in<>date_1
OR s.DATE_1<>zs.DATE_Z_1
