update zs set zs.npr_mo='460061'
--select zs.id, zs.npr_mo, zs.npr_date
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061

 where sch.year=2023 and sch.month=12 --and zs.npr_mo='460016'-- and month(zs.npr_date)=9
 and zs.EXP_COMENT LIKE  '%В направляющей МО можно указывать только действующие МО;%'