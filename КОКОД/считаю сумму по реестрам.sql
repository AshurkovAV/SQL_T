  
  select
	sch.year,sch.month,sch.id,sch.SchetType,count(zs.id),SUM(sumv)
	--,sl.METOD_HMP,sl.VID_HMP
	--, count(zs.id)
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
  WHERE sch.id IN (657,603,638,682)
  GROUP BY sch.year,sch.month,sch.SchetType,sch.id