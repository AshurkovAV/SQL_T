--update pa
--set pa.DOCNUM=NULL,pa.doctype=NULL,pa.DOCORG=NULL,pa.DOCDATE=NULL
select
	zs.id as ID,sl.nhistory,sl.tarif,sl.sum_m,sl.p_cel25, SUMV,os_sluch_region
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 

  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 
	where   sch.year=2020 and sch.month=4 AND sch.id not IN (324) and zs.usl_ok=3 and sl.p_cel25 like '3.0' --and os_sluch_region is null--and sl.tarif>sl.sum_m