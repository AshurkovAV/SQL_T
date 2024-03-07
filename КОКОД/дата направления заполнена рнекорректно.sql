SELECT sch.id,zs.id,P.FAM,  p.npolis,ZS.DATE_Z_1, ZS.DATE_Z_2,zs.NPR_DATE

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=4 --AND sch.id IN (160,166,167)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
WHERE YEAR(npr_date)<2019