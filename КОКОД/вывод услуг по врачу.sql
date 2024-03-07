SELECT --COUNT(DISTINCT zs.id)	
--sch.month,sch.id,nhistory--,
--sch.id,
 distinct zs.id,iddokt,k.[FIO],p.fam,p.im,p.ot,usl.code_usl,m.[name],usl.vid_vme--,count(zs.zsl_id),count(distinct zs.id) as ID, sum(zs.sumv) as SUMV	
FROM  D3_SCHET_OMS sch                      	
  inner join  [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID] --AND sch.[YEAR]=2019 AND sch.month=8	
  inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]   	
    join  D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 	
	join d3_usl_oms usl on usl.D3_SLID=sl.id
	left join [medicalServices] m on m.[code_usl]=usl.[code_usl] 
	left join [KOKOD_PODR] k on k.[IDDOCT]=dbo.f_digit_only( iddokt)
	where (usl.code_usl like 'R01%')  AND sch.year=2020  and sch.code_mo=460061 AND sch.id IN (392) 
--group by iddokt,k.[FIO], usl.code_usl,m.[name]
order by iddokt,k.[FIO], usl.code_usl,m.[name]
--R01.001.002 לנע