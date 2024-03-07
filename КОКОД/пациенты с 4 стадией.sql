		
Select distinct p.fam,p.im,p.ot,p.dr,p.npolis,ds1,m001.ds_name,kod_st, max(date_z_2)	[послед посещение]		
FROM [D3_SCHET_OMS] sch			
join D3_PACIENT_OMS p on p.d3_scid=sch.id 			
			and sch.year=2022 and sch.month=6
			--and sch.id=@p1
			and sch.id in (6988,6989)
join D3_ZSL_OMS zs on zs.D3_PID=p.id-- AND zs.usl_ok IN (1,2) --AND p.smo=46006			
join D3_SL_OMS s on s.D3_ZSLID=zs.ID			
			
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id--	AND DS1_T IN (0,1,2)		
  join n002 on n002.id_st=stad			
  left join m001_oplata_status m001 on m001.idds=ds1			
  where			
 (kod_st like 'IV%')-- or kod_st like 'III%') and 			
   --ds1 like 'C73%'		
  AND  dbo.f_digit_only(iddokt)=15577536404	
  group by p.fam,p.im,p.ot,p.dr,p.npolis,ds1,m001.ds_name,kod_st			
  order by p.fam,p.im,p.ot,p.dr,p.npolis			
